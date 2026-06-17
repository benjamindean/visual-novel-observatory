import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/storage/app_storage.dart';

class SettingsState {
  final int spoilerLevel;
  final bool showExplicitContent;
  final bool showViolentContent;
  final String themeName;
  final String themeMode;
  final bool darkIsTrueBlack;

  SettingsState({
    this.spoilerLevel = 0,
    this.showExplicitContent = false,
    this.showViolentContent = false,
    this.themeName = 'vndb',
    this.themeMode = 'system',
    this.darkIsTrueBlack = false,
  });

  SettingsState copyWith({
    int? spoilerLevel,
    bool? showExplicitContent,
    bool? showViolentContent,
    String? themeName,
    String? themeMode,
    bool? darkIsTrueBlack,
  }) {
    return SettingsState(
      spoilerLevel: spoilerLevel ?? this.spoilerLevel,
      showExplicitContent: showExplicitContent ?? this.showExplicitContent,
      showViolentContent: showViolentContent ?? this.showViolentContent,
      themeName: themeName ?? this.themeName,
      themeMode: themeMode ?? this.themeMode,
      darkIsTrueBlack: darkIsTrueBlack ?? this.darkIsTrueBlack,
    );
  }
}

class SettingsNotifier extends Notifier<SettingsState> {
  static const String _spoilerKey = 'settings_spoiler_level';
  static const String _explicitKey = 'settings_show_explicit';
  static const String _violentKey = 'settings_show_violent';
  static const String _themeKey = 'settings_theme_name';
  static const String _themeModeKey = 'settings_theme_mode';
  static const String _darkIsTrueBlackKey = 'settings_dark_is_true_black';

  @override
  SettingsState build() {
    final box = AppStorage.mainBox;

    final spoiler = box.get(_spoilerKey) as int? ?? 0;
    final explicit = box.get(_explicitKey) as bool? ?? false;
    final violent = box.get(_violentKey) as bool? ?? false;
    final theme = box.get(_themeKey) as String? ?? 'vndb';
    final mode = box.get(_themeModeKey) as String? ?? 'system';
    final isTrueBlack = box.get(_darkIsTrueBlackKey) as bool? ?? false;

    return SettingsState(
      spoilerLevel: spoiler,
      showExplicitContent: explicit,
      showViolentContent: violent,
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

  Future<void> setShowViolentContent(bool value) async {
    final box = AppStorage.mainBox;

    await box.put(_violentKey, value);

    state = state.copyWith(showViolentContent: value);
  }
}

final settingsProvider = NotifierProvider<SettingsNotifier, SettingsState>(
  SettingsNotifier.new,
);
