import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class TagChip extends StatelessWidget {
  final String label;
  final double? score;
  final VoidCallback? onTap;

  const TagChip({super.key, required this.label, this.score, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final chip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: context.appSearchField,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
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
            const SizedBox(width: 6),
            Text(
              score!.toStringAsFixed(1),
              style: theme.textTheme.labelSmall?.copyWith(
                color: context.appTextMuted,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: chip);
    }

    return chip;
  }
}
