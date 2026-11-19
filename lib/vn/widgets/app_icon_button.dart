import 'package:material_ui/material_ui.dart';

import '../../theme/app_theme.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.0,
      width: 36.0,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          icon,
          size: 18.0,
          color: foregroundColor ?? context.appTextPrimary,
        ),
        onPressed: onPressed,
        tooltip: tooltip,
      ),
    );
  }
}
