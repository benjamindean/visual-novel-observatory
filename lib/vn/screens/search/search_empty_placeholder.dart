import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class SearchEmptyPlaceholder extends StatelessWidget {
  const SearchEmptyPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_rounded,
              size: 64,
              color: context.appTextMuted,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Visual Novels',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.appTextSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Search results and your recently viewed titles will appear here.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: context.appTextMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
