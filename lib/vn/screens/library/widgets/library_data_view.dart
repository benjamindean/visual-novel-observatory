import 'package:flutter/material.dart';

import '../../../models/vndb_label.dart';
import 'library_empty_labels_view.dart';
import 'library_tab_view.dart';

class LibraryDataView extends StatelessWidget {
  const LibraryDataView({
    super.key,
    required this.activeLabels,
  });

  final List<VndbLabel> activeLabels;

  @override
  Widget build(BuildContext context) {
    if (activeLabels.isEmpty) {
      return const LibraryEmptyLabelsView();
    }

    return TabBarView(
      children: [
        for (final label in activeLabels) LibraryTabView(label: label),
      ],
    );
  }
}
