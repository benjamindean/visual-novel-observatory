import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';
import '../../../constants/vndb_platforms.dart';
import '../../../models/vn_release.dart';
import '../../../utils/vndb_date_display.dart';
import '../../../widgets/app_chip.dart';
import '../../../widgets/chip_overflow_wrap.dart';

class VnReleaseTile extends StatelessWidget {
  const VnReleaseTile({
    super.key,
    required this.vnId,
    required this.release,
  });

  final String vnId;
  final VnRelease release;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final releaseDate = formatVndbDate(release.released);
    final releaseType = release.releaseTypeFor(vnId);
    final chips = _buildChips(context, releaseType);

    return Material(
      color: context.appSurface,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: context.appAccentTeal,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        release.title,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: context.appTextPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        releaseDate,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: context.appTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (chips.isNotEmpty) ...[
              const SizedBox(height: 12),
              ChipOverflowWrap(children: chips),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _buildChips(BuildContext context, String? releaseType) {
    final chips = <Widget>[];

    if (releaseType != null) {
      chips.add(
        AppChip(
          label: _releaseTypeLabel(releaseType),
          leadingIcon: Icons.extension_outlined,
          backgroundColor: context.appSearchField,
        ),
      );
    }

    if (release.official) {
      chips.add(
        AppChip(
          label: 'Official',
          leadingIcon: Icons.verified_outlined,
          backgroundColor: context.appSearchField,
        ),
      );
    }

    if (release.patch) {
      chips.add(
        AppChip(
          label: 'Patch',
          leadingIcon: Icons.construction_outlined,
          backgroundColor: context.appSearchField,
        ),
      );
    }

    if (release.freeware) {
      chips.add(
        AppChip(
          label: 'Freeware',
          leadingIcon: Icons.download_for_offline_outlined,
          backgroundColor: context.appSearchField,
        ),
      );
    }

    if (release.uncensored == true) {
      chips.add(
        AppChip(
          label: 'Uncensored',
          leadingIcon: Icons.visibility_outlined,
          backgroundColor: context.appSearchField,
        ),
      );
    }

    if (release.minage != null) {
      chips.add(
        AppChip(
          label: '${release.minage}+',
          leadingIcon: Icons.shield_outlined,
          backgroundColor: context.appSearchField,
        ),
      );
    }

    for (final language in release.languages.take(2)) {
      chips.add(
        AppChip(
          label: _languageLabel(language),
          leadingIcon: Icons.language_rounded,
          backgroundColor: context.appSearchField,
        ),
      );
    }

    for (final platformCode in release.platforms.take(2)) {
      final platform = vndbPlatformById(platformCode.toLowerCase());

      chips.add(
        AppChip(
          label: platform?.label ?? platformCode.toUpperCase(),
          leadingIcon: Icons.devices_rounded,
          backgroundColor: context.appSearchField,
        ),
      );
    }

    return chips;
  }

  String _releaseTypeLabel(String releaseType) {
    switch (releaseType) {
      case 'complete':
        return 'Complete';
      case 'partial':
        return 'Partial';
      case 'trial':
        return 'Trial';
      default:
        return releaseType;
    }
  }

  String _languageLabel(VnReleaseLanguage language) {
    final code = language.lang.toUpperCase();

    if (language.mtl) {
      return '$code MTL';
    }

    return code;
  }
}
