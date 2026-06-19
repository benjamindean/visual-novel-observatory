import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../theme/app_theme.dart';
import '../../../constants/vndb_platforms.dart';

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        color: isSelected
            ? context.colorScheme.surfaceContainerHigh
            : context.appSurface,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: DecoratedBox(
            decoration: BoxDecoration(
              color: isSelected
                  ? context.colorScheme.primaryContainer
                  : context.colorScheme.surfaceContainer,
              shape: BoxShape.circle,
            ),
            child: SizedBox(
              width: 36,
              height: 36,
              child: Center(
                child: FaIcon(
                  platform.icon,
                  size: 16,
                  color: isSelected
                      ? context.appAccentTeal
                      : context.appTextSecondary,
                ),
              ),
            ),
          ),
          title: Text(
            platform.label,
            style: TextStyle(
              color: isSelected
                  ? context.colorScheme.onPrimaryContainer
                  : context.appTextPrimary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          trailing: Checkbox(
            activeColor: context.appAccentTeal,
            checkColor: context.colorScheme.onPrimary,
            value: isSelected,
            onChanged: (_) => onTap(),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
