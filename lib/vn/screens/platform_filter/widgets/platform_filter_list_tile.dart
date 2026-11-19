import 'package:material_ui/material_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../theme/app_theme.dart';
import '../../../constants/vndb_platforms.dart';
import '../../../widgets/filter_selectable_list_tile.dart';

class PlatformFilterListTile extends StatelessWidget {
  const PlatformFilterListTile({
    super.key,
    required this.platform,
    required this.isSelected,
    required this.onTap,
  });

  final VndbPlatform platform;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterSelectableListTile(
      leading: FaIcon(
        platform.icon,
        size: 16,
        color: isSelected
            ? context.theme.colorScheme.onPrimaryContainer
            : context.theme.colorScheme.onSurface,
      ),
      title: platform.label,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}
