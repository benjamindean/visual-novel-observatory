import 'package:material_ui/material_ui.dart';

import '../../../theme/app_theme.dart';
import '../../../vn/widgets/connect_vndb_button.dart';

class VndbConnectCard extends StatelessWidget {
  const VndbConnectCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: context.appSurface,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.account_circle_outlined,
              size: 48,
              color: context.appTextMuted,
            ),
            const SizedBox(height: 12),
            Text(
              'Account Disconnected',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sync your list readings, statuses, and manage your VN library directly from Observatory.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: context.appTextMuted,
              ),
            ),
            const SizedBox(height: 20),
            const ConnectVndbButton(),
          ],
        ),
      ),
    );
  }
}
