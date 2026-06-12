import 'package:flutter/material.dart';
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
    // ProviderScope is required for Riverpod state management
    const ProviderScope(child: VisualNovelObservatoryApp()),
  );
}

class VisualNovelObservatoryApp extends ConsumerWidget {
  const VisualNovelObservatoryApp({super.key});

  ThemeMode getThemeMode(SettingsState settings) {
    switch (settings.themeMode) {
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
    final settings = ref.watch(settingsProvider);

    return MaterialApp.router(
      title: 'Visual Novel Observatory',
      debugShowCheckedModeBanner: false,
      themeMode: getThemeMode(settings),
      theme: AppTheme.getTheme(settings.themeName, isDark: false),
      darkTheme: AppTheme.getTheme(
        settings.themeName,
        isDark: true,
        darkIsTrueBlack: settings.darkIsTrueBlack,
      ),
      routerConfig: goRouter,
    );
  }
}
