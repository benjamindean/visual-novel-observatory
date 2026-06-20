import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';

class LanguageFilterEmptyState extends StatelessWidget {
  const LanguageFilterEmptyState({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.translate_rounded,
              size: 64,
              color: context.appTextMuted,
            ),
            const SizedBox(height: 16),
            Text(
              query.isEmpty
                  ? 'No languages available'
                  : 'No languages found matching "$query"',
              style: TextStyle(
                color: context.appTextMuted,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
