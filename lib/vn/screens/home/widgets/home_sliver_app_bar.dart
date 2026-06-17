import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_theme.dart';
import '../../../providers/vn_providers.dart';
import '../../../widgets/app_settings_button.dart';
import 'home_filter_button.dart';

class HomeSliverAppBar extends ConsumerWidget {
  const HomeSliverAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return SliverAppBar(
      floating: true,
      snap: false,
      pinned: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: context.appBackground,
      titleSpacing: 20,
      title: GestureDetector(
        onDoubleTap: () {
          ref.read(homeDoubleTapProvider.notifier).increment();
        },
        child: Text(
          'Home',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
      ),
      actions: const [
        HomeFilterButton(),
        SizedBox(width: 8),
        AppSettingsButton(),
        SizedBox(width: 20),
      ],
    );
  }
}
