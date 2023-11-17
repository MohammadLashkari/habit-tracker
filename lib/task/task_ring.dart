import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:habit_tracker/common_widgets/svg_icon.dart';
import 'package:habit_tracker/theming/app_theme.dart';

class TaskRing extends StatelessWidget {
  const TaskRing({
    super.key,
    required this.progress,
    required this.iconName,
  });
  final double progress;
  final String iconName;

  @override
  Widget build(BuildContext context) {
    final themeDate = AppTheme.of(context);
    return AspectRatio(
      aspectRatio: 1.0,
      child: CustomPaint(
        painter: RingPainter(
          progress: progress,
          taskCompletedColor: themeDate.accent,
          taskNotCompletedColor: themeDate.taskRing,
        ),
        child: SvgIcon(
          iconName: iconName,
          color: progress == 1 ? themeDate.accentNegative : themeDate.taskIcon,
        ),
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  const RingPainter({
    required this.progress,
    required this.taskCompletedColor,
    required this.taskNotCompletedColor,
  });
  final double progress;
  final Color taskCompletedColor;
  final Color taskNotCompletedColor;

  @override
  void paint(Canvas canvas, Size size) {
    final notCompleted = progress < 1.0;
    final strokeWidth = size.width / 15.0;
    final radius =
        notCompleted ? (size.width - strokeWidth) / 2.0 : (size.width) / 2;
    final center = Offset(
      size.width / 2.0,
      size.height / 2.0,
    );
    if (notCompleted) {
      final backgroundPaint = Paint()
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..color = taskNotCompletedColor;

      canvas.drawCircle(center, radius, backgroundPaint);
    }

    final forgroundPanit = Paint()
      ..isAntiAlias = true
      ..style = notCompleted ? PaintingStyle.stroke : PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = taskCompletedColor;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      forgroundPanit,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is RingPainter && oldDelegate.progress != progress;
  }
}
