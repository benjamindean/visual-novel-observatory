import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/settings_provider.dart';
import '../../../theme/app_theme.dart';

class CoverColorSchemeTile extends ConsumerWidget {
  const CoverColorSchemeTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useCoverColorScheme = ref.watch(
      settingsProvider.select((settings) => settings.useCoverColorScheme),
    );

    return SwitchListTile(
      value: useCoverColorScheme,
      title: Text(
        'Cover Color Scheme',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: context.appTextPrimary,
        ),
      ),
      subtitle: Text(
        'Tint visual novel detail pages from the visible cover image',
        style: TextStyle(fontSize: 12, color: context.appTextMuted),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
      onChanged: (val) {
        ref.read(settingsProvider.notifier).setUseCoverColorScheme(val);
      },
    );
  }
}
