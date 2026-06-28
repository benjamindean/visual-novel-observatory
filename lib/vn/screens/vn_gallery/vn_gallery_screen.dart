import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'widgets/vn_gallery_image_page.dart';
import '../../models/vn_screenshot.dart';
import '../../utils/vndb_content_sensitivity.dart';
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
  static const double _dismissDistanceThreshold = 120.0;
  static const double _dismissVelocityThreshold = 700.0;
  static const Duration _snapBackDuration = Duration(milliseconds: 350);
  static const Duration _dismissDuration = Duration(milliseconds: 350);

  late PageController _pageController;
  late int _currentIndex;
  final Set<int> _revealedIndices = {};

  double _dragOffset = 0.0;
  bool _isDragging = false;
  bool _isDismissing = false;

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
    if (_isDismissing) {
      return;
    }

    setState(() {
      _dragOffset += details.primaryDelta ?? 0.0;
      _isDragging = true;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_isDismissing) {
      return;
    }

    final velocity = details.primaryVelocity ?? 0.0;
    final hasDismissDistance = _dragOffset.abs() > _dismissDistanceThreshold;
    final hasDismissVelocity = velocity.abs() > _dismissVelocityThreshold;

    if (hasDismissDistance || hasDismissVelocity) {
      final direction = hasDismissVelocity ? velocity.sign : _dragOffset.sign;
      final screenHeight = MediaQuery.sizeOf(context).height;

      setState(() {
        _dragOffset = direction * (screenHeight + 120.0);
        _isDragging = false;
        _isDismissing = true;
      });
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

  @override
  Widget build(BuildContext context) {
    final contentSettings = ref.watch(
      settingsProvider.select(
        (settings) => (
          disableExplicitContent: settings.disableExplicitContent,
          showExplicitContent: settings.showExplicitContent,
          showViolentContent: settings.showViolentContent,
        ),
      ),
    );
    final dragRatio = (_dragOffset.abs() / 300.0).clamp(0.0, 1.0);
    final bgOpacity = (1.0 - dragRatio).clamp(0.0, 1.0);
    final controlsOpacity = (1.0 - dragRatio * 1.8).clamp(0.0, 1.0);
    final chromeAnimationDuration = _isDragging
        ? Duration.zero
        : _isDismissing
        ? _dismissDuration
        : _snapBackDuration;

    return Theme(
      data: AppTheme.darkTheme,
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Color.fromRGBO(0, 0, 0, bgOpacity),
            body: Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onVerticalDragUpdate: _onVerticalDragUpdate,
                    onVerticalDragEnd: _onVerticalDragEnd,
                    child: AnimatedContainer(
                      duration: _isDragging
                          ? Duration.zero
                          : _isDismissing
                          ? _dismissDuration
                          : _snapBackDuration,
                      curve: _isDismissing
                          ? Curves.decelerate
                          : Curves.easeOutCubic,
                      onEnd: () {
                        if (!_isDismissing || !mounted) {
                          return;
                        }

                        context.pop();
                      },
                      transformAlignment: Alignment.center,
                      transform: Matrix4.translationValues(
                        0.0,
                        _dragOffset,
                        0.0,
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final pageSize = Size(
                            constraints.maxWidth,
                            constraints.maxHeight,
                          );

                          return PhotoViewGallery.builder(
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
                              final isRevealed = _revealedIndices.contains(
                                index,
                              );
                              final hiddenReasons =
                                  vndbContentSensitivityReasons(
                                    sexual: screenshot.sexual,
                                    violence: screenshot.violence,
                                    showExplicitContent:
                                        contentSettings.showExplicitContent,
                                    showViolentContent:
                                        contentSettings.showViolentContent,
                                  );
                              final canRevealHiddenImage =
                                  !contentSettings.disableExplicitContent;
                              final shouldBlur =
                                  hiddenReasons.isNotEmpty &&
                                  (!canRevealHiddenImage || !isRevealed);
                              final childSize = shouldBlur
                                  ? pageSize
                                  : _screenshotSize(screenshot);

                              return PhotoViewGalleryPageOptions.customChild(
                                childSize: childSize,
                                minScale: PhotoViewComputedScale.contained,
                                initialScale: PhotoViewComputedScale.contained,
                                maxScale: PhotoViewComputedScale.covered * 4.0,
                                disableGestures: shouldBlur,
                                child: VnGalleryImagePage(
                                  screenshot: screenshot,
                                  shouldBlur: shouldBlur,
                                  reasons: hiddenReasons,
                                  onReveal: () {
                                    setState(() {
                                      _revealedIndices.add(index);
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                    ignoring: _isDismissing,
                    child: AnimatedOpacity(
                      opacity: controlsOpacity,
                      duration: chromeAnimationDuration,
                      curve: _isDismissing
                          ? Curves.easeOutCubic
                          : Curves.easeOut,
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
                                backgroundColor: context.appBackground
                                    .withValues(
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
                                  '${_currentIndex + 1} / '
                                  '${widget.screenshots.length}',
                                  style: TextStyle(
                                    color: context.appTextPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: context.appBackground
                                    .withValues(
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
                                        text: widget
                                            .screenshots[_currentIndex]
                                            .url,
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
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
