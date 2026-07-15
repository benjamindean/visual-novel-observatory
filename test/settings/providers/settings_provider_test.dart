import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:visual_novel_observatory/core/storage/app_storage.dart';
import 'package:visual_novel_observatory/settings/providers/settings_provider.dart';

void main() {
  late Directory storageDirectory;
  late ProviderContainer container;

  setUpAll(() async {
    storageDirectory = await Directory.systemTemp.createTemp(
      'visual_novel_observatory_settings_test_',
    );
    Hive.init(storageDirectory.path);
    await AppStorage.init();
  });

  setUp(() async {
    await AppStorage.mainBox.clear();
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  tearDownAll(() async {
    await Hive.close();
    await storageDirectory.delete(recursive: true);
  });

  test('uses strict safe defaults when no settings are stored', () {
    final settings = container.read(settingsProvider);

    expect(settings.disableExplicitContent, isTrue);
    expect(settings.blurSexualContent, isTrue);
    expect(settings.blurViolentContent, isTrue);
    expect(settings.spoilerLevel, 0);
    expect(settings.themeMode, 'system');
  });

  test('loads persisted settings synchronously', () async {
    await AppStorage.mainBox.put('settings_spoiler_level', 2);
    await AppStorage.mainBox.put('settings_disable_explicit', false);
    await AppStorage.mainBox.put('settings_blur_sexual_content', false);
    await AppStorage.mainBox.put('settings_blur_violent_content', true);
    await AppStorage.mainBox.put('settings_theme_mode', 'dark');

    final settings = container.read(settingsProvider);

    expect(settings.spoilerLevel, 2);
    expect(settings.disableExplicitContent, isFalse);
    expect(settings.blurSexualContent, isFalse);
    expect(settings.blurViolentContent, isTrue);
    expect(settings.themeMode, 'dark');
  });

  test('safe mode forces both adjacent blur controls on', () async {
    await AppStorage.mainBox.put('settings_disable_explicit', false);
    await AppStorage.mainBox.put('settings_blur_sexual_content', false);
    await AppStorage.mainBox.put('settings_blur_violent_content', false);
    container.read(settingsProvider);

    await container
        .read(settingsProvider.notifier)
        .setDisableExplicitContent(true);

    final settings = container.read(settingsProvider);

    expect(settings.disableExplicitContent, isTrue);
    expect(settings.blurSexualContent, isTrue);
    expect(settings.blurViolentContent, isTrue);
    expect(
      AppStorage.mainBox.get('settings_blur_sexual_content'),
      isTrue,
    );
    expect(
      AppStorage.mainBox.get('settings_blur_violent_content'),
      isTrue,
    );
  });

  test('safe mode prevents disabling content blur', () async {
    container.read(settingsProvider);

    await container.read(settingsProvider.notifier).setBlurSexualContent(false);
    await container
        .read(settingsProvider.notifier)
        .setBlurViolentContent(false);

    final settings = container.read(settingsProvider);

    expect(settings.blurSexualContent, isTrue);
    expect(settings.blurViolentContent, isTrue);
  });

  test('blur controls can change after safe mode is disabled', () async {
    container.read(settingsProvider);
    final notifier = container.read(settingsProvider.notifier);

    await notifier.setDisableExplicitContent(false);
    await notifier.setBlurSexualContent(false);
    await notifier.setBlurViolentContent(false);

    final settings = container.read(settingsProvider);

    expect(settings.disableExplicitContent, isFalse);
    expect(settings.blurSexualContent, isFalse);
    expect(settings.blurViolentContent, isFalse);
  });

  test('theme and spoiler updates are persisted', () async {
    container.read(settingsProvider);
    final notifier = container.read(settingsProvider.notifier);

    await notifier.setThemeName('sakura');
    await notifier.setThemeMode('light');
    await notifier.setDarkIsTrueBlack(true);
    await notifier.setUseCoverColorScheme(false);
    await notifier.setSpoilerLevel(2);

    final settings = container.read(settingsProvider);

    expect(settings.themeName, 'sakura');
    expect(settings.themeMode, 'light');
    expect(settings.darkIsTrueBlack, isTrue);
    expect(settings.useCoverColorScheme, isFalse);
    expect(settings.spoilerLevel, 2);
    expect(AppStorage.mainBox.get('settings_theme_name'), 'sakura');
  });
}
