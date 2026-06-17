import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';
import 'library_sliver_app_bar.dart';

class LibraryStatusScrollView extends StatelessWidget {
  const LibraryStatusScrollView({
    super.key,
    required this.physics,
    this.icon,
    this.iconColor,
    this.message,
    this.messageColor,
    this.child,
  });

  final ScrollPhysics physics;
  final IconData? icon;
  final Color? iconColor;
  final String? message;
  final Color? messageColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: physics,
      slivers: [
        const LibrarySliverAppBar(),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child:
                  child ??
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(
                          icon,
                          size: 48,
                          color: iconColor ?? context.appTextMuted,
                        ),
                        const SizedBox(height: 16),
                      ],
                      if (message != null)
                        Text(
                          message!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: messageColor ?? context.appTextMuted,
                          ),
                        ),
                    ],
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
