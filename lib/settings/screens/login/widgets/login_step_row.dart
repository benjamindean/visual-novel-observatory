import 'package:flutter/material.dart';
import '../../../../theme/app_theme.dart';

class LoginStepRow extends StatelessWidget {
  final String stepNumber;
  final String text;

  const LoginStepRow({
    super.key,
    required this.stepNumber,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.appSearchField,
            shape: BoxShape.circle,
          ),
          child: Text(
            stepNumber,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: context.appAccentTeal,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: context.appTextSecondary,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
