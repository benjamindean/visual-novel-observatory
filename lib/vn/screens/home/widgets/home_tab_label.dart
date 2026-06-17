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
      return const Tab(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add_rounded,
              size: 16,
            ),
            SizedBox(width: 4),
            Text('New Filter'),
          ],
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
              iconSize: 16,
              onPressed: () {
                context.push('/home/edit-filter', extra: tab.id);
              },
              icon: Icon(
                Icons.edit_rounded,
                color: context.appTextMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
