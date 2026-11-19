import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme/app_theme.dart';
import '../../../providers/vn_providers.dart';
import '../../../widgets/vn_card.dart';
import '../../../../core/widgets/sliver_loading_indicator.dart';
import 'home_sliver_app_bar.dart';

class HomeVnTabView extends ConsumerStatefulWidget {
  const HomeVnTabView({
    super.key,
    required this.tab,
  });

  final HomeTabDefinition tab;

  @override
  ConsumerState<HomeVnTabView> createState() => HomeVnTabViewState();
}

class HomeVnTabViewState extends ConsumerState<HomeVnTabView> {
  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.metrics.pixels >=
        notification.metrics.maxScrollExtent - 200) {
      ref.read(homeVnListProvider(widget.tab.id).notifier).fetchVns();
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final listState = ref.watch(homeVnListProvider(widget.tab.id));
    final theme = Theme.of(context);

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: CustomScrollView(
        key: PageStorageKey('home_tab_scroll_${widget.tab.id}'),
        physics: const BouncingScrollPhysics(),
        slivers: [
          HomeSliverAppBar(tab: widget.tab),
          if (listState.isLoading)
            SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(
                  color: context.appAccentTeal,
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
                        onPressed: () {
                          ref
                              .read(homeVnListProvider(widget.tab.id).notifier)
                              .resetAndFetch();
                        },
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
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.explore_off_outlined,
                        size: 64,
                        color: context.appTextMuted,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No Visual Novels Found',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.appTextSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try a different saved filter.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: context.appTextMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else ...[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                16,
                0,
                16,
                16,
              ),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2 / 3,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final vn = listState.vns[index];

                    return VnCard(
                      vn: vn,
                      onTap: () {
                        context.push('/detail', extra: vn);
                      },
                    );
                  },
                  childCount: listState.vns.length,
                ),
              ),
            ),
            if (listState.hasMore) const SliverLoadingIndicator(),
          ],
        ],
      ),
    );
  }
}
