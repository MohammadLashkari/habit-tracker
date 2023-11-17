import 'package:flutter/material.dart';
import 'package:habit_tracker/common_widgets/task_ring.dart';

class AnimatedTask extends StatefulWidget {
  const AnimatedTask({
    super.key,
    required this.iconName,
  });

  final String iconName;

  @override
  State<AnimatedTask> createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _tapDown(TapDownDetails details) {
    if (!_controller.isCompleted) {
      _controller.forward();
    } else {
      _controller.reset();
    }
  }

  void _tapUp(TapUpDetails details) {
    if (!_controller.isCompleted) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: _tapUp,
      onTapDown: _tapDown,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          // final themeDate = AppTheme.of(context);
          return TaskRing(
            iconName: widget.iconName,
            progress: _animation.value,
          );
        },
      ),
    );
  }
}
