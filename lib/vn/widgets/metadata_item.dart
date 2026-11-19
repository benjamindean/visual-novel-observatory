import 'package:material_ui/material_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../theme/app_theme.dart';

class MetadataItem extends StatelessWidget {
  final FaIconData icon;
  final String label;
  final String value;
  final Color? iconColor;
  final Color? valueColor;
  final String? tooltipMessage;

  const MetadataItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
    this.valueColor,
    this.tooltipMessage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final content = Column(
      children: [
        FaIcon(
          icon,
          color: iconColor ?? context.appTextMuted,
          size: 18,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: valueColor ?? context.appTextPrimary,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );

    return Expanded(
      child: tooltipMessage == null
          ? content
          : Tooltip(
              message: tooltipMessage!,
              triggerMode: TooltipTriggerMode.tap,
              child: content,
            ),
    );
  }
}
