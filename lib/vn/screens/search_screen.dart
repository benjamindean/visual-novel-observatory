import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/vn_providers.dart';
import '../widgets/vn_card.dart';
import '../../theme/app_theme.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future.microtask(() {
      final query = ref.read(searchScreenQueryProvider);

      _searchController.text = query;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(vnSearchProvider.notifier).fetchVns();
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(vnSearchProvider);
    final recentVns = ref.watch(recentlyOpenedSearchProvider);
    final query = ref.watch(searchScreenQueryProvider);
    final theme = Theme.of(context);

    if (_searchController.text != query) {
      _searchController.text = query;
    }

    Widget buildBody() {
      // 1. Loading State (when no vns are loaded yet)
      if (searchState.isLoading && searchState.vns.isEmpty) {
        return CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              snap: false,
              pinned: false,
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: context.appBackground,
              titleSpacing: 20,
              title: Text(
                'Search',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: CircularProgressIndicator(color: context.appAccentTeal),
              ),
            ),
          ],
        );
      }

      // 2. Error State (when no vns are loaded yet)
      if (searchState.errorMessage != null && searchState.vns.isEmpty) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              snap: false,
              pinned: false,
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: context.appBackground,
              titleSpacing: 20,
              title: Text(
                'Search',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        size: 48,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        searchState.errorMessage!,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.appAccentTeal,
                          foregroundColor: context.colorScheme.onPrimary,
                        ),
                        onPressed: () =>
                            ref.read(vnSearchProvider.notifier).resetAndFetch(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }

      // 3. Initial Empty State (when search query is empty)
      if (query.trim().isEmpty) {
        if (recentVns.isEmpty) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                floating: true,
                snap: false,
                pinned: false,
                elevation: 0,
                scrolledUnderElevation: 0,
                backgroundColor: context.appBackground,
                titleSpacing: 20,
                title: Text(
                  'Search',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_rounded,
                          size: 64,
                          color: context.appTextMuted,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Search Visual Novels',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Search results and your recently viewed titles will appear here.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: context.appTextMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        // Recent searches list
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              snap: false,
              pinned: false,
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: context.appBackground,
              titleSpacing: 20,
              title: Text(
                'Search',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 16.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Searches',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        ref.read(recentlyOpenedSearchProvider.notifier).clear();
                      },
                      child: Text(
                        'Clear All',
                        style: TextStyle(color: context.appAccentTeal),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2 / 3,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final vn = recentVns[index];

                  return VnCard(
                    vn: vn,
                    onTap: () {
                      context.push('/detail', extra: vn);
                    },
                  );
                }, childCount: recentVns.length),
              ),
            ),
          ],
        );
      }

      // 4. No Results Found State
      if (searchState.vns.isEmpty) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              snap: false,
              pinned: false,
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: context.appBackground,
              titleSpacing: 20,
              title: Text(
                'Search',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 64,
                        color: context.appTextMuted,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No results found',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try searching for something else.',
                        style: TextStyle(color: context.appTextMuted),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }

      // 5. Results State
      return CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            snap: false,
            pinned: false,
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: context.appBackground,
            titleSpacing: 20,
            title: Text(
              'Search',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2 / 3,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final vn = searchState.vns[index];

                return VnCard(
                  vn: vn,
                  onTap: () {
                    ref.read(recentlyOpenedSearchProvider.notifier).addVn(vn);
                    context.push('/detail', extra: vn);
                  },
                );
              }, childCount: searchState.vns.length),
            ),
          ),
          if (searchState.hasMore)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: context.appAccentTeal,
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(child: buildBody()),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: context.appSurface,
                border: Border(
                  top: BorderSide(
                    color: context.appTextPrimary.withValues(alpha: 0.08),
                  ),
                ),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) {
                  ref.read(searchScreenQueryProvider.notifier).update(val);
                },
                decoration: InputDecoration(
                  hintText: 'Search a title...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            _searchController.clear();
                            ref
                                .read(searchScreenQueryProvider.notifier)
                                .update('');
                          },
                        )
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
