import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/visual_novel.dart';
import 'rating_badge.dart';
import 'tag_chip.dart';
import '../../../theme/app_theme.dart';
import '../../settings/providers/settings_provider.dart';

class VnCard extends ConsumerWidget {
  final VisualNovel vn;
  final VoidCallback onTap;

  const VnCard({super.key, required this.vn, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider);

    final developerName = vn.developers.isNotEmpty
        ? vn.developers.first.name
        : 'Unknown Developer';
    final shouldBlur =
        !settings.showExplicitContent &&
        vn.imageSexual != null &&
        vn.imageSexual! > 0.2;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover art thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 90,
                  height: 120,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: vn.imageUrl != null
                            ? CachedNetworkImage(
                                imageUrl: vn.imageUrl!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: AppTheme.searchField,
                                  child: const Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppTheme.accentTeal,
                                      ),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: AppTheme.searchField,
                                  child: const Icon(
                                    Icons.broken_image,
                                    color: AppTheme.textMuted,
                                  ),
                                ),
                              )
                            : Container(
                                color: AppTheme.searchField,
                                child: const Icon(
                                  Icons.image,
                                  color: AppTheme.textMuted,
                                ),
                              ),
                      ),
                      if (shouldBlur)
                        Positioned.fill(
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(
                                color: Colors.black.withValues(alpha: 0.45),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.visibility_off_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // VN Details
              Expanded(
                child: SizedBox(
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        vn.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // Developer & Release Year
                      Text(
                        '$developerName • ${vn.releaseYear}',
                        style: theme.textTheme.labelSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // Rating badge
                      if (vn.rating != null)
                        RatingBadge(rating: vn.rating!)
                      else
                        Text(
                          'No Rating',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: AppTheme.textMuted,
                          ),
                        ),
                      const Spacer(),

                      // Tag chips
                      if (vn.tags.isNotEmpty)
                        Row(
                          children: vn.tags
                              .take(2)
                              .map(
                                (tag) => Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 6.0),
                                    child: TagChip(
                                      label: tag.name,
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          '/tag-list',
                                          arguments: {
                                            'tagId': tag.id,
                                            'tagName': tag.name,
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
