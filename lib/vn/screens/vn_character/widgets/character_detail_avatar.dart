import 'package:flutter/material.dart';
import '../../../../theme/app_theme.dart';
import '../../../widgets/cached_app_image.dart';

class CharacterDetailAvatar extends StatelessWidget {
  final String? imageUrl;
  final bool shouldBlur;

  const CharacterDetailAvatar({
    super.key,
    required this.imageUrl,
    required this.shouldBlur,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.appSurface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: context.appAccentTeal.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: ClipOval(
        child: imageUrl != null
            ? Stack(
                fit: StackFit.expand,
                children: [
                  CachedAvatarImage(
                    imageUrl: imageUrl!,
                    size: 100.0,
                    shouldBlur: shouldBlur,
                    blurSigma: 16.0,
                  ),
                  if (shouldBlur)
                    Container(
                      color: context.appBackground.withValues(alpha: 0.65),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.visibility_off_rounded,
                        color: context.appTextPrimary.withValues(alpha: 0.7),
                        size: 24,
                      ),
                    ),
                ],
              )
            : Icon(
                Icons.person_rounded,
                size: 40,
                color: context.appTextMuted,
              ),
      ),
    );
  }
}
