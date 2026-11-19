import 'package:material_ui/material_ui.dart';

import '../../../models/visual_novel.dart';
import 'vn_detail_palette_theme.dart';
import 'vn_detail_scaffold.dart';

class VnDetailContent extends StatelessWidget {
  final VisualNovel vn;

  const VnDetailContent({super.key, required this.vn});

  @override
  Widget build(BuildContext context) {
    return VnDetailPaletteTheme(
      vn: vn,
      child: VnDetailScaffold(vn: vn),
    );
  }
}
