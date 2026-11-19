import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import 'app_icon_button.dart';

class AppSettingsButton extends StatelessWidget {
  const AppSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      icon: Icons.settings_outlined,
      tooltip: 'Settings',
      onPressed: () {
        context.push('/settings');
      },
    );
  }
}
