import 'package:flutter/material.dart';
import 'package:handees/res/shapes.dart';

class CustomDelegate extends SliverPersistentHeaderDelegate {
  CustomDelegate({required this.height, required this.child, this.shape});

  final double height;
  final Widget child;
  final ShapeBorder? shape;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 4.0,
        shape: shape ?? Shapes.bigShape,
        // color: Colors.transparent,
        shadowColor: Theme.of(context).colorScheme.shadow,
        child: child,
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
