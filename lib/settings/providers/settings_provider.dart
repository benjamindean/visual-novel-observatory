import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/storage/app_storage.dart';

class SettingsState {
  final int spoilerLevel;
  final bool disableExplicitContent;
  final bool blurSexualContent;
  final bool blurViolentContent;
  final String themeName;
  final String themeMode;
  final bool darkIsTrueBlack;
  final bool useCoverColorScheme;

  SettingsState({
    this.spoilerLevel = 0,
    this.disableExplicitContent = true,
    this.blurSexualContent = true,
    this.blurViolentContent = true,
    this.themeName = 'vndb',
    this.themeMode = 'system',
    this.darkIsTrueBlack = false,
    this.useCoverColorScheme = true,
  });

  SettingsState copyWith({
    int? spoilerLevel,
    bool? disableExplicitContent,
    bool? blurSexualContent,
    bool? blurViolentContent,
    String? themeName,
    String? themeMode,
    bool? darkIsTrueBlack,
    bool? useCoverColorScheme,
  }) {
    return SettingsState(
      spoilerLevel: spoilerLevel ?? this.spoilerLevel,
      disableExplicitContent:
          disableExplicitContent ?? this.disableExplicitContent,
      blurSexualContent: blurSexualContent ?? this.blurSexualContent,
      blurViolentContent: blurViolentContent ?? this.blurViolentContent,
      themeName: themeName ?? this.themeName,
      themeMode: themeMode ?? this.themeMode,
      darkIsTrueBlack: darkIsTrueBlack ?? this.darkIsTrueBlack,
      useCoverColorScheme: useCoverColorScheme ?? this.useCoverColorScheme,
    );
  }
}

class SettingsNotifier extends Notifier<SettingsState> {
  static const String _spoilerKey = 'settings_spoiler_level';
  static const String _disableExplicitKey = 'settings_disable_explicit';
  static const String _blurSexualKey = 'settings_blur_sexual_content';
  static const String _blurViolentKey = 'settings_blur_violent_content';
  static const String _themeKey = 'settings_theme_name';
  static const String _themeModeKey = 'settings_theme_mode';
  static const String _darkIsTrueBlackKey = 'settings_dark_is_true_black';
  static const String _useCoverColorSchemeKey =
      'settings_use_cover_color_scheme';

  @override
  SettingsState build() {
    final box = AppStorage.mainBox;

    final spoiler = box.get(_spoilerKey) as int? ?? 0;
    final disableExplicit = box.get(_disableExplicitKey) as bool? ?? true;
    final blurSexual = disableExplicit
        ? true
        : box.get(_blurSexualKey) as bool? ?? true;
    final blurViolent = disableExplicit
        ? true
        : box.get(_blurViolentKey) as bool? ?? true;
    final theme = box.get(_themeKey) as String? ?? 'vndb';
    final mode = box.get(_themeModeKey) as String? ?? 'system';
    final isTrueBlack = box.get(_darkIsTrueBlackKey) as bool? ?? false;
    final useCoverColorScheme =
        box.get(_useCoverColorSchemeKey) as bool? ?? true;

    return SettingsState(
      spoilerLevel: spoiler,
      disableExplicitContent: disableExplicit,
      blurSexualContent: blurSexual,
      blurViolentContent: blurViolent,
      themeName: theme,
      themeMode: mode,
      darkIsTrueBlack: isTrueBlack,
      useCoverColorScheme: useCoverColorScheme,
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

  Future<void> setUseCoverColorScheme(bool value) async {
    final box = AppStorage.mainBox;

    await box.put(_useCoverColorSchemeKey, value);

    state = state.copyWith(useCoverColorScheme: value);
  }

  Future<void> setSpoilerLevel(int level) async {
    final box = AppStorage.mainBox;

    await box.put(_spoilerKey, level);

    state = state.copyWith(spoilerLevel: level);
  }

  Future<void> setDisableExplicitContent(bool value) async {
    final box = AppStorage.mainBox;

    await box.put(_disableExplicitKey, value);
    await box.put(_blurSexualKey, true);
    await box.put(_blurViolentKey, true);

    state = state.copyWith(
      disableExplicitContent: value,
      blurSexualContent: true,
      blurViolentContent: true,
    );
  }

  Future<void> setBlurSexualContent(bool value) async {
    if (state.disableExplicitContent) {
      return;
    }

    final box = AppStorage.mainBox;

    await box.put(_blurSexualKey, value);

    state = state.copyWith(blurSexualContent: value);
  }

  Future<void> setBlurViolentContent(bool value) async {
    if (state.disableExplicitContent) {
      return;
    }

    final box = AppStorage.mainBox;

    await box.put(_blurViolentKey, value);

    state = state.copyWith(blurViolentContent: value);
  }
}

final settingsProvider = NotifierProvider<SettingsNotifier, SettingsState>(
  SettingsNotifier.new,
);
