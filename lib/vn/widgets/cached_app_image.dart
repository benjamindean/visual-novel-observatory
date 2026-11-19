import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_ui/material_ui.dart';
import 'package:visual_novel_observatory/vn/utils/image_cache_size.dart';

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
    this.blurSigma = 60.0,
    this.fadeInDuration = const Duration(milliseconds: 200),
    this.fadeOutDuration = const Duration(milliseconds: 200),
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
  final Duration fadeInDuration;
  final Duration fadeOutDuration;
  final double? placeholderIconSize;
  final Color? placeholderBackgroundColor;
  final Color? errorBackgroundColor;

  @override
  Widget build(BuildContext context) {
    if (!shouldBlur) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        fadeInDuration: fadeInDuration,
        fadeOutDuration: fadeOutDuration,
        placeholder: _buildPlaceholder,
        errorWidget: _buildError,
        maxWidthDiskCache: coverImageMaxWidthDiskCache,
        maxHeightDiskCache: coverImageMaxHeightDiskCache,
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
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
      maxWidthDiskCache: coverImageMaxWidthDiskCache,
      maxHeightDiskCache: coverImageMaxHeightDiskCache,
    );
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
    this.fadeInDuration = const Duration(milliseconds: 200),
    this.fadeOutDuration = const Duration(milliseconds: 200),
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
    this.fadeInDuration = const Duration(milliseconds: 200),
    this.fadeOutDuration = const Duration(milliseconds: 200),
  });

  final String imageUrl;
  final double size;
  final bool shouldBlur;
  final double blurSigma;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;

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
      fadeInDuration: fadeInDuration,
      fadeOutDuration: fadeOutDuration,
      placeholderIconSize: size * 0.4,
    );
  }
}
