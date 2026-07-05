import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/settings_provider.dart';
import '../../../theme/app_theme.dart';

class BlurViolentContentTile extends ConsumerWidget {
  const BlurViolentContentTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blurViolentContent = ref.watch(
      settingsProvider.select((settings) => settings.blurViolentContent),
    );
    final disableExplicitContent = ref.watch(
      settingsProvider.select((settings) => settings.disableExplicitContent),
    );
    final textColor = disableExplicitContent
        ? context.appTextMuted
        : context.appTextPrimary;
    final subtitle = disableExplicitContent
        ? 'Unavailable while violent visual novels are filtered out completely.'
        : 'Blur violent images and screenshots unless you reveal them.';

    return SwitchListTile(
      value: blurViolentContent,
      title: Text(
        'Blur Violent Content',
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
              ref.read(settingsProvider.notifier).setBlurViolentContent(val);
            },
    );
  }
}
