import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator_master/palette_generator_master.dart';
import 'package:visual_novel_observatory/vn/utils/image_cache_size.dart';

class VnCoverPalette {
  const VnCoverPalette({
    required this.primary,
    required this.secondary,
    required this.tertiary,
  });

  final Color primary;
  final Color secondary;
  final Color tertiary;

  ThemeData applyTo(ThemeData baseTheme) {
    final brightness = baseTheme.brightness;
    final baseScheme = baseTheme.colorScheme;
    final fittedPrimary = _fitAccentColor(
      primary,
      brightness: brightness,
      fallback: baseScheme.primary,
    );
    final fittedSecondary = _fitAccentColor(
      secondary,
      brightness: brightness,
      fallback: baseScheme.secondary,
    );
    final fittedTertiary = _fitAccentColor(
      tertiary,
      brightness: brightness,
      fallback: baseScheme.tertiary,
    );
    final generatedScheme = ColorScheme.fromSeed(
      seedColor: fittedPrimary,
      brightness: brightness,
    );
    final tintAlpha = brightness == Brightness.dark ? 0.10 : 0.10;
    final surfaceTintAlpha = brightness == Brightness.dark ? 0.12 : 0.15;
    final scaffoldBackgroundColor = Color.alphaBlend(
      fittedPrimary.withValues(alpha: tintAlpha),
      baseTheme.scaffoldBackgroundColor,
    );
    final cardColor = Color.alphaBlend(
      fittedPrimary.withValues(alpha: surfaceTintAlpha),
      baseTheme.cardColor,
    );
    final inputFillColor = Color.alphaBlend(
      fittedPrimary.withValues(alpha: surfaceTintAlpha),
      baseTheme.inputDecorationTheme.fillColor ??
          baseScheme.surfaceContainerHigh,
    );
    final colorScheme = baseScheme.copyWith(
      primary: fittedPrimary,
      onPrimary: _bestOnColor(fittedPrimary),
      primaryContainer: generatedScheme.primaryContainer,
      onPrimaryContainer: generatedScheme.onPrimaryContainer,
      secondary: fittedSecondary,
      onSecondary: _bestOnColor(fittedSecondary),
      secondaryContainer: generatedScheme.secondaryContainer,
      onSecondaryContainer: generatedScheme.onSecondaryContainer,
      tertiary: fittedTertiary,
      onTertiary: _bestOnColor(fittedTertiary),
      tertiaryContainer: generatedScheme.tertiaryContainer,
      onTertiaryContainer: generatedScheme.onTertiaryContainer,
      surface: cardColor,
      surfaceContainerHigh: inputFillColor,
    );

    return baseTheme.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      cardColor: cardColor,
      appBarTheme: baseTheme.appBarTheme.copyWith(
        backgroundColor: scaffoldBackgroundColor,
        foregroundColor: colorScheme.onSurface,
      ),
      inputDecorationTheme: baseTheme.inputDecorationTheme.copyWith(
        fillColor: inputFillColor,
      ),
    );
  }
}

final vnCoverPaletteProvider = FutureProvider.autoDispose
    .family<VnCoverPalette, String>((ref, imageUrl) async {
      return _generateCoverPalette(imageUrl);
    });

Future<VnCoverPalette> _generateCoverPalette(String imageUrl) async {
  final imageProvider = CachedNetworkImageProvider(
    imageUrl,
    maxWidth: coverImageMaxWidthDiskCache,
    maxHeight: coverImageMaxHeightDiskCache,
  );
  final generator = await PaletteGeneratorMaster.fromImageProvider(
    imageProvider,
    maximumColorCount: 12,
    generateHarmony: false,
    timeout: const Duration(seconds: 5),
  );
  final primary = _firstColor(
    generator.vibrantColor,
    generator.dominantColor,
    generator.mutedColor,
    generator.darkVibrantColor,
  );
  final secondary = _firstColor(
    generator.mutedColor,
    generator.lightVibrantColor,
    generator.dominantColor,
    generator.vibrantColor,
  );
  final tertiary = _firstColor(
    generator.lightMutedColor,
    generator.darkMutedColor,
    generator.lightVibrantColor,
    generator.dominantColor,
  );

  if (primary == null) {
    throw StateError('No cover colors could be extracted.');
  }

  return VnCoverPalette(
    primary: primary,
    secondary: secondary ?? primary,
    tertiary: tertiary ?? secondary ?? primary,
  );
}

Color? _firstColor(
  PaletteColorMaster? first,
  PaletteColorMaster? second,
  PaletteColorMaster? third,
  PaletteColorMaster? fourth,
) {
  return first?.color ?? second?.color ?? third?.color ?? fourth?.color;
}

Color _fitAccentColor(
  Color color, {
  required Brightness brightness,
  required Color fallback,
}) {
  final hsl = HSLColor.fromColor(color);

  if (hsl.saturation < 0.16) {
    return fallback;
  }

  final minLightness = brightness == Brightness.dark ? 0.65 : 0.30;
  final maxLightness = brightness == Brightness.dark ? 0.75 : 0.35;
  final saturation = hsl.saturation.clamp(0.35, 0.80);
  final lightness = hsl.lightness.clamp(minLightness, maxLightness);

  return hsl.withSaturation(saturation).withLightness(lightness).toColor();
}

Color _bestOnColor(Color background) {
  final whiteContrast = _contrastRatio(Colors.white, background);
  final blackContrast = _contrastRatio(Colors.black, background);

  return whiteContrast >= blackContrast ? Colors.white : Colors.black;
}

double _contrastRatio(Color foreground, Color background) {
  final foregroundLuminance = foreground.computeLuminance();
  final backgroundLuminance = background.computeLuminance();
  final lighter = foregroundLuminance > backgroundLuminance
      ? foregroundLuminance
      : backgroundLuminance;
  final darker = foregroundLuminance > backgroundLuminance
      ? backgroundLuminance
      : foregroundLuminance;

  return (lighter + 0.05) / (darker + 0.05);
}
