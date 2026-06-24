import 'package:flutter/material.dart';

class SliverBottomPadding extends StatelessWidget {
  final double height;
  
  const SliverBottomPadding({
    super.key,
    this.height = 64,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(height: height),
    );
  }
}
