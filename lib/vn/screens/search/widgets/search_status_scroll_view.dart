import 'package:flutter/material.dart';

import 'search_sliver_app_bar.dart';

class SearchStatusScrollView extends StatelessWidget {
  const SearchStatusScrollView({
    super.key,
    required this.child,
    this.physics = const BouncingScrollPhysics(),
  });

  final Widget child;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: physics,
      slivers: [
        const SearchSliverAppBar(),
        SliverFillRemaining(
          hasScrollBody: false,
          child: child,
        ),
      ],
    );
  }
}
