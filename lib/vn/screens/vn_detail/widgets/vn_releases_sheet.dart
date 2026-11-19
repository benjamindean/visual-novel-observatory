import 'package:material_ui/material_ui.dart';

import '../../../../theme/app_theme.dart';
import '../../../models/vn_release.dart';
import 'vn_release_tile.dart';

class VnReleasesSheet extends StatelessWidget {
  const VnReleasesSheet({
    super.key,
    required this.vnId,
    required this.releases,
  });

  final String vnId;
  final List<VnRelease> releases;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.90,
      builder: (context, scrollController) {
        final theme = Theme.of(context);
        final releaseCount = releases.length;
        final releaseLabel = releaseCount == 1
            ? '1 release'
            : '$releaseCount releases';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 16.0, 12.0, 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Releases',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: context.appTextPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          releaseLabel,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: context.appTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Close',
                    icon: const Icon(Icons.close_rounded),
                    color: context.appTextSecondary,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 28.0),
                itemCount: releases.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 12);
                },
                itemBuilder: (context, index) {
                  final release = releases[index];

                  return VnReleaseTile(
                    vnId: vnId,
                    release: release,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
