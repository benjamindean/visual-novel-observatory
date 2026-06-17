import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';

class VnDetailUserActionButton extends StatelessWidget {
  const VnDetailUserActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isLoading,
    required this.onPressed,
    this.count,
  });

  final IconData icon;
  final String label;
  final bool isLoading;
  final VoidCallback onPressed;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: context.appSurface,
        foregroundColor: context.appTextPrimary,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 0,
      ),
      onPressed: isLoading ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: context.appAccentTeal,
                  ),
                )
              : Icon(
                  icon,
                  size: 20,
                  color: context.appAccentTeal,
                ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          if (count != null) ...[
            const SizedBox(width: 8),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: context.appAccentTeal,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '$count',
                style: TextStyle(
                  color: context.colorScheme.onPrimary,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
