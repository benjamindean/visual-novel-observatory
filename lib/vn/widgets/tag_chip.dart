import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TagChip extends StatelessWidget {
  final String label;
  final double? score;
  final VoidCallback? onTap;

  const TagChip({super.key, required this.label, this.score, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: context.appSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: context.appTextPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (score != null) ...[
                const SizedBox(width: 4),
                Text(
                  '• ${score!.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: context.appAccentTeal,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
