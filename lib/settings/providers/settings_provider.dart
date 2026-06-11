import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsState {
  final int spoilerLevel;
  final String? defaultLanguage;
  final String? defaultPlatform;
  final bool showExplicitContent;
  final String themeName;
  final String themeMode;
  final bool darkIsTrueBlack;

  SettingsState({
    this.spoilerLevel = 0,
    this.defaultLanguage,
    this.defaultPlatform,
    this.showExplicitContent = false,
    this.themeName = 'vndb',
    this.themeMode = 'system',
    this.darkIsTrueBlack = false,
  });

  SettingsState copyWith({
    int? spoilerLevel,
    String? Function()? defaultLanguage,
    String? Function()? defaultPlatform,
    bool? showExplicitContent,
    String? themeName,
    String? themeMode,
    bool? darkIsTrueBlack,
  }) {
    return SettingsState(
      spoilerLevel: spoilerLevel ?? this.spoilerLevel,
      defaultLanguage: defaultLanguage != null
          ? defaultLanguage()
          : this.defaultLanguage,
      defaultPlatform: defaultPlatform != null
          ? defaultPlatform()
          : this.defaultPlatform,
      showExplicitContent: showExplicitContent ?? this.showExplicitContent,
      themeName: themeName ?? this.themeName,
      themeMode: themeMode ?? this.themeMode,
      darkIsTrueBlack: darkIsTrueBlack ?? this.darkIsTrueBlack,
    );
  }
}

class SettingsNotifier extends Notifier<SettingsState> {
  static const String _spoilerKey = 'settings_spoiler_level';
  static const String _languageKey = 'settings_default_language';
  static const String _platformKey = 'settings_default_platform';
  static const String _explicitKey = 'settings_show_explicit';
  static const String _themeKey = 'settings_theme_name';
  static const String _themeModeKey = 'settings_theme_mode';
  static const String _darkIsTrueBlackKey = 'settings_dark_is_true_black';

  @override
  SettingsState build() {
    return SettingsState();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    final spoiler = prefs.getInt(_spoilerKey) ?? 0;
    final language = prefs.getString(_languageKey);
    final platform = prefs.getString(_platformKey);
    final explicit = prefs.getBool(_explicitKey) ?? false;
    final theme = prefs.getString(_themeKey) ?? 'vndb';
    final mode = prefs.getString(_themeModeKey) ?? 'system';
    final isTrueBlack = prefs.getBool(_darkIsTrueBlackKey) ?? false;

    state = SettingsState(
      spoilerLevel: spoiler,
      defaultLanguage: language,
      defaultPlatform: platform,
      showExplicitContent: explicit,
      themeName: theme,
      themeMode: mode,
      darkIsTrueBlack: isTrueBlack,
    );
  }

  Future<void> setThemeName(String name) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_themeKey, name);

    state = state.copyWith(themeName: name);
  }

  Future<void> setThemeMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_themeModeKey, mode);

    state = state.copyWith(themeMode: mode);
  }

  Future<void> setDarkIsTrueBlack(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_darkIsTrueBlackKey, value);

    state = state.copyWith(darkIsTrueBlack: value);
  }

  Future<void> setSpoilerLevel(int level) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(_spoilerKey, level);

    state = state.copyWith(spoilerLevel: level);
  }

  Future<void> setShowExplicitContent(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_explicitKey, value);

    state = state.copyWith(showExplicitContent: value);
  }

  Future<void> setDefaultLanguage(String? language) async {
    final prefs = await SharedPreferences.getInstance();

    if (language == null) {
      await prefs.remove(_languageKey);
    } else {
      await prefs.setString(_languageKey, language);
    }

    state = state.copyWith(defaultLanguage: () => language);
  }

  Future<void> setDefaultPlatform(String? platform) async {
    final prefs = await SharedPreferences.getInstance();

    if (platform == null) {
      await prefs.remove(_platformKey);
    } else {
      await prefs.setString(_platformKey, platform);
    }

    state = state.copyWith(defaultPlatform: () => platform);
  }
}

final settingsProvider = NotifierProvider<SettingsNotifier, SettingsState>(
  SettingsNotifier.new,
);
