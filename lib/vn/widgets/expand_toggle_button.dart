import 'package:flutter/material.dart';
import 'expand_chip_button.dart';

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
        ? (expandedLabel ?? 'Show less')
        : (collapsedLabel ?? 'Show more');

    return Align(
      alignment: Alignment.centerLeft,
      child: ExpandChipButton(
        label: labelText,
        isExpanded: isExpanded,
        onTap: onPressed,
      ),
    );
  }
}
