import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';
import '../../../widgets/app_settings_button.dart';

class LibrarySliverAppBar extends StatelessWidget {
  const LibrarySliverAppBar({
    super.key,
    this.title = 'Library',
  });

  final String title;

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
      centerTitle: false,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: const [
        AppSettingsButton(),
        SizedBox(width: 20),
      ],
    );
  }
}
