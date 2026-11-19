import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/settings_provider.dart';
import '../../../theme/app_theme.dart';

class BlurSexualContentTile extends ConsumerWidget {
  const BlurSexualContentTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blurSexualContent = ref.watch(
      settingsProvider.select((settings) => settings.blurSexualContent),
    );
    final disableExplicitContent = ref.watch(
      settingsProvider.select((settings) => settings.disableExplicitContent),
    );
    final textColor = disableExplicitContent
        ? context.appTextMuted
        : context.appTextPrimary;
    final subtitle = disableExplicitContent
        ? 'Unavailable while explicit content is filtered out completely.'
        : 'Blur sexual images and hide sexual tags unless you reveal them.';

    return SwitchListTile(
      value: blurSexualContent,
      title: Text(
        'Blur Sexual Content',
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
              ref.read(settingsProvider.notifier).setBlurSexualContent(val);
            },
    );
  }
}
