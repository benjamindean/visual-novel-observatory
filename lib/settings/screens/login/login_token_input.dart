import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class LoginTokenInput extends StatefulWidget {
  final TextEditingController controller;

  const LoginTokenInput({
    super.key,
    required this.controller,
  });

  @override
  State<LoginTokenInput> createState() => _LoginTokenInputState();
}

class _LoginTokenInputState extends State<LoginTokenInput> {
  bool _obscureToken = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'VNDB API Token',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.appTextPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          obscureText: _obscureToken,
          autocorrect: false,
          enableSuggestions: false,
          style: TextStyle(
            color: context.appTextPrimary,
            fontFamily: 'monospace',
          ),
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
}
