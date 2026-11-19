import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/settings_provider.dart';
import '../../../theme/app_theme.dart';

class TrueBlackTile extends ConsumerWidget {
  const TrueBlackTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkIsTrueBlack = ref.watch(
      settingsProvider.select((settings) => settings.darkIsTrueBlack),
    );

    return SwitchListTile(
      value: darkIsTrueBlack,
      title: Text(
        'True Black Background',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: context.appTextPrimary,
        ),
      ),
      subtitle: Text(
        'Pure black background for OLED screens',
        style: TextStyle(fontSize: 12, color: context.appTextMuted),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
      onChanged: (val) {
        ref.read(settingsProvider.notifier).setDarkIsTrueBlack(val);
      },
    );
  }
}
