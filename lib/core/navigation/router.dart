import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../vn/models/visual_novel.dart';
import '../../vn/models/vn_screenshot.dart';
import '../../vn/screens/home/home_screen.dart';
import '../../vn/screens/search/search_screen.dart';
import '../../vn/screens/library/library_screen.dart';
import '../../vn/screens/vn_detail/vn_detail_screen.dart';
import '../../vn/screens/vn_by_tag/vn_by_tag_screen.dart';
import '../../vn/screens/vn_gallery/vn_gallery_screen.dart';
import '../../settings/screens/settings/settings_screen.dart';
import '../../settings/screens/login/login_screen.dart';
import '../../vn/screens/filter/filter_screen.dart';
import '../../vn/models/vn_voice_actor.dart';
import '../../vn/screens/vn_character/character_screen.dart';
import '../../vn/providers/vn_providers.dart';

class ScaffoldWithNavBar extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          if (index == navigationShell.currentIndex) {
            if (index == 0) {
              ref.read(homeDoubleTapProvider.notifier).increment();
            } else if (index == 1) {
              ref.read(searchDoubleTapProvider.notifier).increment();
            } else if (index == 2) {
              ref.read(libraryDoubleTapProvider.notifier).increment();
            }
          }

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
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final vn = state.extra as VisualNovel;

        return VnDetailScreen(vn: vn);
      },
    ),
    GoRoute(
      path: '/character',
      builder: (context, state) {
        final association = state.extra as VnVoiceActorAssociation;

        return CharacterScreen(association: association);
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
      pageBuilder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        final screenshots = args['screenshots'] as List<VnScreenshot>;
        final initialIndex = args['initialIndex'] as int;

        return CustomTransitionPage<void>(
          key: state.pageKey,
          opaque: false,
          barrierColor: Colors.transparent,
          transitionsBuilder:
              (
                context,
                animation,
                secondaryAnimation,
                child,
              ) => FadeTransition(
                opacity: animation,
                child: child,
              ),
          child: VnGalleryScreen(
            screenshots: screenshots,
            initialIndex: initialIndex,
          ),
        );
      },
    ),
  ],
);
