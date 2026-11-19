import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import '../../../../theme/app_theme.dart';

class HomeFilterNameField extends StatelessWidget {
  const HomeFilterNameField({
    super.key,
    required this.controller,
  });

  static const int maxLength = 30;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'Filter Name',
        prefixIcon: Icon(
          Icons.bookmark_add_outlined,
          color: context.appAccentTeal,
        ),
        counterStyle: TextStyle(
          color: context.appTextSecondary,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        filled: true,
        fillColor: context.colorScheme.surfaceContainerHigh,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: context.appTextPrimary.withValues(alpha: 0.08),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: context.appAccentTeal,
          ),
        ),
      ),
    );
  }
}
