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
      // Swipe down or up far enough -> dismiss
      Navigator.of(context).pop();
    } else {
      // Snap back to center
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
          // Drag-to-dismiss wrapper
          GestureDetector(
            onVerticalDragUpdate: _onVerticalDragUpdate,
            onVerticalDragEnd: _onVerticalDragEnd,
            child: AnimatedContainer(
              duration: _isDragging
                  ? Duration.zero
                  : const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              transform: Matrix4.translationValues(0.0, _dragOffset, 0.0),
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.screenshots.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final screenshot = widget.screenshots[index];
                  final isRevealed = _revealedIndices.contains(index);
                  final shouldBlur =
                      !settings.showExplicitContent &&
                      screenshot.sexual != null &&
                      screenshot.sexual! > 0.2 &&
                      !isRevealed;

                  return InteractiveViewer(
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
                                    color: Colors.black.withValues(alpha: 0.6),
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
                                            padding: const EdgeInsets.symmetric(
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
                  );
                },
              ),
            ),
          ),

          // Close button & Image index overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
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
        ],
      ),
    );
  }
}
