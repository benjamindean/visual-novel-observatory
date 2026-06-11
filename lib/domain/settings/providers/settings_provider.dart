import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsState {
  final int spoilerLevel;
  final String? defaultLanguage;
  final String? defaultPlatform;
  final bool showExplicitContent;

  SettingsState({
    this.spoilerLevel = 0,
    this.defaultLanguage,
    this.defaultPlatform,
    this.showExplicitContent = false,
  });

  SettingsState copyWith({
    int? spoilerLevel,
    String? Function()? defaultLanguage,
    String? Function()? defaultPlatform,
    bool? showExplicitContent,
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
    );
  }
}

class SettingsNotifier extends Notifier<SettingsState> {
  static const String _spoilerKey = 'settings_spoiler_level';
  static const String _languageKey = 'settings_default_language';
  static const String _platformKey = 'settings_default_platform';
  static const String _explicitKey = 'settings_show_explicit';

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

    state = SettingsState(
      spoilerLevel: spoiler,
      defaultLanguage: language,
      defaultPlatform: platform,
      showExplicitContent: explicit,
    );
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
