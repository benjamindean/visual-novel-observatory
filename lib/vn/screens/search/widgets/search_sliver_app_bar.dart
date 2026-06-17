import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_theme.dart';
import '../../../providers/vn_providers.dart';
import '../../../widgets/app_settings_button.dart';

class SearchSliverAppBar extends ConsumerWidget {
  const SearchSliverAppBar({super.key});

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
      centerTitle: false,
      title: GestureDetector(
        onDoubleTap: () {
          ref.read(searchDoubleTapProvider.notifier).increment();
        },
        child: Text(
          'Search',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
      ),
      actions: const [
        AppSettingsButton(),
        SizedBox(width: 20),
      ],
    );
  }
}
