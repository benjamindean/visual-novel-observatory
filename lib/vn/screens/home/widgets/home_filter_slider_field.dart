import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';

class HomeFilterSliderField extends StatelessWidget {
  const HomeFilterSliderField({
    super.key,
    required this.title,
    required this.valueLabel,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  final String title;
  final String valueLabel;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.theme.textTheme.bodyLarge?.copyWith(
                  color: context.appTextPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Text(
              valueLabel,
              style: TextStyle(
                color: context.appAccentTeal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          activeColor: context.appAccentTeal,
          inactiveColor: context.colorScheme.surfaceContainerHighest,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
