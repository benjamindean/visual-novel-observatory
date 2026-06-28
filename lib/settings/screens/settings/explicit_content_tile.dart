import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/settings_provider.dart';
import '../../../theme/app_theme.dart';

class ExplicitContentTile extends ConsumerWidget {
  const ExplicitContentTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showExplicitContent = ref.watch(
      settingsProvider.select((settings) => settings.showExplicitContent),
    );
    final disableExplicitContent = ref.watch(
      settingsProvider.select((settings) => settings.disableExplicitContent),
    );
    final textColor = disableExplicitContent
        ? context.appTextMuted
        : context.appTextPrimary;
    final subtitle = disableExplicitContent
        ? 'Unavailable while explicit content is filtered out completely.'
        : 'Include 18+ sexual content in search results and uncover blurred images.';

    return SwitchListTile(
      value: showExplicitContent,
      title: Text(
        'Explicit Content',
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12, color: context.appTextMuted),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
      onChanged: disableExplicitContent
          ? null
          : (val) {
              ref.read(settingsProvider.notifier).setShowExplicitContent(val);
            },
    );
  }
}
