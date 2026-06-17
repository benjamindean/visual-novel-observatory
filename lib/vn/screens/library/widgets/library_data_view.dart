import 'package:flutter/material.dart';

import '../../../models/vndb_label.dart';
import 'library_empty_labels_view.dart';
import 'library_sliver_app_bar.dart';
import 'library_tab_view.dart';

class LibraryDataView extends StatelessWidget {
  const LibraryDataView({
    super.key,
    required this.activeLabels,
    required this.nestedScrollViewKey,
    required this.outerScrollController,
  });

  final List<VndbLabel> activeLabels;
  final GlobalKey<NestedScrollViewState> nestedScrollViewKey;
  final ScrollController outerScrollController;

  @override
  Widget build(BuildContext context) {
    if (activeLabels.isEmpty) {
      return const LibraryEmptyLabelsView();
    }

    return NestedScrollView(
      key: nestedScrollViewKey,
      controller: outerScrollController,
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return const [
          LibrarySliverAppBar(),
        ];
      },
      body: TabBarView(
        children: [
          for (final label in activeLabels) LibraryTabView(label: label),
        ],
      ),
    );
  }
}
