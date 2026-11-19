import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_confirmation_dialog.dart';
import '../../../theme/app_theme.dart';
import '../../providers/settings_provider.dart';

class DisableExplicitContentTile extends ConsumerWidget {
  const DisableExplicitContentTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final disableExplicitContent = ref.watch(
      settingsProvider.select((settings) => settings.disableExplicitContent),
    );

    return SwitchListTile(
      value: disableExplicitContent,
      title: const Text(
        'Disable Explicit Content',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        'Filter sexual and violent visual novels before loading them from VNDB.',
        style: TextStyle(fontSize: 12, color: context.appTextMuted),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
      onChanged: (value) => _setDisableExplicitContent(
        context,
        ref,
        value,
      ),
    );
  }

  Future<void> _setDisableExplicitContent(
    BuildContext context,
    WidgetRef ref,
    bool value,
  ) async {
    if (!value) {
      final isConfirmed = await showAppConfirmationDialog(
        context: context,
        title: 'Show mature content?',
        message: 'This allows VNDB results that may contain sexual or violent content to appear. Confirm that you are old enough under the laws in your region to view adult content.',
        confirmLabel: 'I Confirm',
      );

      if (!isConfirmed || !context.mounted) {
        return;
      }
    }

    await ref.read(settingsProvider.notifier).setDisableExplicitContent(value);
  }
}
