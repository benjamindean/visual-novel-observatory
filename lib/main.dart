import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'theme/app_theme.dart';
import 'settings/providers/settings_provider.dart';
import 'core/storage/app_storage.dart';
import 'core/navigation/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await AppStorage.init();

  runApp(
    const ProviderScope(
      child: VisualNovelObservatoryApp(),
    ),
  );
}

class VisualNovelObservatoryApp extends ConsumerWidget {
  const VisualNovelObservatoryApp({super.key});

  ThemeMode getThemeMode(String themeMode) {
    switch (themeMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSettings = ref.watch(
      settingsProvider.select(
        (settings) => (
          themeMode: settings.themeMode,
          themeName: settings.themeName,
          darkIsTrueBlack: settings.darkIsTrueBlack,
        ),
      ),
    );

    return MaterialApp.router(
      title: 'Visual Novel Observatory',
      debugShowCheckedModeBanner: false,
      themeMode: getThemeMode(themeSettings.themeMode),
      theme: AppTheme.getTheme(themeSettings.themeName, isDark: false),
      darkTheme: AppTheme.getTheme(
        themeSettings.themeName,
        isDark: true,
        darkIsTrueBlack: themeSettings.darkIsTrueBlack,
      ),
      localizationsDelegates: const [
        LocaleNamesLocalizationsDelegate(),
      ],
      routerConfig: goRouter,
    );
  }
}
