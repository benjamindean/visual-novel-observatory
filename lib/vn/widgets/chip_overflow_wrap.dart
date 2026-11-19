import 'package:material_ui/material_ui.dart';

import 'expand_chip_button.dart';

class ChipOverflowWrap extends StatefulWidget {
  const ChipOverflowWrap({
    super.key,
    required this.children,
    this.initialLimit = 6,
    this.spacing = 8,
    this.runSpacing = 8,
  });

  final List<Widget> children;
  final int initialLimit;
  final double spacing;
  final double runSpacing;

  @override
  State<ChipOverflowWrap> createState() => _ChipOverflowWrapState();
}

class _ChipOverflowWrapState extends State<ChipOverflowWrap> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final visibleChildren = _isExpanded
        ? widget.children
        : widget.children.take(widget.initialLimit).toList();
    final hiddenCount = widget.children.length - widget.initialLimit;

    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
      children: [
        ...visibleChildren,
        if (!_isExpanded && hiddenCount > 0)
          ExpandChipButton(
            label: '$hiddenCount more',
            isExpanded: false,
            onTap: () {
              setState(() {
                _isExpanded = true;
              });
            },
          ),
        if (_isExpanded && hiddenCount > 0)
          ExpandChipButton(
            label: 'Show less',
            isExpanded: true,
            onTap: () {
              setState(() {
                _isExpanded = false;
              });
            },
          ),
      ],
    );
  }
}
