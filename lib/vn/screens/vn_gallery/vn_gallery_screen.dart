import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';
import '../../models/vn_screenshot.dart';
import '../../widgets/cached_app_image.dart';
import '../../widgets/reveal_image_button.dart';
import '../../../settings/providers/settings_provider.dart';
import '../../../theme/app_theme.dart';

class VnGalleryScreen extends ConsumerStatefulWidget {
  final List<VnScreenshot> screenshots;
  final int initialIndex;

  const VnGalleryScreen({
    super.key,
    required this.screenshots,
    required this.initialIndex,
  });

  @override
  ConsumerState<VnGalleryScreen> createState() => _VnGalleryScreenState();
}

class _VnGalleryScreenState extends ConsumerState<VnGalleryScreen> {
  late PageController _pageController;
  late int _currentIndex;
  final Set<int> _revealedIndices = {};

  double _dragOffset = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.primaryDelta ?? 0.0;
      _isDragging = true;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    const threshold = 120.0;

    if (_dragOffset.abs() > threshold) {
      context.pop();
    } else {
      setState(() {
        _dragOffset = 0.0;
        _isDragging = false;
      });
    }
  }

  Size _screenshotSize(VnScreenshot screenshot) {
    if (screenshot.dims.length >= 2 &&
        screenshot.dims[0] > 0 &&
        screenshot.dims[1] > 0) {
      return Size(
        screenshot.dims[0].toDouble(),
        screenshot.dims[1].toDouble(),
      );
    }

    return const Size(16, 9);
  }

  bool _isSensitiveScreenshot({
    required VnScreenshot screenshot,
    required bool showExplicitContent,
    required bool showViolentContent,
    required bool isRevealed,
  }) {
    return (!showExplicitContent &&
            screenshot.sexual != null &&
            screenshot.sexual! > 0.2 &&
            !isRevealed) ||
        (!showViolentContent &&
            screenshot.violence != null &&
            screenshot.violence! > 0.2 &&
            !isRevealed);
  }

  @override
  Widget build(BuildContext context) {
    final contentSettings = ref.watch(
      settingsProvider.select(
        (settings) => (
          showExplicitContent: settings.showExplicitContent,
          showViolentContent: settings.showViolentContent,
        ),
      ),
    );
    final dragRatio = (_dragOffset.abs() / 300.0).clamp(0.0, 1.0);
    final bgOpacity = (1.0 - dragRatio).clamp(0.0, 1.0);

    return Theme(
      data: Theme.of(context).copyWith(brightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 0, bgOpacity),
        body: Stack(
          children: [
            GestureDetector(
              onVerticalDragUpdate: _onVerticalDragUpdate,
              onVerticalDragEnd: _onVerticalDragEnd,
              child: AnimatedContainer(
                duration: _isDragging
                    ? Duration.zero
                    : const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                transformAlignment: Alignment.center,
                transform: Matrix4.translationValues(
                  0.0,
                  _dragOffset,
                  0.0,
                ),
                child: PhotoViewGallery.builder(
                  pageController: _pageController,
                  itemCount: widget.screenshots.length,
                  scrollPhysics: const BouncingScrollPhysics(),
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  wantKeepAlive: true,
                  allowImplicitScrolling: true,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  builder: (context, index) {
                    final screenshot = widget.screenshots[index];
                    final isRevealed = _revealedIndices.contains(index);
                    final shouldBlur = _isSensitiveScreenshot(
                      screenshot: screenshot,
                      showExplicitContent: contentSettings.showExplicitContent,
                      showViolentContent: contentSettings.showViolentContent,
                      isRevealed: isRevealed,
                    );

                    return PhotoViewGalleryPageOptions.customChild(
                      childSize: _screenshotSize(screenshot),
                      minScale: PhotoViewComputedScale.contained,
                      initialScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 4.0,
                      disableGestures: shouldBlur,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned.fill(
                            child: CachedAppImage(
                              imageUrl: screenshot.url,
                              fit: BoxFit.cover,
                              shouldBlur: shouldBlur,
                              blurSigma: 20.0,
                              placeholderIconSize: 64.0,
                              placeholderBackgroundColor: Colors.transparent,
                              errorBackgroundColor: Colors.transparent,
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
                                      size: 48,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Sensitive Content Hidden',
                                      style: TextStyle(
                                        color: context.appTextPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    RevealImageButton(
                                      onPressed: () {
                                        setState(() {
                                          _revealedIndices.add(index);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                top: false,
                bottom: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: context.appBackground.withValues(
                          alpha: 0.65,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: context.appTextPrimary,
                          ),
                          onPressed: () => context.pop(),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: context.appBackground.withValues(
                            alpha: 0.65,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '${_currentIndex + 1} / ${widget.screenshots.length}',
                          style: TextStyle(
                            color: context.appTextPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: context.appBackground.withValues(
                          alpha: 0.65,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.share_outlined,
                            color: context.appTextPrimary,
                          ),
                          onPressed: () {
                            SharePlus.instance.share(
                              ShareParams(
                                text: widget.screenshots[_currentIndex].url,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
