import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme/app_theme.dart';
import '../../../providers/vn_providers.dart';

class HomeTabLabel extends ConsumerWidget {
  const HomeTabLabel({
    super.key,
    required this.tab,
  });

  final HomeTabDefinition tab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (tab.id == HomeTabIds.createFilter) {
      return Tab(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 6.0,
              vertical: 6.0,
            ),
            child: Icon(
              Icons.add_rounded,
              size: 16,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    if (!tab.isCustom) {
      return Tab(text: tab.title);
    }

    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              tab.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              tooltip: 'Edit ${tab.title}',
              padding: EdgeInsets.zero,
              iconSize: 14,
              onPressed: () {
                context.push('/home/edit-filter', extra: tab.id);
              },
              icon: Icon(
                Icons.edit_rounded,
                color: context.colorScheme.outline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
