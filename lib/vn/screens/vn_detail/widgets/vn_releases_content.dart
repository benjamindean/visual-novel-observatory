import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';
import '../../../models/vn_release.dart';
import '../../../utils/vndb_date_display.dart';
import 'vn_releases_sheet.dart';

class VnReleasesContent extends StatelessWidget {
  const VnReleasesContent({
    super.key,
    required this.vnId,
    required this.releases,
  });

  final String vnId;
  final List<VnRelease> releases;

  @override
  Widget build(BuildContext context) {
    if (releases.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final releaseCount = releases.length;
    final releaseLabel = releaseCount == 1
        ? '1 release'
        : '$releaseCount releases';
    final latestReleaseDate = formatVndbDate(releases.first.released);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Releases',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Material(
          color: context.appSurface,
          borderRadius: BorderRadius.circular(12),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => _showReleasesSheet(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 14.0,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    color: context.appAccentTeal,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          releaseLabel,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: context.appTextPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Latest: $latestReleaseDate',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: context.appTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: context.appTextSecondary,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  void _showReleasesSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: false,
      backgroundColor: context.appBackground,
      builder: (context) {
        return VnReleasesSheet(
          vnId: vnId,
          releases: releases,
        );
      },
    );
  }
}
