import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';
import '../../../models/vndb_label.dart';
import 'library_sliver_app_bar.dart';

class LibraryEmptyLabelView extends StatelessWidget {
  const LibraryEmptyLabelView({
    super.key,
    required this.label,
  });

  final VndbLabel label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      key: PageStorageKey('library_empty_scroll_${label.id}'),
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      slivers: [
        LibrarySliverAppBar(title: label.label ?? 'Library'),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.folder_open_rounded,
                    size: 64,
                    color: context.appTextMuted,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Empty List',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.appTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No visual novels in "${label.label ?? ''}"',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: context.appTextMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
