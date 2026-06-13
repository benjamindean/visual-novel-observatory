import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class SettingsSectionHeader extends StatelessWidget {
  final String title;

  const SettingsSectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: context.appAccentTeal,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }
}
