import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/vn_providers.dart';

import '../search_empty_placeholder.dart';
import '../search_error_view.dart';
import '../search_loading_view.dart';
import '../search_no_results.dart';
import '../search_recent_list.dart';
import '../search_results_grid.dart';
import 'search_status_scroll_view.dart';

class SearchBody extends ConsumerWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchScreenQueryProvider);

    if (query.trim().isEmpty) {
      final recentVns = ref.watch(recentlyOpenedSearchProvider);

      if (recentVns.isEmpty) {
        return const SearchStatusScrollView(
          child: SearchEmptyPlaceholder(),
        );
      }

      return SearchRecentList(recentVns: recentVns);
    }

    final searchState = ref.watch(vnSearchProvider);

    if (searchState.isLoading && searchState.vns.isEmpty) {
      return const SearchStatusScrollView(
        child: SearchLoadingView(),
      );
    }

    if (searchState.errorMessage != null && searchState.vns.isEmpty) {
      return SearchStatusScrollView(
        child: SearchErrorView(errorMessage: searchState.errorMessage!),
      );
    }

    if (searchState.vns.isEmpty) {
      return const SearchStatusScrollView(
        child: SearchNoResults(),
      );
    }

    return SearchResultsGrid(
      searchState: searchState,
    );
  }
}
