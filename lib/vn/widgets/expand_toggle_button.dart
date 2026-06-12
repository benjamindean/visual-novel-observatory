import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ExpandToggleButton extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onPressed;
  final String? expandedLabel;
  final String? collapsedLabel;

  const ExpandToggleButton({
    super.key,
    required this.isExpanded,
    required this.onPressed,
    this.expandedLabel,
    this.collapsedLabel,
  });

  @override
  Widget build(BuildContext context) {
    final labelText = isExpanded
        ? (expandedLabel ?? 'Show Less')
        : (collapsedLabel ?? 'Show More');

    final iconData = isExpanded
        ? Icons.keyboard_arrow_up_rounded
        : Icons.keyboard_arrow_down_rounded;

    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(iconData, color: context.appAccentTeal, size: 20),
        label: Text(
          labelText,
          style: TextStyle(
            color: context.appAccentTeal,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(50, 30),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
