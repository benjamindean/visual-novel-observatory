import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/vn_providers.dart';

import '../../widgets/app_search_input.dart';
import '../../widgets/app_settings_button.dart';
import '../../../theme/app_theme.dart';
import 'widgets/search_body.dart';

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
    final theme = Theme.of(context);

    ref.listen<int>(searchDoubleTapProvider, (previous, next) {
      if (next > 0) {
        _searchFocusNode.requestFocus();
      }
    });

    ref.listen<String>(searchScreenQueryProvider, (previous, next) {
      if (_searchController.text != next) {
        _searchController.text = next;
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
            SearchBody(
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
