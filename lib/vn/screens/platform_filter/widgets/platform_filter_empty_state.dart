import 'package:material_ui/material_ui.dart';

import '../../../../theme/app_theme.dart';

class PlatformFilterEmptyState extends StatelessWidget {
  const PlatformFilterEmptyState({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.devices_other_rounded,
              size: 64,
              color: context.appTextMuted,
            ),
            const SizedBox(height: 16),
            Text(
              query.isEmpty
                  ? 'No platforms available'
                  : 'No platforms found matching "$query"',
              style: TextStyle(
                color: context.appTextMuted,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
