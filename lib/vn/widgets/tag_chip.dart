import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TagChip extends StatelessWidget {
  final String label;
  final double? score;
  final VoidCallback? onTap;

  const TagChip({super.key, required this.label, this.score, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ActionChip(
      onPressed: onTap,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: context.appTextSecondary,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (score != null) ...[
            const SizedBox(width: 4),
            Text(
              '• ${score!.toStringAsFixed(1)}',
              style: theme.textTheme.labelSmall?.copyWith(
                color: context.appAccentTeal.withValues(alpha: 0.85),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
      backgroundColor: context.appSurface,
      side: BorderSide(color: context.appTextPrimary.withValues(alpha: 0.08)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
    );
  }
}
