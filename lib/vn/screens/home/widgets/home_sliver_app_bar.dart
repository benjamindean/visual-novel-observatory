import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme/app_theme.dart';
import '../../../providers/vn_providers.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_settings_button.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({
    super.key,
    required this.tab,
  });

  final HomeTabDefinition tab;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      floating: true,
      snap: true,
      pinned: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: context.appBackground,
      titleSpacing: 20,
      title: Text(
        tab.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        if (tab.isCustom)
          AppIconButton(
            icon: Icons.edit_rounded,
            tooltip: 'Edit ${tab.title}',
            onPressed: () {
              context.push('/home/edit-filter', extra: tab.id);
            },
            backgroundColor: context.colorScheme.secondaryContainer,
            foregroundColor: context.colorScheme.onSecondaryContainer,
          ),
        if (tab.isCustom) const SizedBox(width: 8),
        const AppSettingsButton(),
        const SizedBox(width: 20),
      ],
    );
  }
}
