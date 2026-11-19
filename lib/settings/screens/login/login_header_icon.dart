import 'package:material_ui/material_ui.dart';

import '../../../theme/app_theme.dart';

class LoginHeaderIcon extends StatelessWidget {
  const LoginHeaderIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: context.colorScheme.primaryContainer,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.vpn_key_rounded,
          size: 40,
          color: context.appAccentTeal,
        ),
      ),
    );
  }
}
