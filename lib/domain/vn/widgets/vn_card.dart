import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/visual_novel.dart';
import 'rating_badge.dart';
import '../../../theme/app_theme.dart';
import '../../settings/providers/settings_provider.dart';

class VnCard extends ConsumerWidget {
  final VisualNovel vn;
  final VoidCallback onTap;

  const VnCard({super.key, required this.vn, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    final shouldBlur =
        !settings.showExplicitContent &&
        vn.imageSexual != null &&
        vn.imageSexual! > 0.2;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: Stack(
            children: [
              // Cover art thumbnail
              Positioned.fill(
                child: vn.imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: vn.imageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: context.appSearchField,
                          child: Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: context.appAccentTeal,
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: context.appSearchField,
                          child: Icon(
                            Icons.broken_image_rounded,
                            color: context.appTextMuted,
                            size: 32,
                          ),
                        ),
                      )
                    : Container(
                        color: context.appSearchField,
                        child: Icon(
                          Icons.image_rounded,
                          color: context.appTextMuted,
                          size: 32,
                        ),
                      ),
              ),
              // Explicit content blur
              if (shouldBlur)
                Positioned.fill(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.55),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.visibility_off_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              // Bottom gradient overlay for text legibility
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.1),
                        Colors.black.withValues(alpha: 0.65),
                        Colors.black.withValues(alpha: 0.85),
                      ],
                      stops: const [0.0, 0.45, 0.75, 1.0],
                    ),
                  ),
                ),
              ),
              // Title and Rating details
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      vn.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (vn.rating != null)
                          RatingBadge(
                            rating: vn.rating!,
                            iconSize: 14.0,
                            fontSize: 12.0,
                          )
                        else
                          Text(
                            'No Rating',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
