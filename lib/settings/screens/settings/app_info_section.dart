import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../vn/widgets/vndb_source_note.dart';

class AppInfoSection extends StatelessWidget {
  const AppInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Text(
            'Observatory v1.0.0',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: context.appTextMuted,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12.0),
          const VndbSourceNote(),
        ],
      ),
    );
  }
}
