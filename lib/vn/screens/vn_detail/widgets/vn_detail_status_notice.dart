import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';
import '../../../models/visual_novel.dart';

class VnDetailStatusNotice extends StatelessWidget {
  final VisualNovel vn;

  const VnDetailStatusNotice({
    super.key,
    required this.vn,
  });

  @override
  Widget build(BuildContext context) {
    if (vn.devStatus != 2) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: context.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.error.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.cancel_outlined,
            color: context.colorScheme.onErrorContainer,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Development cancelled',
              style: context.theme.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onErrorContainer,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
