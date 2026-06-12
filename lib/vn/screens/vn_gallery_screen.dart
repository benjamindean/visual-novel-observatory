import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/vn_screenshot.dart';
import '../../settings/providers/settings_provider.dart';

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

class _VnGalleryScreenState extends ConsumerState<VnGalleryScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late int _currentIndex;
  final Set<int> _revealedIndices = {};
  final Map<int, TransformationController> _transformationControllers = {};

  TransformationController? _activeController;
  late AnimationController _animationController;
  Animation<Matrix4>? _zoomAnimation;
  int? _animatingIndex;
  double _dragOffset = 0.0;
  bool _isDragging = false;
  bool _wasZoomed = false;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _updateActiveController();

    _animationController =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 250),
        )..addListener(() {
          if (_zoomAnimation != null && _animatingIndex != null) {
            _getController(_animatingIndex!).value = _zoomAnimation!.value;
          }
        });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();

    for (final controller in _transformationControllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  TransformationController _getController(int index) {
    return _transformationControllers.putIfAbsent(
      index,
      () => TransformationController(),
    );
  }

  void _onScaleChanged() {
    final bool currentZoomed = _isZoomed;

    if (currentZoomed != _wasZoomed) {
      setState(() {
        _wasZoomed = currentZoomed;
      });
    }
  }

  void _updateActiveController() {
    final newController = _getController(_currentIndex);

    if (_activeController != newController) {
      _activeController?.removeListener(_onScaleChanged);
      _activeController = newController;
      _activeController?.addListener(_onScaleChanged);
      _wasZoomed = newController.value.getMaxScaleOnAxis() > 1.01;
    }
  }

  bool get _isZoomed {
    if (_transformationControllers.containsKey(_currentIndex)) {
      final controller = _transformationControllers[_currentIndex]!;

      return controller.value.getMaxScaleOnAxis() > 1.01;
    }

    return false;
  }

  void _resetZoom(int index) {
    if (_transformationControllers.containsKey(index)) {
      _transformationControllers[index]!.value = Matrix4.identity();
    }
  }

  void _handleDoubleTap(int index, TapDownDetails details) {
    if (_animationController.isAnimating) {
      return;
    }

    final controller = _getController(index);
    final currentMatrix = controller.value;
    final currentScale = currentMatrix.getMaxScaleOnAxis();

    final Matrix4 targetMatrix;

    if (currentScale > 1.1) {
      targetMatrix = Matrix4.identity();
    } else {
      final double targetScale = 2.5;
      final x = details.localPosition.dx;
      final y = details.localPosition.dy;
      final double translationX = x - x * targetScale;
      final double translationY = y - y * targetScale;

      targetMatrix =
          Matrix4.translationValues(translationX, translationY, 0.0) *
          Matrix4.diagonal3Values(targetScale, targetScale, 1.0);
    }

    _animatingIndex = index;
    _zoomAnimation = Matrix4Tween(begin: currentMatrix, end: targetMatrix)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOutCubic,
          ),
        );

    _animationController.forward(from: 0.0);
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
      Navigator.of(context).pop();
    } else {
      setState(() {
        _dragOffset = 0.0;
        _isDragging = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final dragRatio = (_dragOffset.abs() / 300.0).clamp(0.0, 1.0);
    final bgOpacity = (1.0 - dragRatio).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: bgOpacity),
      body: Stack(
        children: [
          GestureDetector(
            onVerticalDragUpdate: _wasZoomed ? null : _onVerticalDragUpdate,
            onVerticalDragEnd: _wasZoomed ? null : _onVerticalDragEnd,
            child: AnimatedContainer(
              duration: _isDragging
                  ? Duration.zero
                  : const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              transform: Matrix4.translationValues(0.0, _dragOffset, 0.0),
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.screenshots.length,
                physics: _wasZoomed
                    ? const NeverScrollableScrollPhysics()
                    : const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  final oldIndex = _currentIndex;

                  setState(() {
                    _currentIndex = index;
                    _updateActiveController();
                  });

                  _resetZoom(oldIndex);
                },
                itemBuilder: (context, index) {
                  final screenshot = widget.screenshots[index];
                  final isRevealed = _revealedIndices.contains(index);
                  final shouldBlur =
                      !settings.showExplicitContent &&
                      screenshot.sexual != null &&
                      screenshot.sexual! > 0.2 &&
                      !isRevealed;

                  return GestureDetector(
                    onDoubleTapDown: (details) =>
                        _handleDoubleTap(index, details),
                    onDoubleTap: () {},
                    child: InteractiveViewer(
                      transformationController: _getController(index),
                      clipBehavior: Clip.none,
                      minScale: 1.0,
                      maxScale: 4.0,
                      child: Center(
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: screenshot.url,
                              fit: BoxFit.contain,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.broken_image,
                                size: 64,
                                color: Colors.grey,
                              ),
                            ),
                            if (shouldBlur)
                              Positioned.fill(
                                child: ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 20,
                                      sigmaY: 20,
                                    ),
                                    child: Container(
                                      color: Colors.black.withValues(
                                        alpha: 0.6,
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.visibility_off_rounded,
                                            color: Colors.white70,
                                            size: 48,
                                          ),
                                          const SizedBox(height: 12),
                                          const Text(
                                            'Sensitive Content Hidden',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white10,
                                              foregroundColor: Colors.white,
                                              side: const BorderSide(
                                                color: Colors.white30,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 10,
                                                  ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _revealedIndices.add(index);
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.visibility_rounded,
                                              size: 16,
                                            ),
                                            label: const Text(
                                              'Reveal Image',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
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
                      ),
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
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '${_currentIndex + 1} / ${widget.screenshots.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
