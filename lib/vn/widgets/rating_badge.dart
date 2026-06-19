import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class RatingBadge extends StatelessWidget {
  final double rating;
  final double? averageRating;
  final double iconSize;
  final double fontSize;

  const RatingBadge({
    super.key,
    required this.rating,
    this.averageRating,
    this.iconSize = 16.0,
    this.fontSize = 13.0,
  });

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, color: context.appAccentAmber, size: iconSize),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: context.theme.textTheme.labelLarge?.copyWith(
            color: context.appAccentAmber,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

    if (averageRating == null) {
      return content;
    }

    return Tooltip(
      message:
          'Weighted rating: ${rating.toStringAsFixed(1)}\nAverage rating: ${averageRating!.toStringAsFixed(1)}',
      triggerMode: TooltipTriggerMode.tap,
      child: content,
    );
  }
}
