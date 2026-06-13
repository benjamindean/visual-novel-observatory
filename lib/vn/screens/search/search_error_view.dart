import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/vn_providers.dart';
import '../../../theme/app_theme.dart';

class SearchErrorView extends ConsumerWidget {
  final String errorMessage;

  const SearchErrorView({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: context.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.appAccentTeal,
                foregroundColor: context.colorScheme.onPrimary,
              ),
              onPressed: () =>
                  ref.read(vnSearchProvider.notifier).resetAndFetch(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
