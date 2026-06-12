import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

class AppTheme {
  AppTheme._();

  // Static color constants matching default VNDB theme for initial/static references
  static const Color background = Color(0xFF161C2E);
  static const Color surface = Color(0xFF20273F);
  static const Color searchField = Color(0xFF2A2E3F);
  static const Color accentTeal = Color(0xFF26C6DA);
  static const Color accentAmber = Color(0xFFFFB300);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFF8E92A4);
  static const Color textSecondary = Color(0xFFB0B3C1);

  // Custom VNDB Color Scheme configuration
  static const FlexSchemeColor _vndbColors = FlexSchemeColor(
    primary: Color(0xFF4C72A4), // VNDB Blue primary accent
    primaryContainer: Color(0xFF2E3D59),
    secondary: Color(0xFF26C6DA), // Teal secondary accent
    secondaryContainer: Color(0xFF13626C),
    tertiary: Color(0xFFFFB300), // Amber tertiary accent
    tertiaryContainer: Color(0xFF7F5900),
    appBarColor: Color(0xFF161C2E),
    error: Color(0xFFCF6679),
  );

  // Map theme names to their corresponding FlexScheme (or custom)
  static final Map<String, String> themes = {
    'vndb': 'VNDB',
    'material': 'Material Default',
    'ebonyClay': 'Ebony Clay',
    'deepBlue': 'Deep Blue',
    'dellGenoa': 'Dell Genoa',
    'shark': 'Shark Dark',
  };

  static FlexScheme _mapThemeNameToScheme(String themeName) {
    switch (themeName) {
      case 'material':
        return FlexScheme.material;
      case 'ebonyClay':
        return FlexScheme.ebonyClay;
      case 'deepBlue':
        return FlexScheme.deepBlue;
      case 'dellGenoa':
        return FlexScheme.dellGenoa;
      case 'shark':
        return FlexScheme.shark;
      default:
        return FlexScheme.material;
    }
  }

  static ThemeData getTheme(
    String themeName, {
    required bool isDark,
    bool darkIsTrueBlack = false,
  }) {
    final isCustomVndb = themeName == 'vndb';
    final scheme = _mapThemeNameToScheme(themeName);

    if (isDark) {
      return FlexThemeData.dark(
        scheme: isCustomVndb ? null : scheme,
        colors: isCustomVndb ? _vndbColors : null,
        useMaterial3: true,
        darkIsTrueBlack: darkIsTrueBlack,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: darkIsTrueBlack ? 0 : 12,
        scaffoldBackground: (isCustomVndb && !darkIsTrueBlack)
            ? const Color(0xFF161C2E)
            : null,
        fontFamily: GoogleFonts.inter().fontFamily,
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
          headlineMedium: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
          titleLarge: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          titleMedium: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: textPrimary,
          ),
          bodyLarge: GoogleFonts.inter(
            fontWeight: FontWeight.normal,
            color: textSecondary,
            height: 1.5,
          ),
          bodyMedium: GoogleFonts.inter(
            fontWeight: FontWeight.normal,
            color: textSecondary,
            height: 1.4,
          ),
          labelLarge: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          labelSmall: GoogleFonts.inter(
            fontWeight: FontWeight.normal,
            color: textMuted,
          ),
        ),
        subThemesData: const FlexSubThemesData(
          cardElevation: 0,
          cardRadius: 16,
          chipRadius: 20,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          inputDecoratorRadius: 24,
          inputDecoratorUnfocusedHasBorder: false,
          inputDecoratorFocusedBorderWidth: 1.5,
          bottomNavigationBarElevation: 8,
          bottomNavigationBarOpacity: 1.0,
        ),
      ).copyWith(
        cardColor: const Color(0xFF20273F),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
        ),
      );
    } else {
      return FlexThemeData.light(
        scheme: isCustomVndb ? null : scheme,
        colors: isCustomVndb ? _vndbColors : null,
        useMaterial3: true,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 12,
        fontFamily: GoogleFonts.inter().fontFamily,
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          headlineMedium: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          titleLarge: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          titleMedium: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          bodyLarge: GoogleFonts.inter(
            fontWeight: FontWeight.normal,
            color: Colors.black87,
            height: 1.5,
          ),
          bodyMedium: GoogleFonts.inter(
            fontWeight: FontWeight.normal,
            color: Colors.black87,
            height: 1.4,
          ),
          labelLarge: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          labelSmall: GoogleFonts.inter(
            fontWeight: FontWeight.normal,
            color: Colors.black54,
          ),
        ),
        subThemesData: const FlexSubThemesData(
          cardElevation: 0,
          cardRadius: 16,
          chipRadius: 20,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          inputDecoratorRadius: 24,
          inputDecoratorUnfocusedHasBorder: false,
          inputDecoratorFocusedBorderWidth: 1.5,
          bottomNavigationBarElevation: 8,
          bottomNavigationBarOpacity: 1.0,
        ),
      ).copyWith(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
        ),
      );
    }
  }

  // Keeping darkTheme getter for default compatibility
  static ThemeData get darkTheme => getTheme('vndb', isDark: true);
}

// Extension to cleanly and dynamically read colors inside build methods
extension AppThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;

  Color get appBackground => theme.scaffoldBackgroundColor;
  Color get appSurface => theme.cardColor;
  Color get appSearchField =>
      theme.inputDecorationTheme.fillColor ?? colorScheme.surfaceContainerHigh;
  Color get appAccentTeal => colorScheme.primary;
  Color get appAccentAmber => colorScheme.secondary;
  Color get appTextPrimary => colorScheme.onSurface;
  Color get appTextMuted => colorScheme.onSurfaceVariant;
  Color get appTextSecondary => colorScheme.onSurfaceVariant;
}
