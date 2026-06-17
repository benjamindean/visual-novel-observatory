import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/vn_providers.dart';

import '../../widgets/app_search_input.dart';
import '../../../theme/app_theme.dart';
import 'widgets/search_body.dart';
import 'widgets/search_sliver_app_bar.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final query = ref.read(searchScreenQueryProvider);

      _searchController.text = query;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    final query = ref.read(searchScreenQueryProvider);

    if (query.trim().isEmpty || notification.metrics.axis != Axis.vertical) {
      return false;
    }

    if (notification.metrics.pixels >=
        notification.metrics.maxScrollExtent - 200) {
      ref.read(vnSearchProvider.notifier).fetchVns();
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
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
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return const [
            SearchSliverAppBar(),
          ];
        },
        body: Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child: const SearchBody(),
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
