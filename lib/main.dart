import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'domain/vn/screens/home_screen.dart';
import 'domain/vn/screens/vn_detail_screen.dart';
import 'domain/vn/screens/vn_by_tag_screen.dart';
import 'domain/vn/screens/vn_gallery_screen.dart';
import 'domain/vn/models/vn_screenshot.dart';
import 'domain/settings/screens/settings_screen.dart';
import 'domain/settings/screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // ProviderScope is required for Riverpod state management
    const ProviderScope(child: VisualNovelObservatoryApp()),
  );
}

class VisualNovelObservatoryApp extends StatelessWidget {
  const VisualNovelObservatoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visual Novel Observatory',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/login': (context) => const LoginScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final vnId = settings.arguments as String;

          return MaterialPageRoute(
            builder: (context) => VnDetailScreen(vnId: vnId),
            settings: settings,
          );
        }

        if (settings.name == '/tag-list') {
          final args = settings.arguments as Map<String, String>;

          return MaterialPageRoute(
            builder: (context) =>
                VnByTagScreen(tagId: args['tagId']!, tagName: args['tagName']!),
            settings: settings,
          );
        }

        if (settings.name == '/gallery') {
          final args = settings.arguments as Map<String, dynamic>;
          final screenshots = args['screenshots'] as List<VnScreenshot>;
          final initialIndex = args['initialIndex'] as int;

          return MaterialPageRoute(
            builder: (context) => VnGalleryScreen(
              screenshots: screenshots,
              initialIndex: initialIndex,
            ),
            settings: settings,
          );
        }

        return null;
      },
    );
  }
}
