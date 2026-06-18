import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'cached_app_image.dart';

class CharacterAvatar extends StatelessWidget {
  final String? imageUrl;
  final bool shouldBlur;
  final double size;

  const CharacterAvatar({
    super.key,
    required this.imageUrl,
    required this.shouldBlur,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.appSurface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl != null
          ? CachedAvatarImage(
              imageUrl: imageUrl!,
              size: size,
              shouldBlur: shouldBlur,
            )
          : Icon(
              Icons.person_rounded,
              size: size * 0.4,
              color: context.appTextMuted,
            ),
    );
  }
}
