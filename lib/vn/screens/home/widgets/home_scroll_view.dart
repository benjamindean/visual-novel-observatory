import 'package:flutter/material.dart';

import 'home_list_slivers.dart';
import 'home_sliver_app_bar.dart';

class HomeScrollView extends StatelessWidget {
  const HomeScrollView({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: const [
        HomeSliverAppBar(),
        HomeListSlivers(),
      ],
    );
  }
}
