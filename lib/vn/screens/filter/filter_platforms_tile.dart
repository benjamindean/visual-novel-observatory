import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../constants/vndb_platforms.dart';
import '../platform_filter/platform_filter_screen.dart';

class FilterPlatformsTile extends StatelessWidget {
  const FilterPlatformsTile({
    super.key,
    required this.selectedPlatforms,
    required this.onPlatformsChanged,
  });

  final List<String> selectedPlatforms;
  final ValueChanged<List<String>> onPlatformsChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.surfaceContainerHigh,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push<List<String>>(
                MaterialPageRoute(
                  builder: (context) => PlatformFilterScreen(
                    initialPlatformIds: selectedPlatforms,
                  ),
                ),
              )
              .then((result) {
                if (result != null) {
                  onPlatformsChanged(result);
                }
              });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (selectedPlatforms.isEmpty)
                      Text(
                        'Select Platforms...',
                        style: TextStyle(
                          color: context.appTextSecondary,
                          fontSize: 14,
                        ),
                      )
                    else
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: selectedPlatforms.map((platformId) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: context.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              vndbPlatformLabels[platformId] ??
                                  platformId.toUpperCase(),
                              style: TextStyle(
                                color: context
                                    .theme
                                    .colorScheme
                                    .onPrimaryContainer,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right_rounded, color: context.appTextMuted),
            ],
          ),
        ),
      ),
    );
  }
}
