import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/vn_providers.dart';
import '../widgets/home_bottom_bar.dart';
import '../widgets/vn_card.dart';
import '../../../theme/app_theme.dart';
import '../../auth/providers/auth_provider.dart';
import '../../settings/providers/settings_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future.microtask(() {
      ref.read(authProvider.notifier).loadCachedAuth();
      ref.read(settingsProvider.notifier).loadSettings();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(vnListProvider.notifier).fetchVns();
    }
  }

  @override
  Widget build(BuildContext context) {
    final listState = ref.watch(vnListProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.read(vnListProvider.notifier).resetAndFetch(),
          color: AppTheme.accentTeal,
          backgroundColor: AppTheme.surface,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Observatory',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.settings_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/settings');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    ref.watch(searchQueryProvider).isEmpty
                        ? 'Most Popular'
                        : 'Search Results',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (listState.isLoading)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.accentTeal,
                    ),
                  ),
                )
              else if (listState.errorMessage != null && listState.vns.isEmpty)
                SliverFillRemaining(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error: ${listState.errorMessage}',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.accentTeal,
                            ),
                            onPressed: () => ref
                                .read(vnListProvider.notifier)
                                .resetAndFetch(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else if (listState.vns.isEmpty)
                const SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No visual novels found',
                      style: TextStyle(color: AppTheme.textMuted),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index >= listState.vns.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.0),
                            child: Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: AppTheme.accentTeal,
                                ),
                              ),
                            ),
                          );
                        }

                        final vn = listState.vns[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: VnCard(
                            vn: vn,
                            onTap: () {
                              Navigator.of(
                                context,
                              ).pushNamed('/detail', arguments: vn.id);
                            },
                          ),
                        );
                      },
                      childCount:
                          listState.vns.length + (listState.hasMore ? 1 : 0),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const HomeBottomBar(),
    );
  }
}
