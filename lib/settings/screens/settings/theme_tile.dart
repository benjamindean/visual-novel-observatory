import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/settings_provider.dart';
import '../../../theme/app_theme.dart';

class ThemeTile extends ConsumerWidget {
  const ThemeTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeName = ref.watch(
      settingsProvider.select((settings) => settings.themeName),
    );
    final theme = Theme.of(context);
    final isDarkActive = theme.brightness == Brightness.dark;

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
                  'App Theme',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: context.appTextPrimary,
                  ),
                ),
                Text(
                  'Choose color scheme',
                  style: TextStyle(fontSize: 12, color: context.appTextMuted),
                ),
              ],
            ),
          ),
          DropdownButton<String>(
            value: themeName,
            dropdownColor: context.appSurface,
            underline: const SizedBox(),
            alignment: Alignment.centerRight,
            items: AppTheme.themes.entries.map((entry) {
              final colors = AppTheme.getThemeColors(entry.key, isDarkActive);

              return DropdownMenuItem<String>(
                value: entry.key,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Theme color circle previews
                    ...colors.map((color) {
                      return Container(
                        margin: const EdgeInsets.only(left: 4.0),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                    const SizedBox(width: 8),
                    Text(entry.value, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                ref.read(settingsProvider.notifier).setThemeName(val);
              }
            },
          ),
        ],
      ),
    );
  }
}
