import 'dart:math' as math;
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'image_error_widget.dart';
import 'image_placeholder.dart';

class CachedAppImage extends StatelessWidget {
  const CachedAppImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.shouldBlur = false,
    this.blurSigma = 12.0,
    this.blurredCacheScale = 0.45,
    this.cacheScale = 1.0,
    this.fadeInDuration = Duration.zero,
    this.fadeOutDuration = Duration.zero,
    this.placeholderIconSize,
    this.placeholderBackgroundColor,
    this.errorBackgroundColor,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final bool shouldBlur;
  final double blurSigma;
  final double blurredCacheScale;
  final double cacheScale;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;
  final double? placeholderIconSize;
  final Color? placeholderBackgroundColor;
  final Color? errorBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cacheSize = _cacheSizeFor(
          context: context,
          constraints: constraints,
        );

        if (!shouldBlur) {
          return CachedNetworkImage(
            imageUrl: imageUrl,
            width: width,
            height: height,
            fit: fit,
            alignment: alignment,
            memCacheWidth: cacheSize.width,
            memCacheHeight: cacheSize.height,
            fadeInDuration: fadeInDuration,
            fadeOutDuration: fadeOutDuration,
            placeholder: _buildPlaceholder,
            errorWidget: _buildError,
          );
        }

        return CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          memCacheWidth: cacheSize.width,
          memCacheHeight: cacheSize.height,
          fadeInDuration: fadeInDuration,
          fadeOutDuration: fadeOutDuration,
          imageBuilder: (context, imageProvider) {
            return ClipRect(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: blurSigma,
                  sigmaY: blurSigma,
                  tileMode: TileMode.clamp,
                ),
                child: Image(
                  image: imageProvider,
                  width: width,
                  height: height,
                  fit: fit,
                  alignment: alignment,
                ),
              ),
            );
          },
          placeholder: _buildPlaceholder,
          errorWidget: _buildError,
        );
      },
    );
  }

  ({int? width, int? height}) _cacheSizeFor({
    required BuildContext context,
    required BoxConstraints constraints,
  }) {
    final logicalWidth = _resolvedExtent(width, constraints.maxWidth);
    final logicalHeight = _resolvedExtent(height, constraints.maxHeight);
    final ratio = MediaQuery.devicePixelRatioOf(context);
    final scale = shouldBlur ? blurredCacheScale : cacheScale;

    return (
      width: _cacheExtent(logicalWidth, ratio, scale),
      height: _cacheExtent(logicalHeight, ratio, scale),
    );
  }

  double? _resolvedExtent(double? explicitExtent, double constrainedExtent) {
    if (explicitExtent != null && explicitExtent.isFinite) {
      return explicitExtent;
    }

    if (constrainedExtent.isFinite && constrainedExtent > 0) {
      return constrainedExtent;
    }

    return null;
  }

  int? _cacheExtent(double? logicalExtent, double ratio, double scale) {
    if (logicalExtent == null) {
      return null;
    }

    return math.max(1, (logicalExtent * ratio * scale).round());
  }

  Widget _buildPlaceholder(BuildContext context, String url) {
    return ImagePlaceholder(
      width: width,
      height: height,
      iconSize: placeholderIconSize,
      backgroundColor: placeholderBackgroundColor,
    );
  }

  Widget _buildError(BuildContext context, String url, Object error) {
    return ImageErrorWidget(
      width: width,
      height: height,
      iconSize: placeholderIconSize,
      backgroundColor: errorBackgroundColor ?? placeholderBackgroundColor,
    );
  }
}

class CachedPosterImage extends StatelessWidget {
  const CachedPosterImage({
    super.key,
    required this.imageUrl,
    required this.shouldBlur,
    this.width,
    this.height,
    this.borderRadius,
    this.fadeInDuration = Duration.zero,
    this.fadeOutDuration = Duration.zero,
  });

  final String imageUrl;
  final bool shouldBlur;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;

  @override
  Widget build(BuildContext context) {
    final image = CachedAppImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      shouldBlur: shouldBlur,
      placeholderBackgroundColor: context.appSearchField,
      errorBackgroundColor: context.appSearchField,
      fadeInDuration: fadeInDuration,
      fadeOutDuration: fadeOutDuration,
    );

    if (borderRadius == null) {
      return image;
    }

    return ClipRRect(
      borderRadius: borderRadius!,
      child: image,
    );
  }
}

class CachedAvatarImage extends StatelessWidget {
  const CachedAvatarImage({
    super.key,
    required this.imageUrl,
    required this.size,
    required this.shouldBlur,
    this.blurSigma = 12.0,
  });

  final String imageUrl;
  final double size;
  final bool shouldBlur;
  final double blurSigma;

  @override
  Widget build(BuildContext context) {
    return CachedAppImage(
      imageUrl: imageUrl,
      width: size,
      height: size,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
      shouldBlur: shouldBlur,
      blurSigma: blurSigma,
      placeholderIconSize: size * 0.4,
    );
  }
}
