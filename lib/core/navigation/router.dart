import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../vn/models/visual_novel.dart';
import '../../vn/models/vn_screenshot.dart';
import '../../vn/screens/home_screen.dart';
import '../../vn/screens/search_screen.dart';
import '../../vn/screens/library_screen.dart';
import '../../vn/screens/vn_detail_screen.dart';
import '../../vn/screens/vn_by_tag_screen.dart';
import '../../vn/screens/vn_gallery_screen.dart';
import '../../settings/screens/settings_screen.dart';
import '../../settings/screens/login_screen.dart';
import '../../vn/screens/filter_screen.dart';

import '../../theme/app_theme.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: context.appSurface,
          border: Border(
            top: BorderSide(
              color: context.appTextPrimary.withValues(alpha: 0.08),
              width: 1.0,
            ),
          ),
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: Colors.transparent,
            elevation: 0,
            indicatorColor: context.appAccentTeal.withValues(alpha: 0.12),
            iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
              if (states.contains(WidgetState.selected)) {
                return IconThemeData(color: context.appAccentTeal);
              }

              return IconThemeData(color: context.appTextSecondary);
            }),
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
              states,
            ) {
              final baseStyle = theme.textTheme.labelSmall ?? const TextStyle();

              if (states.contains(WidgetState.selected)) {
                return baseStyle.copyWith(
                  color: context.appAccentTeal,
                  fontWeight: FontWeight.w600,
                );
              }

              return baseStyle.copyWith(color: context.appTextSecondary);
            }),
          ),
          child: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.search_outlined),
                selectedIcon: Icon(Icons.search_rounded),
                label: 'Search',
              ),
              NavigationDestination(
                icon: Icon(Icons.library_books_outlined),
                selectedIcon: Icon(Icons.library_books_rounded),
                label: 'Library',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final goRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => const SearchScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/library',
              builder: (context, state) => const LibraryScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/filters',
      builder: (context, state) => const FilterScreen(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final vn = state.extra as VisualNovel;

        return VnDetailScreen(vn: vn);
      },
    ),
    GoRoute(
      path: '/tag-list',
      builder: (context, state) {
        final args = state.extra as Map<String, String>;

        return VnByTagScreen(tagId: args['tagId']!, tagName: args['tagName']!);
      },
    ),
    GoRoute(
      path: '/gallery',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        final screenshots = args['screenshots'] as List<VnScreenshot>;
        final initialIndex = args['initialIndex'] as int;

        return VnGalleryScreen(
          screenshots: screenshots,
          initialIndex: initialIndex,
        );
      },
    ),
  ],
);
