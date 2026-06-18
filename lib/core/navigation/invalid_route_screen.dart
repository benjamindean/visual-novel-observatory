import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class InvalidRouteScreen extends StatelessWidget {
  const InvalidRouteScreen({
    super.key,
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appBackground,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: context.appBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: context.theme.textTheme.bodyLarge?.copyWith(
              color: context.appTextSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
