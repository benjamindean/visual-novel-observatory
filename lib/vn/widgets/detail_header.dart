import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/visual_novel.dart';
import '../utils/vndb_content_sensitivity.dart';
import 'cached_app_image.dart';
import 'image_placeholder.dart';
import 'reveal_image_button.dart';
import 'vn_titles_sheet.dart';
import '../../theme/app_theme.dart';
import '../../settings/providers/settings_provider.dart';

class DetailHeader extends ConsumerStatefulWidget {
  final VisualNovel vn;

  const DetailHeader({super.key, required this.vn});

  @override
  ConsumerState<DetailHeader> createState() {
    return DetailHeaderState();
  }
}

class DetailHeaderState extends ConsumerState<DetailHeader> {
  bool _isImageRevealed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final contentSettings = ref.watch(
      settingsProvider.select(
        (settings) => (
          showExplicitContent: settings.showExplicitContent,
          showViolentContent: settings.showViolentContent,
        ),
      ),
    );
    final vn = widget.vn;
    final hasMultipleTitles = vn.titles.length > 1;

    final shouldBlur = shouldBlurVndbContent(
      sexual: vn.imageSexual,
      violence: vn.imageViolence,
      showExplicitContent: contentSettings.showExplicitContent,
      showViolentContent: contentSettings.showViolentContent,
      isRevealed: _isImageRevealed,
    );

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.6,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Full width cover poster with gradient overlay
          if (vn.imageUrl != null)
            ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                  stops: [0.5, 0.98],
                ).createShader(
                  Rect.fromLTRB(0, 0, rect.width, rect.height),
                );
              },
              blendMode: BlendMode.dstIn,
              child: ClipRect(
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CachedAppImage(
                        imageUrl: vn.imageUrl!,
                        width: size.width,
                        height: size.height * 0.6,
                        fit: BoxFit.cover,
                        shouldBlur: shouldBlur,
                        blurSigma: 40.0,
                        placeholderIconSize: 64.0,
                      ),
                    ),
                    if (shouldBlur)
                      Positioned.fill(
                        child: Container(
                          color: context.appBackground.withValues(
                            alpha: 0.65,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.visibility_off_rounded,
                                color: context.appTextPrimary.withValues(
                                  alpha: 0.7,
                                ),
                                size: 40,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Sensitive Image Hidden',
                                style: TextStyle(
                                  color: context.appTextPrimary.withValues(
                                    alpha: 0.7,
                                  ),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              RevealImageButton(
                                onPressed: () {
                                  setState(() {
                                    _isImageRevealed = true;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )
          else
            const ImagePlaceholder(
              iconSize: 64,
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
            bottom: 8,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: hasMultipleTitles
                      ? () => _showTitlesSheet(context, vn.titles)
                      : null,
                  behavior: HitTestBehavior.opaque,
                  child: Text(
                    vn.title,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),

                // Alternative original title
                if (vn.altTitle != null && vn.altTitle != vn.title)
                  Text(
                    vn.altTitle!,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: context.appTextSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                if (vn.aliases.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    vn.aliases.join(", "),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: context.appTextSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showTitlesSheet(BuildContext context, List<VnTitle> titles) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: false,
      backgroundColor: context.appBackground,
      builder: (context) {
        return VnTitlesSheet(titles: titles);
      },
    );
  }
}
