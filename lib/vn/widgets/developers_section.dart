import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/vn_developer.dart';
import 'app_chip.dart';

class DevelopersSection extends StatelessWidget {
  const DevelopersSection({
    super.key,
    required this.developers,
  });

  final List<VnDeveloper> developers;

  @override
  Widget build(BuildContext context) {
    final displayDevelopers = developers
        .where(
          (developer) => developer.id.isNotEmpty && developer.name.isNotEmpty,
        )
        .toList();

    if (displayDevelopers.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayDevelopers.length == 1 ? 'Developer' : 'Developers',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: displayDevelopers
              .map(
                (developer) => AppChip(
                  label: developer.name,
                  leadingIcon: Icons.business_rounded,
                  onTap: () {
                    context.push(
                      '/developer-list',
                      extra: {
                        'developerId': developer.id,
                        'developerName': developer.name,
                      },
                    );
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
