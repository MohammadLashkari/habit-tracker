import 'dart:math';

import 'package:flutter/material.dart';

class ScreenFlip extends StatefulWidget {
  const ScreenFlip({
    super.key,
    required this.front,
    required this.back,
  });
  final Widget front;
  final Widget back;

  @override
  State<ScreenFlip> createState() => ScreenFlipState();
}

class ScreenFlipState extends State<ScreenFlip>
    with SingleTickerProviderStateMixin {
  bool _showFrontSide = true;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed ||
            status == AnimationStatus.dismissed) {
          setState(() => _showFrontSide = !_showFrontSide);
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void flip() {
    if (_showFrontSide) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {},
      child: AnimatedScreen(
        animation: _controller,
        showFrontSide: _showFrontSide,
        front: widget.front,
        back: widget.back,
      ),
    );
  }
}

class AnimatedScreen extends AnimatedWidget {
  const AnimatedScreen({
    super.key,
    required this.animation,
    required this.showFrontSide,
    required this.front,
    required this.back,
  }) : super(listenable: animation);

  final Animation<double> animation;
  final bool showFrontSide;
  final Widget front;
  final Widget back;

  @override
  Widget build(BuildContext context) {
    final isAnimationFirstHalf = animation.value < 0.5;
    final child = isAnimationFirstHalf ? front : back;
    final rotationValue = animation.value * pi;
    final rotationAngle =
        animation.value > 0.5 ? pi - rotationValue : rotationValue;
    var tilt = (animation.value - 0.5).abs() - 0.5;
    tilt *= isAnimationFirstHalf ? -0.003 : 0.003;
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 0, tilt)
        ..rotateY(rotationAngle),
      child: child,
    );
  }
}
