import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/app_assets.dart';
import 'package:habit_tracker/task/task_ring.dart';

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
  bool _showCheckIcon = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    _controller.addStatusListener(_checkStatusUpdates);
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

  void _checkStatusUpdates(AnimationStatus status) {
    if (_controller.isCompleted) {
      if (mounted) {
        setState(() => _showCheckIcon = true);
      }
      Future.delayed(
        const Duration(milliseconds: 750),
        () {
          if (mounted) {
            setState(() => _showCheckIcon = false);
          }
        },
      );
    }
  }

  void _tapDown(TapDownDetails details) {
    if (!_controller.isCompleted) {
      _controller.forward();
    } else if (!_showCheckIcon) {
      _controller.reset();
    }
  }

  void _tapUp(TapUpDetails details) {
    if (!_controller.isCompleted) {
      _controller.reverse();
    }
  }

  void _tapCancel() {
    if (!_controller.isCompleted) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: _tapUp,
      onTapDown: _tapDown,
      onTapCancel: _tapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return TaskRing(
            iconName: _showCheckIcon ? AppAssets.check : widget.iconName,
            progress: _animation.value,
          );
        },
      ),
    );
  }
}
