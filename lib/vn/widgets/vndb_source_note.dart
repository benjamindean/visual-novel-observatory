import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class VndbSourceNote extends StatelessWidget {
  const VndbSourceNote({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'All data is sourced from VNDB.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: context.appTextMuted.withValues(alpha: 0.5),
            fontSize: 11.0,
            letterSpacing: 0.2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4.0),
        Text(
          'Observatory is not affiliated with VNDB.',
          style: theme.textTheme.labelSmall?.copyWith(
            color: context.appTextMuted.withValues(alpha: 0.35),
            fontSize: 10.0,
            letterSpacing: 0.1,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
