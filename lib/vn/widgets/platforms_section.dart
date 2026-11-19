import 'package:material_ui/material_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'app_chip.dart';
import 'chip_overflow_wrap.dart';
import '../../theme/app_theme.dart';
import '../constants/vndb_platforms.dart';

class PlatformsSection extends StatelessWidget {
  final List<String> platforms;

  const PlatformsSection({super.key, required this.platforms});

  @override
  Widget build(BuildContext context) {
    if (platforms.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Platforms',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ChipOverflowWrap(
          children: platforms.map((platformCode) {
            final platform = vndbPlatformById(platformCode.toLowerCase());

            return AppChip(
              label: platform?.label ?? platformCode.toUpperCase(),
              leading: FaIcon(
                platform?.icon ?? FontAwesomeIcons.gamepad,
                size: 14,
                color: context.appAccentTeal,
              ),
              onTap: () {},
            );
          }).toList(),
        ),
      ],
    );
  }
}
