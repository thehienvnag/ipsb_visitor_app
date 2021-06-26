import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimateWrapper extends StatelessWidget {
  final Widget? child;

  final int index;
  final int columnCount;
  final Duration duration;

  const AnimateWrapper({
    Key? key,
    this.child,
    required this.index,
    this.columnCount = 2,
    this.duration = const Duration(milliseconds: 365),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      columnCount: columnCount,
      position: index,
      duration: duration,
      child: ScaleAnimation(
        scale: 0.5,
        child: FadeInAnimation(
          child: child ?? Text('No child provided!'),
        ),
      ),
    );
  }
}
