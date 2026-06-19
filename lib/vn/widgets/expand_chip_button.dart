import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'app_chip.dart';

class ExpandChipButton extends StatelessWidget {
  const ExpandChipButton({
    super.key,
    required this.label,
    required this.isExpanded,
    required this.onTap,
  });

  final String label;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppChip(
      label: label,
      leadingIcon: isExpanded ? Icons.remove_rounded : Icons.add_rounded,
      foregroundColor: context.colorScheme.primary,
      iconColor: context.colorScheme.primary,
      backgroundColor: context.colorScheme.surface.withValues(alpha: 0.50),
      onTap: onTap,
    );
  }
}
