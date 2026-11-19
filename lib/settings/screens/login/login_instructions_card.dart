import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../theme/app_theme.dart';
import 'widgets/login_step_row.dart';

class LoginInstructionsCard extends StatelessWidget {
  const LoginInstructionsCard({super.key});

  Future<void> _launchTokenUrl() async {
    final url = Uri.parse('https://vndb.org/u/tokens');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: context.appSurface,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How to get your token:',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const LoginStepRow(
              stepNumber: '1',
              text: 'Go to the VNDB token creation page.',
            ),
            const SizedBox(height: 12),
            const LoginStepRow(
              stepNumber: '2',
              text: 'Create a token named "Observatory" with at least listread (listwrite is required to modify list entries).',
            ),
            const SizedBox(height: 12),
            const LoginStepRow(
              stepNumber: '3',
              text: 'Copy the generated token string and paste it below.',
            ),

            const SizedBox(height: 20),
            Center(
              child: TextButton.icon(
                onPressed: _launchTokenUrl,
                icon: Icon(
                  Icons.open_in_new_rounded,
                  size: 18,
                  color: context.appAccentTeal,
                ),
                label: Text(
                  'Open VNDB Token Page',
                  style: TextStyle(
                    color: context.appAccentTeal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
