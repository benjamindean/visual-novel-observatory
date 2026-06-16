import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';

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
                  return ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: 12,
                      sigmaY: 12,
                      tileMode: TileMode.clamp,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        image: imageDecoration,
                      ),
                    ),
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
                size: size * 0.4,
                color: context.appTextMuted,
              ),
              errorWidget: (context, url, error) => Icon(
                Icons.person_rounded,
                size: size * 0.4,
                color: context.appTextMuted,
              ),
            )
          : Icon(
              Icons.person_rounded,
              size: size * 0.4,
              color: context.appTextMuted,
            ),
    );
  }
}
