import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme/app_theme.dart';
import '../../../providers/vn_providers.dart';

class HomeFilterButton extends ConsumerWidget {
  const HomeFilterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasActiveFilters = ref.watch(hasActiveHomeFiltersProvider);
    final theme = Theme.of(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 36,
          decoration: BoxDecoration(
            color: hasActiveFilters
                ? context.theme.colorScheme.secondary
                : context.theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(18),
          ),
          child: TextButton.icon(
            label: Text(
              'Filter',
              style: theme.textTheme.labelLarge?.copyWith(
                color: hasActiveFilters
                    ? context.theme.colorScheme.onSecondary
                    : context.theme.colorScheme.onPrimaryContainer,
              ),
            ),
            icon: Icon(
              Icons.tune_rounded,
              size: 18,
              color: hasActiveFilters
                  ? context.theme.colorScheme.onSecondary
                  : context.theme.colorScheme.onPrimaryContainer,
            ),
            onPressed: () {
              context.push('/filters');
            },
          ),
        ),
        if (hasActiveFilters)
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: context.appAccentAmber,
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.appBackground,
                  width: 1.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
