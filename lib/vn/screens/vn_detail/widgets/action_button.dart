import 'package:flutter/material.dart';
import '../../../../theme/app_theme.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.appSurface,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(
            icon,
            color: context.theme.colorScheme.secondary,
            size: 22,
          ),
        ),
      ),
    );
  }
}
