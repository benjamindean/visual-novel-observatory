import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../utils/vndb_content_sensitivity.dart';

class RevealImageButton extends StatelessWidget {
  const RevealImageButton({
    super.key,
    required this.onPressed,
    required this.reasons,
  });

  final VoidCallback onPressed;
  final List<VndbContentSensitivityReason> reasons;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.visibility_off_rounded,
          color: context.appTextPrimary.withValues(alpha: 0.7),
          size: 44,
        ),
        const SizedBox(height: 10),
        Text(
          'Image Hidden',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.appTextPrimary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (reasons.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            _formatReasons(reasons),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.appTextSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        const SizedBox(height: 16),
        ElevatedButton.icon(
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
        ),
      ],
    );
  }

  String _formatReasons(List<VndbContentSensitivityReason> reasons) {
    final labels = reasons.map(_reasonLabel).toList();

    if (labels.length == 1) {
      return labels.single;
    }

    if (labels.length == 2) {
      return '${labels.first} and ${labels.last}';
    }

    return '${labels.sublist(0, labels.length - 1).join(', ')}, '
        'and ${labels.last}';
  }

  String _reasonLabel(VndbContentSensitivityReason reason) {
    return switch (reason) {
      VndbContentSensitivityReason.spoiler => 'Spoiler content',
      VndbContentSensitivityReason.sexual => 'Sexual content',
      VndbContentSensitivityReason.violent => 'Violent content',
    };
  }
}
