import 'package:material_ui/material_ui.dart';
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
  static const FlexSchemeData vndbThemeData = FlexSchemeData(
    name: 'VNDB',
    description: 'VNDB custom color scheme.',
    light: FlexSchemeColor(
      primary: Color(0xFF4B6F9F),
      primaryContainer: Color(0xFFDCE8F7),
      secondary: Color(0xFF008A99),
      secondaryContainer: Color(0xFFC4EEF3),
      tertiary: Color(0xFFA66400),
      tertiaryContainer: Color(0xFFFFE3B8),
      appBarColor: Color(0xFFF5F7FB),
      error: Color(0xFFBA1A1A),
    ),
    dark: FlexSchemeColor(
      primary: Color(0xFF4C72A4), // VNDB Blue primary accent
      primaryContainer: Color(0xFF2E3D59),
      secondary: Color(0xFF26C6DA), // Teal secondary accent
      secondaryContainer: Color(0xFF13626C),
      tertiary: Color(0xFFFFB300), // Amber tertiary accent
      tertiaryContainer: Color(0xFF7F5900),
      appBarColor: Color(0xFF161C2E),
      error: Color(0xFFCF6679),
    ),
  );

  // Map theme names to their corresponding FlexScheme (or custom)
  static final Map<String, String> themes = {
    'vndb': 'VNDB',
    'material': 'Material Default',
    'ebonyClay': 'Ebony Clay',
    'deepBlue': 'Deep Blue',
    'dellGenoa': 'Dell Genoa',
    'shark': 'Shark Dark',
    'sakura': 'Sakura Pink',
    'jungle': 'Jungle Green',
    'mango': 'Mango Orange',
    'outerSpace': 'Outer Space',
    'gold': 'Gold Sunset',
    'indigo': 'Indigo Night',
    'redWine': 'Red Wine',
    'bahamaBlue': 'Bahama Blue',
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
      case 'sakura':
        return FlexScheme.sakura;
      case 'jungle':
        return FlexScheme.jungle;
      case 'mango':
        return FlexScheme.mango;
      case 'outerSpace':
        return FlexScheme.outerSpace;
      case 'gold':
        return FlexScheme.gold;
      case 'indigo':
        return FlexScheme.indigo;
      case 'redWine':
        return FlexScheme.redWine;
      case 'bahamaBlue':
        return FlexScheme.bahamaBlue;
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
        darkIsTrueBlack: darkIsTrueBlack,
        scheme: isCustomVndb ? null : scheme,
        colors: isCustomVndb ? vndbThemeData.dark : null,
        usedColors: 6,
        surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
        blendLevel: 12,
        subThemesData: const FlexSubThemesData(
          chipSchemeColor: SchemeColor.surfaceContainer,
          cardElevation: 1.0,
          listTileTextSchemeColor: SchemeColor.onSurface,
          appBarScrolledUnderElevation: 0.0,
          interactionEffects: true,
          tintedDisabledControls: true,
          blendOnLevel: 12,
          blendOnColors: true,
          useM2StyleDividerInM3: true,
          defaultRadius: 12.0,
          elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
          elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
          outlinedButtonOutlineSchemeColor: SchemeColor.primary,
          toggleButtonsBorderSchemeColor: SchemeColor.primary,
          segmentedButtonSchemeColor: SchemeColor.primary,
          segmentedButtonBorderSchemeColor: SchemeColor.primary,
          scaffoldBackgroundBaseColor:
              FlexScaffoldBaseColor.surfaceContainerLow,
          unselectedToggleIsColored: true,
          sliderValueTinted: true,
          inputDecoratorSchemeColor: SchemeColor.primary,
          inputDecoratorIsFilled: true,
          inputDecoratorBackgroundAlpha: 43,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          inputDecoratorUnfocusedHasBorder: false,
          inputDecoratorFocusedBorderWidth: 1.0,
          inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
          fabUseShape: true,
          fabAlwaysCircular: true,
          fabSchemeColor: SchemeColor.secondary,
          popupMenuRadius: 8.0,
          popupMenuElevation: 3.0,
          alignedDropdown: true,
          drawerIndicatorRadius: 12.0,
          drawerIndicatorSchemeColor: SchemeColor.primary,
          bottomNavigationBarMutedUnselectedLabel: false,
          bottomNavigationBarMutedUnselectedIcon: false,
          menuRadius: 8.0,
          menuElevation: 3.0,
          menuBarRadius: 0.0,
          menuBarElevation: 2.0,
          menuBarShadowColor: Color(0x00000000),
          navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
          navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationBarIndicatorSchemeColor: SchemeColor.primary,
          navigationBarIndicatorRadius: 12.0,
          navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
          navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationRailUseIndicator: true,
          navigationRailIndicatorSchemeColor: SchemeColor.primary,
          navigationRailIndicatorOpacity: 1.0,
          navigationRailIndicatorRadius: 12.0,
          navigationRailBackgroundSchemeColor: SchemeColor.tertiaryContainer,
          navigationRailLabelType: NavigationRailLabelType.all,
        ),
        keyColors: const FlexKeyColors(
          useSecondary: true,
          useTertiary: true,
          keepSecondaryContainer: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        variant: FlexSchemeVariant.candyPop,
        fontFamily: GoogleFonts.openSans().fontFamily,
      );
    } else {
      return FlexThemeData.light(
        scheme: isCustomVndb ? null : scheme,
        colors: isCustomVndb ? vndbThemeData.light : null,
        usedColors: 6,
        surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
        blendLevel: 12,
        subThemesData: const FlexSubThemesData(
          chipSchemeColor: SchemeColor.surfaceContainer,
          cardElevation: 1.0,
          appBarScrolledUnderElevation: 0.0,
          interactionEffects: true,
          tintedDisabledControls: true,
          blendOnLevel: 12,
          useM2StyleDividerInM3: false,
          defaultRadius: 12.0,
          listTileTextSchemeColor: SchemeColor.onSurface,
          elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
          elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
          outlinedButtonOutlineSchemeColor: SchemeColor.primary,
          toggleButtonsBorderSchemeColor: SchemeColor.primary,
          segmentedButtonSchemeColor: SchemeColor.primary,
          segmentedButtonBorderSchemeColor: SchemeColor.primary,
          scaffoldBackgroundBaseColor:
              FlexScaffoldBaseColor.surfaceContainerLow,
          unselectedToggleIsColored: true,
          sliderValueTinted: true,
          inputDecoratorSchemeColor: SchemeColor.primary,
          inputDecoratorIsFilled: true,
          inputDecoratorBackgroundAlpha: 31,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          inputDecoratorUnfocusedHasBorder: false,
          inputDecoratorFocusedBorderWidth: 1.0,
          inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
          fabUseShape: true,
          fabAlwaysCircular: true,
          fabSchemeColor: SchemeColor.secondary,
          popupMenuRadius: 8.0,
          popupMenuElevation: 3.0,
          alignedDropdown: true,
          drawerIndicatorRadius: 12.0,
          drawerIndicatorSchemeColor: SchemeColor.primary,
          bottomNavigationBarMutedUnselectedLabel: false,
          bottomNavigationBarMutedUnselectedIcon: false,
          menuRadius: 8.0,
          menuElevation: 3.0,
          menuBarRadius: 0.0,
          menuBarElevation: 2.0,
          menuBarShadowColor: Color(0x00000000),
          navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
          navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationBarIndicatorSchemeColor: SchemeColor.primary,
          navigationBarIndicatorRadius: 12.0,
          navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
          navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationRailUseIndicator: true,
          navigationRailIndicatorSchemeColor: SchemeColor.primary,
          navigationRailIndicatorOpacity: 1.0,
          navigationRailIndicatorRadius: 12.0,
          navigationRailBackgroundSchemeColor: SchemeColor.tertiaryContainer,
          navigationRailLabelType: NavigationRailLabelType.all,
        ),
        keyColors: const FlexKeyColors(
          useSecondary: true,
          useTertiary: true,
          keepPrimary: true,
          keepSecondaryContainer: true,
        ),
        variant: FlexSchemeVariant.candyPop,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        fontFamily: GoogleFonts.openSans().fontFamily,
      );
    }
  }

  static List<Color> getThemeColors(String themeName, bool isDark) {
    final theme = getTheme(themeName, isDark: isDark);

    return [
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
      theme.colorScheme.tertiary,
    ];
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
  Color get appTextMuted => colorScheme.onSurfaceVariant.withValues(alpha: 0.5);
  Color get appTextSecondary => colorScheme.onSurfaceVariant;
}
