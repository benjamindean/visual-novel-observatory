import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../settings/providers/settings_provider.dart';
import '../../../models/visual_novel.dart';
import '../../../utils/vndb_content_sensitivity.dart';
import '../providers/vn_cover_palette_provider.dart';

class VnDetailPaletteTheme extends ConsumerWidget {
  const VnDetailPaletteTheme({
    super.key,
    required this.vn,
    required this.child,
  });

  final VisualNovel vn;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(
      settingsProvider.select(
        (settings) => (
          useCoverColorScheme: settings.useCoverColorScheme,
          blurSexualContent: settings.blurSexualContent,
          blurViolentContent: settings.blurViolentContent,
        ),
      ),
    );
    final imageUrl = vn.imageUrl;
    final isCoverSensitive = isSensitiveVndbContent(
      sexual: vn.imageSexual,
      violence: vn.imageViolence,
      blurSexualContent: settings.blurSexualContent,
      blurViolentContent: settings.blurViolentContent,
    );

    if (!settings.useCoverColorScheme ||
        imageUrl == null ||
        imageUrl.isEmpty ||
        isCoverSensitive) {
      return child;
    }

    final palette = ref
        .watch(vnCoverPaletteProvider(imageUrl))
        .maybeWhen(
          data: (palette) => palette,
          orElse: () => null,
        );

    if (palette == null) {
      return child;
    }

    return AnimatedTheme(
      data: palette.applyTo(Theme.of(context)),
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
      child: child,
    );
  }
}
