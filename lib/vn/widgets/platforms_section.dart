import 'package:flutter/material.dart';
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

    final platformMeta = <String, (String, IconData)>{
      'win': ('Windows', Icons.laptop_windows_rounded),
      'swi': ('Nintendo Switch', Icons.sports_esports_rounded),
      'ps4': ('PlayStation 4', Icons.gamepad_rounded),
      'ps5': ('PlayStation 5', Icons.gamepad_rounded),
      'ps3': ('PlayStation 3', Icons.gamepad_rounded),
      'psv': ('PlayStation Vita', Icons.tablet_android_rounded),
      'psp': ('PlayStation Portable', Icons.tablet_android_rounded),
      'and': ('Android', Icons.android_rounded),
      'ios': ('iOS', Icons.phone_iphone_rounded),
      'mac': ('macOS', Icons.laptop_mac_rounded),
      'lin': ('Linux', Icons.terminal_rounded),
      'web': ('Web Browser', Icons.language_rounded),
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
                (platformCode.toUpperCase(), Icons.gamepad_rounded);

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: context.appSurface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.appTextPrimary.withValues(alpha: 0.05),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(meta.$2, size: 16, color: context.appAccentTeal),
                  const SizedBox(width: 8),
                  Text(
                    meta.$1,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: context.appTextPrimary,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
