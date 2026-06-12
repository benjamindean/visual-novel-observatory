import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/storage/app_storage.dart';

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
    final box = AppStorage.mainBox;

    final spoiler = box.get(_spoilerKey) as int? ?? 0;
    final language = box.get(_languageKey) as String?;
    final platform = box.get(_platformKey) as String?;
    final explicit = box.get(_explicitKey) as bool? ?? false;
    final theme = box.get(_themeKey) as String? ?? 'vndb';
    final mode = box.get(_themeModeKey) as String? ?? 'system';
    final isTrueBlack = box.get(_darkIsTrueBlackKey) as bool? ?? false;

    return SettingsState(
      spoilerLevel: spoiler,
      defaultLanguage: language,
      defaultPlatform: platform,
      showExplicitContent: explicit,
      themeName: theme,
      themeMode: mode,
      darkIsTrueBlack: isTrueBlack,
    );
  }

  Future<void> loadSettings() async {
    // Kept as an empty future for backward-compatibility.
    // Settings are loaded synchronously in build() now.
  }

  Future<void> setThemeName(String name) async {
    final box = AppStorage.mainBox;

    await box.put(_themeKey, name);

    state = state.copyWith(themeName: name);
  }

  Future<void> setThemeMode(String mode) async {
    final box = AppStorage.mainBox;

    await box.put(_themeModeKey, mode);

    state = state.copyWith(themeMode: mode);
  }

  Future<void> setDarkIsTrueBlack(bool value) async {
    final box = AppStorage.mainBox;

    await box.put(_darkIsTrueBlackKey, value);

    state = state.copyWith(darkIsTrueBlack: value);
  }

  Future<void> setSpoilerLevel(int level) async {
    final box = AppStorage.mainBox;

    await box.put(_spoilerKey, level);

    state = state.copyWith(spoilerLevel: level);
  }

  Future<void> setShowExplicitContent(bool value) async {
    final box = AppStorage.mainBox;

    await box.put(_explicitKey, value);

    state = state.copyWith(showExplicitContent: value);
  }

  Future<void> setDefaultLanguage(String? language) async {
    final box = AppStorage.mainBox;

    if (language == null) {
      await box.delete(_languageKey);
    } else {
      await box.put(_languageKey, language);
    }

    state = state.copyWith(defaultLanguage: () => language);
  }

  Future<void> setDefaultPlatform(String? platform) async {
    final box = AppStorage.mainBox;

    if (platform == null) {
      await box.delete(_platformKey);
    } else {
      await box.put(_platformKey, platform);
    }

    state = state.copyWith(defaultPlatform: () => platform);
  }
}

final settingsProvider = NotifierProvider<SettingsNotifier, SettingsState>(
  SettingsNotifier.new,
);
