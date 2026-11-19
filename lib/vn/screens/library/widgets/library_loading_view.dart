import 'package:material_ui/material_ui.dart';

import '../../../../theme/app_theme.dart';
import 'library_status_scroll_view.dart';

class LibraryLoadingView extends StatelessWidget {
  const LibraryLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: LibraryStatusScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: CircularProgressIndicator(
            color: context.appAccentTeal,
          ),
        ),
      ),
    );
  }
}
