import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/settings_provider.dart';
import '../../../theme/app_theme.dart';

class SpoilerTile extends ConsumerWidget {
  const SpoilerTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spoilerLevel = ref.watch(
      settingsProvider.select((settings) => settings.spoilerLevel),
    );
    final spoilerLabels = {
      0: 'Hide Spoilers',
      1: 'Show Minor Spoilers',
      2: 'Show All Spoilers',
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
                  'Spoiler Filter',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: context.appTextPrimary,
                  ),
                ),
                Text(
                  'Default spoiler level for tags',
                  style: TextStyle(fontSize: 12, color: context.appTextMuted),
                ),
              ],
            ),
          ),
          DropdownButton<int>(
            value: spoilerLevel,
            dropdownColor: context.appSurface,
            underline: const SizedBox(),
            alignment: Alignment.centerRight,
            items: spoilerLabels.entries.map((entry) {
              return DropdownMenuItem<int>(
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
                ref.read(settingsProvider.notifier).setSpoilerLevel(val);
              }
            },
          ),
        ],
      ),
    );
  }
}
