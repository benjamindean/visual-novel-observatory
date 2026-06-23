import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';
import '../../../models/vn_screenshot.dart';
import '../../../widgets/cached_app_image.dart';
import 'vn_gallery_sensitive_overlay.dart';

class VnGalleryImagePage extends StatelessWidget {
  const VnGalleryImagePage({
    super.key,
    required this.screenshot,
    required this.shouldBlur,
    required this.onReveal,
  });

  final VnScreenshot screenshot;
  final bool shouldBlur;
  final VoidCallback onReveal;

  Size get _screenshotSize {
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
    if (!shouldBlur) {
      return CachedAppImage(
        imageUrl: screenshot.url,
        fit: BoxFit.cover,
        shouldBlur: false,
        blurSigma: 20.0,
        placeholderIconSize: 64.0,
        placeholderBackgroundColor: Colors.transparent,
        errorBackgroundColor: Colors.transparent,
      );
    }

    final screenshotSize = _screenshotSize;

    return Stack(
      fit: StackFit.expand,
      children: [
        Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              width: screenshotSize.width,
              height: screenshotSize.height,
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
                      child: ColoredBox(
                        color: context.appBackground.withValues(alpha: 0.65),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (shouldBlur)
          VnGallerySensitiveOverlay(
            onReveal: onReveal,
          ),
      ],
    );
  }
}
