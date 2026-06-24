import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/vn_providers.dart';
import '../../widgets/vn_card.dart';
import '../../../core/widgets/sliver_bottom_padding.dart';
import '../../../core/widgets/sliver_loading_indicator.dart';
import 'widgets/search_sliver_app_bar.dart';

class SearchResultsGrid extends ConsumerWidget {
  final VnListState searchState;

  const SearchResultsGrid({
    super.key,
    required this.searchState,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SearchSliverAppBar(),
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
                final vn = searchState.vns[index];

                return VnCard(
                  vn: vn,
                  onTap: () {
                    ref.read(recentlyOpenedSearchProvider.notifier).addVn(vn);
                    context.push('/detail', extra: vn);
                  },
                );
              },
              childCount: searchState.vns.length,
            ),
          ),
        ),
        if (searchState.hasMore) const SliverLoadingIndicator(),
        // Padding to ensure grid items scroll past the floating bottom bar
        const SliverBottomPadding(height: 64),
      ],
    );
  }
}
