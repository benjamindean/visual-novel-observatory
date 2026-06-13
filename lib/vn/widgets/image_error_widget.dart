import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ImageErrorWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final double? iconSize;
  final Color? backgroundColor;

  const ImageErrorWidget({
    super.key,
    this.width,
    this.height,
    this.iconSize,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: backgroundColor ?? context.appSurface,
      child: Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: context.appTextMuted,
          size: iconSize ?? 32.0,
        ),
      ),
    );
  }
}
