import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';
import '../../../widgets/reveal_image_button.dart';

class VnGallerySensitiveOverlay extends StatelessWidget {
  const VnGallerySensitiveOverlay({
    super.key,
    required this.onReveal,
  });

  final VoidCallback onReveal;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.visibility_off_rounded,
              color: context.appTextPrimary.withValues(alpha: 0.7),
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              'Sensitive Content Hidden',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.appTextPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            RevealImageButton(
              onPressed: onReveal,
            ),
          ],
        ),
      ),
    );
  }
}
