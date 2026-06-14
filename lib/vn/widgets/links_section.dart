import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_chip.dart';
import '../models/vn_external_link.dart';

class LinksSection extends StatelessWidget {
  final String vnId;
  final List<VnExternalLink> extLinks;

  const LinksSection({
    super.key,
    required this.vnId,
    required this.extLinks,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<VnExternalLink> finalLinks = [];

    // Add VNDB link first
    finalLinks.add(
      VnExternalLink(
        id: vnId,
        name: 'vndb',
        label: 'VNDB',
        url: 'https://vndb.org/$vnId',
      ),
    );

    final seenLabels = {'vndb'};

    for (final link in extLinks) {
      final labelLower = link.label.toLowerCase();

      if (!seenLabels.contains(labelLower)) {
        seenLabels.add(labelLower);
        finalLinks.add(link);
      }
    }

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
          children: finalLinks.map((link) {
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
