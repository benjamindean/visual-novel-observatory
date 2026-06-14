import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../models/vn_voice_actor.dart';
import '../../../theme/app_theme.dart';
import '../../../settings/providers/settings_provider.dart';

class CharactersSection extends ConsumerWidget {
  final List<VnVoiceActorAssociation> voiceActors;

  const CharactersSection({super.key, required this.voiceActors});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (voiceActors.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Characters',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: voiceActors.length,
            itemBuilder: (context, index) {
              final association = voiceActors[index];
              final char = association.character;
              final shouldBlur =
                  (!settings.showExplicitContent &&
                      char.imageSexual != null &&
                      char.imageSexual! > 0.2) ||
                  (!settings.showViolentContent &&
                      char.imageViolence != null &&
                      char.imageViolence! > 0.2);

              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    context.push('/character', extra: association);
                  },
                  child: SizedBox(
                    width: 72,
                    child: Column(
                      children: [
                        _CharacterAvatar(
                          imageUrl: char.imageUrl,
                          shouldBlur: shouldBlur,
                          size: 72,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          char.name,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: context.appTextPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CharacterAvatar extends StatelessWidget {
  final String? imageUrl;
  final bool shouldBlur;
  final double size;

  const _CharacterAvatar({
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
