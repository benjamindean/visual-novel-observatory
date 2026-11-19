import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      child: Text(
        tab.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
