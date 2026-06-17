import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_theme.dart';
import '../../../models/vndb_label.dart';
import '../../../providers/vn_providers.dart';

class LibraryLabelTab extends ConsumerWidget {
  const LibraryLabelTab({
    super.key,
    required this.label,
  });

  final VndbLabel label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(libraryVnCountByLabelProvider(label.id));

    return Tab(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label.label ?? ''),
            const SizedBox(width: 6),
            Container(
              height: 18,
              constraints: const BoxConstraints(
                minWidth: 18,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              decoration: BoxDecoration(
                color: context.appAccentTeal,
                borderRadius: BorderRadius.circular(9),
              ),
              alignment: Alignment.center,
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: context.colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
