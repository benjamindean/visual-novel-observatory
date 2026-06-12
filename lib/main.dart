import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'settings/providers/settings_provider.dart';
import 'core/navigation/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // ProviderScope is required for Riverpod state management
    const ProviderScope(child: VisualNovelObservatoryApp()),
  );
}

class VisualNovelObservatoryApp extends ConsumerWidget {
  const VisualNovelObservatoryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    ThemeMode themeMode;

    switch (settings.themeMode) {
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      default:
        themeMode = ThemeMode.system;
    }

    return MaterialApp.router(
      title: 'Visual Novel Observatory',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
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
