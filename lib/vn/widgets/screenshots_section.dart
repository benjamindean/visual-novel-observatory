import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../models/vn_screenshot.dart';
import '../../theme/app_theme.dart';
import '../../settings/providers/settings_provider.dart';

class ScreenshotsSection extends ConsumerWidget {
  final List<VnScreenshot> screenshots;

  const ScreenshotsSection({super.key, required this.screenshots});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider);

    if (screenshots.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Screenshots',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: screenshots.length,
            itemBuilder: (context, index) {
              final screen = screenshots[index];
              final shouldBlur =
                  !settings.showExplicitContent &&
                  screen.sexual != null &&
                  screen.sexual! > 0.2;

              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GestureDetector(
                    onTap: () {
                      context.push(
                        '/gallery',
                        extra: {
                          'screenshots': screenshots,
                          'initialIndex': index,
                        },
                      );
                    },
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: screen.url,
                          fit: BoxFit.cover,
                          width: 240,
                          height: 150,
                          placeholder: (context, url) => Container(
                            color: context.appSurface,
                            width: 240,
                            height: 150,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: context.appAccentTeal,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: context.appSurface,
                            width: 240,
                            height: 150,
                            child: Icon(
                              Icons.broken_image,
                              color: context.appTextMuted,
                            ),
                          ),
                        ),
                        if (shouldBlur)
                          Positioned.fill(
                            child: ClipRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Container(
                                  color: Colors.black54,
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.visibility_off_rounded,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
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
