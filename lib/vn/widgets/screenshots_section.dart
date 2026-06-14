import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../models/vn_screenshot.dart';
import 'image_placeholder.dart';
import 'image_error_widget.dart';
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
                  (!settings.showExplicitContent &&
                      screen.sexual != null &&
                      screen.sexual! > 0.2) ||
                  (!settings.showViolentContent &&
                      screen.violence != null &&
                      screen.violence! > 0.2);

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
                          memCacheWidth: 240,
                          memCacheHeight: 150,
                          fadeInDuration: const Duration(milliseconds: 200),
                          fadeOutDuration: const Duration(milliseconds: 200),
                          imageBuilder: (context, imageProvider) {
                            final image = Image(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              width: 240,
                              height: 150,
                            );

                            return shouldBlur
                                ? ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                      sigmaX: 10,
                                      sigmaY: 10,
                                      tileMode: TileMode.clamp,
                                    ),
                                    child: image,
                                  )
                                : image;
                          },
                          placeholder: (context, url) => const ImagePlaceholder(
                            width: 240,
                            height: 150,
                          ),
                          errorWidget: (context, url, error) =>
                              const ImageErrorWidget(
                                width: 240,
                                height: 150,
                              ),
                        ),
                        if (shouldBlur)
                          Positioned.fill(
                            child: Container(
                              color: context.appBackground.withValues(
                                alpha: 0.65,
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.visibility_off_rounded,
                                color: context.appTextPrimary,
                                size: 24,
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
