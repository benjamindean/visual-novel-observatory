import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class TagFilterCachingPlaceholder extends StatelessWidget {
  final double progress;

  const TagFilterCachingPlaceholder({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: context.appAccentTeal,
            ),
            const SizedBox(height: 20),
            Text(
              'Caching tags database locally...\n${(progress * 100).toStringAsFixed(0)}%',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.appTextSecondary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'This only happens once. Subsequent tag searches will be instant.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.appTextMuted,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
