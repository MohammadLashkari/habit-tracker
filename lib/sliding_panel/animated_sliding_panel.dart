import 'package:flutter/material.dart';
import 'package:habit_tracker/sliding_panel/sliding_panel.dart';

class AnimatedSlidingPanel extends StatefulWidget {
  const AnimatedSlidingPanel({
    super.key,
    required this.child,
    required this.direction,
  });
  final Widget child;
  final PanelDirection direction;

  @override
  State<AnimatedSlidingPanel> createState() => AnimatedSlidingPanelState();
}

class AnimatedSlidingPanelState extends State<AnimatedSlidingPanel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void slidIn() {
    _controller.forward();
  }

  void slidOut() {
    _controller.reverse();
  }

  double get _offsetX {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final startOffset = widget.direction == PanelDirection.right
        ? screenWidth - SlidingPanel.leftPanelFixedWidth
        : -SlidingPanel.leftPanelFixedWidth;
    return startOffset * (1.0 - _animation.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: SlidingPanel(
        direction: widget.direction,
        child: widget.child,
      ),
      builder: (context, child) {
        if (_animation.value == 0.0) {
          return const SizedBox();
        } else {
          return Transform.translate(
            offset: Offset(_offsetX, 0),
            child: child,
          );
        }
      },
    );
  }
}
