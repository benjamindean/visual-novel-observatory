import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';
import '../../../widgets/spoiler_text.dart';

class CharacterAboutSection extends StatelessWidget {
  const CharacterAboutSection({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (description.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: theme.textTheme.titleMedium?.copyWith(
            color: context.appTextPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SpoilerText(
          text: description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: context.appTextSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
