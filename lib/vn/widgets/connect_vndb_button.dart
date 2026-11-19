import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_theme.dart';

class ConnectVndbButton extends StatelessWidget {
  const ConnectVndbButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: context.appAccentTeal,
        foregroundColor: context.colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            24,
          ),
        ),
        elevation: 0,
      ),
      onPressed: () async {
        final didConnect = await context.push<bool>('/login');

        if (didConnect != true || !context.mounted) {
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Successfully logged in!'),
            backgroundColor: context.appAccentTeal,
            duration: const Duration(seconds: 2),
          ),
        );
      },
      icon: Icon(
        Icons.login_rounded,
        size: 20,
        color: context.colorScheme.onPrimary,
      ),
      label: const Text(
        'Connect VNDB',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
