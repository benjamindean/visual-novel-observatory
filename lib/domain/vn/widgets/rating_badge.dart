import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class RatingBadge extends StatelessWidget {
  final double rating;
  final double iconSize;
  final double fontSize;

  const RatingBadge({
    super.key,
    required this.rating,
    this.iconSize = 16.0,
    this.fontSize = 13.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, color: context.appAccentAmber, size: iconSize),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: context.appAccentAmber,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
