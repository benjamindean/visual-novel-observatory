import 'package:material_ui/material_ui.dart';

import '../../theme/app_theme.dart';

class ImagePlaceholder extends StatelessWidget {
  final double? width;
  final double? height;
  final double? iconSize;
  final Color? backgroundColor;

  const ImagePlaceholder({
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
          Icons.image_outlined,
          color: context.appTextMuted,
          size: iconSize ?? 32.0,
        ),
      ),
    );
  }
}
