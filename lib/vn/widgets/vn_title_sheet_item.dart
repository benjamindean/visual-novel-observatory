import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../models/visual_novel.dart';
import '../utils/language_display.dart';
import 'app_chip.dart';
import 'chip_overflow_wrap.dart';

class VnTitleSheetItem extends StatelessWidget {
  const VnTitleSheetItem({
    super.key,
    required this.title,
  });

  final VnTitle title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final latin = title.latin;

    return Material(
      color: context.appSurface,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.title,
              style: theme.textTheme.titleMedium?.copyWith(
                color: context.appTextPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (latin != null && latin.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                latin,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: context.appTextSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            const SizedBox(height: 12),
            ChipOverflowWrap(
              initialLimit: 4,
              children: [
                AppChip(
                  label: languageDisplayName(context, title.lang),
                  leadingIcon: Icons.language_rounded,
                  backgroundColor: context.appSearchField,
                ),
                if (title.main)
                  AppChip(
                    label: 'Main title',
                    leadingIcon: Icons.star_outline_rounded,
                    iconColor: context.colorScheme.tertiary,
                    backgroundColor: context.appSearchField,
                  ),
                if (title.official)
                  AppChip(
                    label: 'Official',
                    leadingIcon: Icons.verified_outlined,
                    backgroundColor: context.appSearchField,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
