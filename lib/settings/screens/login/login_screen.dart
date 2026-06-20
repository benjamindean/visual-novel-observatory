import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../theme/app_theme.dart';
import '../../../vn/widgets/vndb_source_note.dart';
import 'login_header_icon.dart';
import 'login_instructions_card.dart';
import 'login_token_input.dart';
import 'login_error_banner.dart';
import 'login_submit_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _tokenController = TextEditingController();

  @override
  void dispose() {
    _tokenController.dispose();
    super.dispose();
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
        SnackBar(
          content: const Text('Successfully logged in!'),
          backgroundColor: context.appAccentTeal,
          duration: const Duration(seconds: 2),
        ),
      );

      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect VNDB'),
        backgroundColor: context.appBackground,
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
              const LoginHeaderIcon(),
              const SizedBox(height: 24),
              Text(
                'Observatory syncs with your VNDB account via a secure API token.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: context.appTextSecondary,
                ),
              ),
              const SizedBox(height: 32),
              const LoginInstructionsCard(),
              const SizedBox(height: 32),
              LoginTokenInput(controller: _tokenController),
              const SizedBox(height: 24),
              if (authState.errorMessage != null) ...[
                LoginErrorBanner(message: authState.errorMessage!),
                const SizedBox(height: 24),
              ],
              LoginSubmitButton(
                isValidating: authState.isValidating,
                onPressed: _handleLogin,
              ),
              const SizedBox(height: 24.0),
              const VndbSourceNote(),
            ],
          ),
        ),
      ),
    );
  }
}
