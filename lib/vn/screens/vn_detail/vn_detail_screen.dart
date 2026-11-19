import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/visual_novel.dart';
import '../../providers/vn_providers.dart';
import '../../../theme/app_theme.dart';
import 'widgets/vn_detail_content.dart';

class VnDetailScreen extends ConsumerWidget {
  final VisualNovel vn;

  const VnDetailScreen({super.key, required this.vn});

  bool _isVnIncomplete(VisualNovel vn) {
    return vn.description == null &&
        vn.tags.isEmpty &&
        vn.developers.isEmpty &&
        vn.screenshots.isEmpty &&
        vn.platforms.isEmpty;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (_isVnIncomplete(vn)) {
      final detailAsync = ref.watch(vnDetailProvider(vn.id));

      return detailAsync.when(
        data: (fullVn) => VnDetailContent(vn: fullVn),
        loading: () => Scaffold(
          backgroundColor: context.appBackground,
          appBar: AppBar(
            backgroundColor: context.appBackground,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Center(
            child: CircularProgressIndicator(
              color: context.appAccentTeal,
            ),
          ),
        ),
        error: (error, stack) => Scaffold(
          backgroundColor: context.appBackground,
          appBar: AppBar(
            title: Text(vn.title),
            backgroundColor: context.appBackground,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Failed to load details: $error',
                style: TextStyle(color: context.colorScheme.error),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    }

    return VnDetailContent(vn: vn);
  }
}
