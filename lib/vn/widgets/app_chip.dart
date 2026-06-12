import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AppChip extends StatelessWidget {
  final String label;
  final IconData? leadingIcon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? iconColor;

  const AppChip({
    super.key,
    required this.label,
    this.leadingIcon,
    this.trailing,
    this.onTap,
    this.backgroundColor,
    this.foregroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final chipContent = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor ?? context.appSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            Icon(
              leadingIcon,
              size: 16,
              color: iconColor ?? context.appAccentTeal,
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: foregroundColor ?? context.appTextPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (trailing != null) ...[const SizedBox(width: 4), trailing!],
        ],
      ),
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: chipContent,
        ),
      );
    }

    return chipContent;
  }
}
