import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/vn_providers.dart';
import '../../models/visual_novel.dart';
import '../../widgets/app_search_input.dart';
import '../../widgets/app_settings_button.dart';
import '../../../theme/app_theme.dart';
import 'search_loading_view.dart';
import 'search_error_view.dart';
import 'search_empty_placeholder.dart';
import 'search_recent_list.dart';
import 'search_no_results.dart';
import 'search_results_grid.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _searchFocusNode = FocusNode();

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
    _searchFocusNode.dispose();
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

    ref.listen<int>(searchDoubleTapProvider, (previous, next) {
      if (next > 0) {
        _searchFocusNode.requestFocus();
      }
    });

    return Scaffold(
      backgroundColor: context.appBackground,
      appBar: AppBar(
        titleSpacing: 20,
        centerTitle: false,
        backgroundColor: context.appBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: GestureDetector(
          onDoubleTap: () {
            ref.read(searchDoubleTapProvider.notifier).increment();
          },
          child: Text(
            'Search',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
        ),
        actions: const [
          AppSettingsButton(),
          SizedBox(width: 20),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            _SearchBody(
              searchState: searchState,
              recentVns: recentVns,
              query: query,
              scrollController: _scrollController,
            ),
            // Floating organic bottom search bar (thumb-stretch aware)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: AppSearchInput(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  onChanged: (val) {
                    ref.read(searchScreenQueryProvider.notifier).update(val);
                  },
                  hintText: 'Search visual novels...',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBody extends ConsumerWidget {
  final VnListState searchState;
  final List<VisualNovel> recentVns;
  final String query;
  final ScrollController scrollController;

  const _SearchBody({
    required this.searchState,
    required this.recentVns,
    required this.query,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      scrollController: scrollController,
    );
  }
}
