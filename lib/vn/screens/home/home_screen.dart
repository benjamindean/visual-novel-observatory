import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/vn_providers.dart';
import '../../widgets/vn_card.dart';
import '../../../theme/app_theme.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../settings/providers/settings_provider.dart';

import '../../widgets/app_settings_button.dart';

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
    final filters = ref.watch(vnFilterProvider);
    final settings = ref.watch(settingsProvider);
    final theme = Theme.of(context);

    final hasActiveFilters =
        filters.lang != settings.defaultLanguage ||
        filters.platform != settings.defaultPlatform ||
        filters.length != null ||
        filters.devStatus != null ||
        filters.minRating != 7.0 ||
        filters.minVotes != 50 ||
        filters.tags.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () =>
                    ref.read(vnListProvider.notifier).resetAndFetch(),
                color: context.appAccentTeal,
                backgroundColor: context.appSurface,
                child: CustomScrollView(
                  controller: _scrollController,
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
                        'All',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      actions: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                color: context.colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.tune_rounded,
                                  size: 18,
                                  color: hasActiveFilters
                                      ? context.appAccentAmber
                                      : context.appTextPrimary,
                                ),
                                onPressed: () {
                                  context.push('/filters');
                                },
                                tooltip: 'Filters',
                              ),
                            ),
                            if (hasActiveFilters)
                              Positioned(
                                top: -2,
                                right: -2,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: context.appAccentAmber,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: context.appBackground,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        const AppSettingsButton(),
                        const SizedBox(width: 20),
                      ],
                    ),

                    if (listState.isLoading)
                      SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: context.appAccentTeal,
                          ),
                        ),
                      )
                    else if (listState.errorMessage != null &&
                        listState.vns.isEmpty)
                      SliverFillRemaining(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 48,
                                  color: context.colorScheme.error,
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
                                    backgroundColor: context.appAccentTeal,
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
                      SliverFillRemaining(
                        child: Center(
                          child: Text(
                            'No visual novels found',
                            style: TextStyle(color: context.appTextMuted),
                          ),
                        ),
                      )
                    else ...[
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 2 / 3,
                              ),
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final vn = listState.vns[index];

                            return VnCard(
                              vn: vn,
                              onTap: () {
                                context.push('/detail', extra: vn);
                              },
                            );
                          }, childCount: listState.vns.length),
                        ),
                      ),
                      if (listState.hasMore)
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
