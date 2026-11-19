import 'package:material_ui/material_ui.dart';

import '../../../theme/app_theme.dart';

class SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const SettingsCard({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.appSurface,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: Column(
        children: children,
      ),
    );
  }
}
