import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class FilterSelectableListTile extends StatelessWidget {
  const FilterSelectableListTile({
    super.key,
    required this.leading,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.subtitle,
  });

  final Widget leading;
  final String title;
  final String? subtitle;
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
                  ? context.colorScheme.surfaceContainerLow
                  : context.colorScheme.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            child: SizedBox(
              width: 36.0,
              height: 36.0,
              child: Center(
                child: leading,
              ),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: isSelected
                  ? context.colorScheme.onSurface
                  : context.appTextPrimary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          subtitle: subtitle == null
              ? null
              : Text(
                  subtitle!,
                  style: TextStyle(color: context.appTextSecondary),
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
