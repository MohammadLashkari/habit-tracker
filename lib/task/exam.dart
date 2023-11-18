import 'dart:math';

import 'package:flutter/material.dart';

class MidExam extends StatefulWidget {
  const MidExam({super.key});

  @override
  State<MidExam> createState() => _MidExamState();
}

class _MidExamState extends State<MidExam> {
  @override
  Widget build(BuildContext context) {
    return const CustomPaint(
      painter: MyRing(),
    );
  }
}

class MyRing extends CustomPainter {
  const MyRing();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = size.width / 15.0;
    final backgroundPaint = Paint()
      ..isAntiAlias = true
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, backgroundPaint);

    final forgroundPaint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = Colors.white;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      pi,
      false,
      forgroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
