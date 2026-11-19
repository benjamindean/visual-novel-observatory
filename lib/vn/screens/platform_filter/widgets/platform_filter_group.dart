import 'package:material_ui/material_ui.dart';

import '../../../../theme/app_theme.dart';
import '../../../constants/vndb_platforms.dart';
import 'platform_filter_list_tile.dart';

class PlatformFilterGroup extends StatelessWidget {
  const PlatformFilterGroup({
    super.key,
    required this.title,
    required this.platforms,
    required this.selectedPlatformIds,
    required this.onPlatformTap,
  });

  final String title;
  final List<VndbPlatform> platforms;
  final Set<String> selectedPlatformIds;
  final ValueChanged<VndbPlatform> onPlatformTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              title,
              style: context.theme.textTheme.labelLarge?.copyWith(
                color: context.appTextSecondary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ...platforms.map((platform) {
            return PlatformFilterListTile(
              platform: platform,
              isSelected: selectedPlatformIds.contains(platform.id),
              onTap: () => onPlatformTap(platform),
            );
          }),
        ],
      ),
    );
  }
}
