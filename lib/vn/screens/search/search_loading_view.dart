import 'package:material_ui/material_ui.dart';

import '../../../theme/app_theme.dart';

class SearchLoadingView extends StatelessWidget {
  const SearchLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: context.appAccentTeal,
      ),
    );
  }
}
