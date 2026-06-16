import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../theme/app_theme.dart';

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
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                fadeInDuration: const Duration(milliseconds: 200),
                fadeOutDuration: const Duration(milliseconds: 200),
                imageBuilder: (context, imageProvider) {
                  final imageDecoration = DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  );

                  if (shouldBlur) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        ImageFiltered(
                          imageFilter: ImageFilter.blur(
                            sigmaX: 16,
                            sigmaY: 16,
                            tileMode: TileMode.clamp,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              image: imageDecoration,
                            ),
                          ),
                        ),
                        Container(
                          color: context.appBackground.withValues(
                            alpha: 0.65,
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.visibility_off_rounded,
                            color: context.appTextPrimary.withValues(
                              alpha: 0.7,
                            ),
                            size: 24,
                          ),
                        ),
                      ],
                    );
                  }

                  return Container(
                    decoration: BoxDecoration(
                      image: imageDecoration,
                    ),
                  );
                },
                placeholder: (context, url) => Icon(
                  Icons.person_rounded,
                  size: 40,
                  color: context.appTextMuted,
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.person_rounded,
                  size: 40,
                  color: context.appTextMuted,
                ),
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
