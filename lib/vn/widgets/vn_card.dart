import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/visual_novel.dart';
import '../utils/vndb_content_sensitivity.dart';
import 'cached_app_image.dart';
import 'rating_badge.dart';
import 'image_placeholder.dart';
import '../../theme/app_theme.dart';
import '../../settings/providers/settings_provider.dart';

class VnCard extends ConsumerWidget {
  final VisualNovel vn;
  final VoidCallback onTap;

  const VnCard({super.key, required this.vn, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentSettings = ref.watch(
      settingsProvider.select(
        (settings) => (
          blurSexualContent: settings.blurSexualContent,
          blurViolentContent: settings.blurViolentContent,
        ),
      ),
    );

    final shouldBlur = shouldBlurVndbContent(
      sexual: vn.imageSexual,
      violence: vn.imageViolence,
      blurSexualContent: contentSettings.blurSexualContent,
      blurViolentContent: contentSettings.blurViolentContent,
    );

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: Stack(
            children: [
              Positioned.fill(
                child: vn.imageUrl != null
                    ? CachedPosterImage(
                        imageUrl: vn.imageUrl!,
                        shouldBlur: shouldBlur,
                      )
                    : ImagePlaceholder(
                        backgroundColor: context.appSearchField,
                      ),
              ),
              // Explicit content blur
              if (shouldBlur)
                Positioned.fill(
                  child: Container(
                    color: context.appBackground.withValues(alpha: 0.65),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.visibility_off_rounded,
                      color: context.appTextPrimary.withValues(
                        alpha: 0.7,
                      ),
                      size: 28,
                    ),
                  ),
                ),
              // Bottom gradient overlay for text legibility
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black12,
                        Colors.black54,
                        Colors.black87,
                      ],
                      stops: [0.0, 0.45, 0.75, 1.0],
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
                              color: Colors.white60,
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
