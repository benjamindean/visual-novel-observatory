import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../theme/app_theme.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _tokenController = TextEditingController();
  bool _obscureToken = true;

  @override
  void dispose() {
    _tokenController.dispose();
    super.dispose();
  }

  Future<void> _launchTokenUrl() async {
    final url = Uri.parse('https://vndb.org/u/tokens');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _handleLogin() async {
    final token = _tokenController.text.trim();

    if (token.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a token')));

      return;
    }

    final success = await ref.read(authProvider.notifier).login(token);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully logged in!'),
          backgroundColor: AppTheme.accentTeal,
        ),
      );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect VNDB'),
        backgroundColor: AppTheme.background,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              _buildHeaderIcon(),
              const SizedBox(height: 24),
              Text(
                'Observatory syncs with your VNDB account via a secure API token.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              _buildInstructionsCard(theme),
              const SizedBox(height: 32),
              _buildTokenInputField(theme),
              const SizedBox(height: 24),
              if (authState.errorMessage != null) ...[
                _buildErrorBanner(theme, authState.errorMessage!),
                const SizedBox(height: 24),
              ],
              _buildSubmitButton(authState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderIcon() {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: AppTheme.accentTeal.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.vpn_key_rounded,
          size: 40,
          color: AppTheme.accentTeal,
        ),
      ),
    );
  }

  Widget _buildInstructionsCard(ThemeData theme) {
    return Card(
      color: AppTheme.surface,
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
            _buildStepRow('1', 'Go to the VNDB token creation page.'),
            const SizedBox(height: 12),
            _buildStepRow(
              '2',
              'Create a token named "Observatory" with at least listread (listwrite is required to modify list entries).',
            ),
            const SizedBox(height: 12),
            _buildStepRow(
              '3',
              'Copy the generated token string and paste it below.',
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton.icon(
                onPressed: _launchTokenUrl,
                icon: const Icon(
                  Icons.open_in_new_rounded,
                  size: 18,
                  color: AppTheme.accentTeal,
                ),
                label: const Text(
                  'Open VNDB Token Page',
                  style: TextStyle(
                    color: AppTheme.accentTeal,
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

  Widget _buildStepRow(String stepNumber, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppTheme.searchField,
            shape: BoxShape.circle,
          ),
          child: Text(
            stepNumber,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppTheme.accentTeal,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTokenInputField(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'VNDB API Token',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _tokenController,
          obscureText: _obscureToken,
          autocorrect: false,
          enableSuggestions: false,
          style: const TextStyle(color: Colors.white, fontFamily: 'monospace'),
          decoration: InputDecoration(
            hintText: 'xxxx-xxxxx-xxxxx-xxxx...',
            suffixIcon: IconButton(
              icon: Icon(
                _obscureToken
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
              ),
              onPressed: () {
                setState(() {
                  _obscureToken = !_obscureToken;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorBanner(ThemeData theme, String message) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.redAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: Colors.redAccent,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(AuthState authState) {
    return SizedBox(
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.accentTeal,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(27),
          ),
          elevation: 2,
        ),
        onPressed: authState.isValidating ? null : _handleLogin,
        child: authState.isValidating
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.black,
                ),
              )
            : const Text(
                'Verify & Connect',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
