import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_chip.dart';
import '../models/vn_external_link.dart';

class LinksSection extends StatelessWidget {
  final List<VnExternalLink> extLinks;

  const LinksSection({super.key, required this.extLinks});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (extLinks.isEmpty) {
      return const SizedBox.shrink();
    }

    final uniqueLinks = {for (final l in extLinks) l.label: l}.values.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Links',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: uniqueLinks.map((link) {
            return AppChip(
              label: link.label,
              leadingIcon: Icons.link_rounded,
              onTap: () async {
                final uri = Uri.parse(link.url);

                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
