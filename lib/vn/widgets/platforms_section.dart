import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'app_chip.dart';
import '../../theme/app_theme.dart';

class PlatformsSection extends StatelessWidget {
  final List<String> platforms;

  const PlatformsSection({super.key, required this.platforms});

  @override
  Widget build(BuildContext context) {
    if (platforms.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    final platformMeta = <String, (String, dynamic)>{
      'win': ('Windows', FontAwesomeIcons.windows),
      'swi': ('Nintendo Switch', FontAwesomeIcons.gamepad),
      'ps4': ('PlayStation 4', FontAwesomeIcons.playstation),
      'ps5': ('PlayStation 5', FontAwesomeIcons.playstation),
      'ps3': ('PlayStation 3', FontAwesomeIcons.playstation),
      'psv': ('PlayStation Vita', FontAwesomeIcons.playstation),
      'psp': ('PlayStation Portable', FontAwesomeIcons.playstation),
      'and': ('Android', FontAwesomeIcons.android),
      'ios': ('iOS', FontAwesomeIcons.apple),
      'mac': ('macOS', FontAwesomeIcons.apple),
      'lin': ('Linux', FontAwesomeIcons.linux),
      'web': ('Web Browser', FontAwesomeIcons.globe),
    };

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
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: platforms.map((platformCode) {
            final meta =
                platformMeta[platformCode.toLowerCase()] ??
                (platformCode.toUpperCase(), FontAwesomeIcons.gamepad);

            return AppChip(
              label: meta.$1,
              leading: FaIcon(
                meta.$2,
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
