import 'package:material_ui/material_ui.dart';

import '../../../../theme/app_theme.dart';
import 'library_status_scroll_view.dart';

class LibraryEmptyLabelsView extends StatelessWidget {
  const LibraryEmptyLabelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return LibraryStatusScrollView(
      physics: const NeverScrollableScrollPhysics(),
      message: 'No labels found.',
      messageColor: context.appTextMuted,
    );
  }
}
