import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class LoginSubmitButton extends StatelessWidget {
  final bool isValidating;
  final VoidCallback onPressed;

  const LoginSubmitButton({
    super.key,
    required this.isValidating,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: context.appAccentTeal,
          foregroundColor: context.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(27),
          ),
          elevation: 2,
        ),
        onPressed: isValidating ? null : onPressed,
        child: isValidating
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: context.colorScheme.onPrimary,
                ),
              )
            : const Text(
                'Verify & Connect',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
