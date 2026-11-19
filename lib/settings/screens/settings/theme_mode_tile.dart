import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/settings_provider.dart';
import '../../../theme/app_theme.dart';

class ThemeModeTile extends ConsumerWidget {
  const ThemeModeTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(
      settingsProvider.select((settings) => settings.themeMode),
    );
    final modeLabels = {
      'system': 'Follow System',
      'light': 'Light',
      'dark': 'Dark',
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme Mode',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: context.appTextPrimary,
                  ),
                ),
                Text(
                  'Light, Dark, or System mode',
                  style: TextStyle(fontSize: 12, color: context.appTextMuted),
                ),
              ],
            ),
          ),
          DropdownButton<String>(
            value: themeMode,
            dropdownColor: context.appSurface,
            underline: const SizedBox(),
            alignment: Alignment.centerRight,
            items: modeLabels.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    entry.value,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.end,
                  ),
                ),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                ref.read(settingsProvider.notifier).setThemeMode(val);
              }
            },
          ),
        ],
      ),
    );
  }
}
