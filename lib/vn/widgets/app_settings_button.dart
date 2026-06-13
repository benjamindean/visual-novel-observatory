import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';

class AppSettingsButton extends StatelessWidget {
  const AppSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(18),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.settings_outlined,
          size: 18,
          color: context.appTextPrimary,
        ),
        onPressed: () {
          context.push('/settings');
        },
        tooltip: 'Settings',
      ),
    );
  }
}
