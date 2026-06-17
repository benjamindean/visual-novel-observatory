import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/vn_providers.dart';

import '../search_empty_placeholder.dart';
import '../search_error_view.dart';
import '../search_loading_view.dart';
import '../search_no_results.dart';
import '../search_recent_list.dart';
import '../search_results_grid.dart';

class SearchBody extends ConsumerWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(vnSearchProvider);
    final recentVns = ref.watch(recentlyOpenedSearchProvider);
    final query = ref.watch(searchScreenQueryProvider);

    // 1. Loading State (when no vns are loaded yet)

    if (searchState.isLoading && searchState.vns.isEmpty) {
      return const SearchLoadingView();
    }

    // 2. Error State (when no vns are loaded yet)
    if (searchState.errorMessage != null && searchState.vns.isEmpty) {
      return SearchErrorView(errorMessage: searchState.errorMessage!);
    }

    // 3. Initial Empty State (when search query is empty)
    if (query.trim().isEmpty) {
      if (recentVns.isEmpty) {
        return const SearchEmptyPlaceholder();
      }

      // Recent searches list
      return SearchRecentList(recentVns: recentVns);
    }

    // 4. No Results Found State
    if (searchState.vns.isEmpty) {
      return const SearchNoResults();
    }

    // 5. Results State
    return SearchResultsGrid(
      searchState: searchState,
    );
  }
}
