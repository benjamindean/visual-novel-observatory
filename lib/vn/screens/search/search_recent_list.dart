import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_confirmation_dialog.dart';
import '../../models/visual_novel.dart';
import '../../providers/vn_providers.dart';
import '../../widgets/vn_card.dart';
import '../../../theme/app_theme.dart';
import '../../../core/widgets/sliver_bottom_padding.dart';
import 'widgets/search_sliver_app_bar.dart';

class SearchRecentList extends ConsumerWidget {
  final List<VisualNovel> recentVns;

  const SearchRecentList({
    super.key,
    required this.recentVns,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SearchSliverAppBar(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              0,
              20,
              0,
            ),
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
                  onPressed: () async {
                    final confirm = await showAppConfirmationDialog(
                      context: context,
                      title: 'Clear Recent Searches?',
                      message:
                          'Are you sure you want to clear your search history?',
                      confirmLabel: 'Clear',
                    );

                    if (confirm) {
                      await ref
                          .read(recentlyOpenedSearchProvider.notifier)
                          .clear();
                    }
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
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final vn = recentVns[index];

                return VnCard(
                  vn: vn,
                  onTap: () {
                    context.push('/detail', extra: vn);
                  },
                );
              },
              childCount: recentVns.length,
            ),
          ),
        ),
        // Padding to ensure grid items scroll past the floating bottom bar
        const SliverBottomPadding(height: 90),
      ],
    );
  }
}
