import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.badgeCount,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final int? badgeCount;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = context.colorScheme.onPrimary;
    final visibleBadgeCount = badgeCount ?? 0;

    return ColoredBox(
      color: context.colorScheme.surfaceContainerHigh,
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20.0,
            12.0,
            20.0,
            12.0,
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.appAccentTeal,
              foregroundColor: foregroundColor,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: foregroundColor,
                  ),
                  const SizedBox(width: 8.0),
                ],
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                if (visibleBadgeCount > 0) ...[
                  const SizedBox(width: 8.0),
                  Container(
                    width: 24.0,
                    height: 24.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: foregroundColor.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: foregroundColor.withValues(alpha: 0.28),
                      ),
                    ),
                    child: Text(
                      '$visibleBadgeCount',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: foregroundColor,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w800,
                        height: 1.0,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
