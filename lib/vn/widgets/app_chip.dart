import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AppChip extends StatelessWidget {
  final String label;
  final Widget? leading;
  final IconData? leadingIcon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? iconColor;

  const AppChip({
    super.key,
    required this.label,
    this.leading,
    this.leadingIcon,
    this.trailing,
    this.onTap,
    this.backgroundColor,
    this.foregroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: backgroundColor ?? context.appSurface,
      borderRadius: BorderRadius.circular(12),
      // border: Border.all(
      //   color: context.appTextPrimary.withValues(
      //     alpha: context.theme.brightness == Brightness.light ? 0.10 : 0.05,
      //   ),
      // ),
    );

    final innerContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: 8),
        ] else if (leadingIcon != null) ...[
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
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: decoration,
          child: innerContent,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: decoration,
      child: innerContent,
    );
  }
}
