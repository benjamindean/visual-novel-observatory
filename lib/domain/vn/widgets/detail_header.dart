import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/visual_novel.dart';
import 'rating_badge.dart';
import '../../../theme/app_theme.dart';
import '../../settings/providers/settings_provider.dart';

class DetailHeader extends ConsumerWidget {
  final VisualNovel vn;

  const DetailHeader({super.key, required this.vn});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final settings = ref.watch(settingsProvider);
    final shouldBlur =
        !settings.showExplicitContent &&
        vn.imageSexual != null &&
        vn.imageSexual! > 0.2;

    return Stack(
      children: [
        // Full width cover poster with gradient overlay
        SizedBox(
          width: double.infinity,
          height: size.height * 0.6,
          child: vn.imageUrl != null
              ? ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                      stops: [0.5, 1.0],
                    ).createShader(
                      Rect.fromLTRB(0, 0, rect.width, rect.height),
                    );
                  },
                  blendMode: BlendMode.dstIn,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CachedNetworkImage(
                          imageUrl: vn.imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: context.appSurface,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: context.appAccentTeal,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: context.appSurface,
                            child: Center(
                              child: Icon(
                                Icons.broken_image,
                                size: 64,
                                color: context.appTextMuted,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (shouldBlur)
                        Positioned.fill(
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                              child: Container(
                                color: Colors.black.withValues(alpha: 0.5),
                                alignment: Alignment.center,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.visibility_off_rounded,
                                      color: Colors.white70,
                                      size: 40,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Sensitive Image Hidden',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              : Container(
                  color: context.appSurface,
                  child: Center(
                    child: Icon(
                      Icons.image,
                      size: 64,
                      color: context.appTextMuted,
                    ),
                  ),
                ),
        ),

        // Navigation Back Button overlay
        Positioned(
          top: 16,
          left: 16,
          child: SafeArea(
            child: CircleAvatar(
              backgroundColor: Colors.black45,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ),

        // Text & metadata details at the bottom of the poster
        Positioned(
          bottom: 16,
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // VN Title
              Text(
                vn.title,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),

              // Alternative original title
              if (vn.altTitle != null && vn.altTitle != vn.title)
                Text(
                  vn.altTitle!,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: context.appTextMuted,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              if (vn.aliases.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  'Aliases: ${vn.aliases.join(", ")}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: context.appTextMuted,
                  ),
                ),
              ],
              const SizedBox(height: 12),

              // Rating Badge
              if (vn.rating != null)
                Row(
                  children: [
                    RatingBadge(rating: vn.rating!, iconSize: 20, fontSize: 16),
                    Visibility(
                      visible: vn.votecount != null && vn.votecount! > 0,
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          Text(
                            'from ${vn.votecount} votes',
                            style: theme.textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
