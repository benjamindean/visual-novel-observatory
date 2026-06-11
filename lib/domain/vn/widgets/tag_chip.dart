import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class TagChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const TagChip({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    final chip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.searchField,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppTheme.textSecondary,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: chip);
    }

    return chip;
  }
}
