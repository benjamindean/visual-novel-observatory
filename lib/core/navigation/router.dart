import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../vn/models/visual_novel.dart';
import '../../vn/models/vn_screenshot.dart';
import '../../vn/screens/home/home_screen.dart';
import '../../vn/screens/home/home_create_filter_screen.dart';
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
import 'invalid_route_screen.dart';

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
            if (index == 1) {
              ref.read(searchDoubleTapProvider.notifier).increment();
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
      path: '/home/create-filter',
      builder: (context, state) => const HomeCreateFilterScreen(),
    ),
    GoRoute(
      path: '/home/edit-filter',
      builder: (context, state) {
        final extra = state.extra;

        if (extra is! String) {
          return const InvalidRouteScreen(
            title: 'Filter Not Found',
            message: 'This filter editor was opened without a valid filter.',
          );
        }

        return HomeCreateFilterScreen(tabId: extra);
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final extra = state.extra;

        if (extra is! VisualNovel) {
          return const InvalidRouteScreen(
            title: 'Visual Novel Not Found',
            message: 'This detail page was opened without a visual novel.',
          );
        }

        return VnDetailScreen(vn: extra);
      },
    ),
    GoRoute(
      path: '/character',
      builder: (context, state) {
        final extra = state.extra;

        if (extra is! VnVoiceActorAssociation) {
          return const InvalidRouteScreen(
            title: 'Character Not Found',
            message: 'This character page was opened without character data.',
          );
        }

        return CharacterScreen(association: extra);
      },
    ),
    GoRoute(
      path: '/tag-list',
      builder: (context, state) {
        final extra = state.extra;

        if (extra is! Map) {
          return const InvalidRouteScreen(
            title: 'Tag Not Found',
            message: 'This tag page was opened without tag data.',
          );
        }

        final tagId = extra['tagId'];
        final tagName = extra['tagName'];

        if (tagId is! String || tagName is! String) {
          return const InvalidRouteScreen(
            title: 'Tag Not Found',
            message: 'This tag page was opened with invalid tag data.',
          );
        }

        return VnByTagScreen(tagId: tagId, tagName: tagName);
      },
    ),
    GoRoute(
      path: '/gallery',
      pageBuilder: (context, state) {
        final extra = state.extra;

        if (extra is! Map) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const InvalidRouteScreen(
              title: 'Gallery Not Found',
              message: 'This gallery was opened without image data.',
            ),
          );
        }

        final screenshots = extra['screenshots'];
        final initialIndex = extra['initialIndex'];

        if (screenshots is! List<VnScreenshot> || initialIndex is! int) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const InvalidRouteScreen(
              title: 'Gallery Not Found',
              message: 'This gallery was opened with invalid image data.',
            ),
          );
        }

        return CustomTransitionPage<void>(
          key: state.pageKey,
          opaque: false,
          barrierColor: Colors.transparent,
          transitionDuration: const Duration(milliseconds: 150),
          reverseTransitionDuration: const Duration(milliseconds: 150),
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
