import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/vn_external_link.dart';
import '../../theme/app_theme.dart';

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
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  final uri = Uri.parse(link.url);

                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: context.appSurface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.link_rounded,
                        size: 16,
                        color: context.appAccentTeal,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        link.label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: context.appTextPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
