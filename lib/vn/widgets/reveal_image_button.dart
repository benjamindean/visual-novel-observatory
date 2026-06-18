import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class RevealImageButton extends StatelessWidget {
  const RevealImageButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: context.appTextPrimary.withValues(alpha: 0.1),
        foregroundColor: context.appTextPrimary,
        side: BorderSide(
          color: context.appTextPrimary.withValues(alpha: 0.3),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
      ),
      onPressed: onPressed,
      icon: const Icon(
        Icons.visibility_rounded,
        size: 16,
      ),
      label: const Text(
        'Reveal Image',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
