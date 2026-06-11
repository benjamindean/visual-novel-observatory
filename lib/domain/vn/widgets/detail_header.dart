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

    final developerName = vn.developers.isNotEmpty
        ? vn.developers.first.name
        : 'Unknown Developer';
    final shouldBlur =
        !settings.showExplicitContent &&
        vn.imageSexual != null &&
        vn.imageSexual! > 0.2;

    return Stack(
      children: [
        // Full width cover poster with gradient overlay
        SizedBox(
          width: double.infinity,
          height: size.height * 0.45,
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
                            color: AppTheme.surface,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: AppTheme.accentTeal,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: AppTheme.surface,
                            child: const Center(
                              child: Icon(
                                Icons.broken_image,
                                size: 64,
                                color: AppTheme.textMuted,
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
                  color: AppTheme.surface,
                  child: const Center(
                    child: Icon(
                      Icons.image,
                      size: 64,
                      color: AppTheme.textMuted,
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
              // Developer Tag
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.accentTeal.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.accentTeal.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  developerName,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppTheme.accentTeal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),

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
                    color: AppTheme.textMuted,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              if (vn.aliases.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  'Aliases: ${vn.aliases.join(", ")}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
              const SizedBox(height: 12),

              // Rating Badge
              if (vn.rating != null)
                Row(
                  children: [
                    RatingBadge(rating: vn.rating!, iconSize: 20, fontSize: 16),
                    const SizedBox(width: 8),
                    Text(
                      'from ${vn.lengthMinutes ?? 0} length votes',
                      style: theme.textTheme.labelSmall,
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
