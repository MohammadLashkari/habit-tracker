import 'package:flutter/material.dart';

class StaggeredScaleAnimationedWidget extends AnimatedWidget {
  StaggeredScaleAnimationedWidget({
    super.key,
    required Animation<double> animation,
    required this.child,
    required this.index,
  })  : scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: Interval(
              0.1 * index,
              0.5 + 0.1 * index,
              curve: Curves.easeInOutCubic,
            ),
          ),
        ),
        super(listenable: animation);

  final Widget child;
  final int index;
  final Animation<double> scaleAnimation;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scaleAnimation.value,
      child: child,
    );
  }
}
