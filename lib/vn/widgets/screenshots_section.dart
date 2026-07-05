import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/vn_screenshot.dart';
import '../utils/vndb_content_sensitivity.dart';
import 'cached_app_image.dart';
import '../../theme/app_theme.dart';
import '../../settings/providers/settings_provider.dart';

class ScreenshotsSection extends ConsumerWidget {
  final List<VnScreenshot> screenshots;

  const ScreenshotsSection({super.key, required this.screenshots});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final contentSettings = ref.watch(
      settingsProvider.select(
        (settings) => (
          blurSexualContent: settings.blurSexualContent,
          blurViolentContent: settings.blurViolentContent,
        ),
      ),
    );

    if (screenshots.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Screenshots',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            physics: const BouncingScrollPhysics(),
            itemCount: screenshots.length,
            itemBuilder: (context, index) {
              final screen = screenshots[index];

              final shouldBlur = shouldBlurVndbContent(
                sexual: screen.sexual,
                violence: screen.violence,
                blurSexualContent: contentSettings.blurSexualContent,
                blurViolentContent: contentSettings.blurViolentContent,
              );

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
                        CachedAppImage(
                          imageUrl: screen.url,
                          fit: BoxFit.cover,
                          width: 240,
                          height: 150,
                          shouldBlur: shouldBlur,
                          blurSigma: 40.0,
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
                                color: context.appTextPrimary.withValues(
                                  alpha: 0.7,
                                ),
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
