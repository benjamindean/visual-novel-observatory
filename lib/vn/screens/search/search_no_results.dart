import 'package:material_ui/material_ui.dart';

import '../../../theme/app_theme.dart';

class SearchNoResults extends StatelessWidget {
  const SearchNoResults({super.key});

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
              Icons.search_off_rounded,
              size: 64,
              color: context.appTextMuted,
            ),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.appTextSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try searching for something else.',
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
