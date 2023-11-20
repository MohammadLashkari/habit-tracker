import 'package:flutter/material.dart';
import 'package:habit_tracker/theming/app_theme.dart';

enum PanelDirection {
  left,
  right,
}

class SlidingPanel extends StatelessWidget {
  const SlidingPanel({
    super.key,
    this.child,
    required this.direction,
  });

  final Widget? child;
  final PanelDirection direction;
  static const leftPanelFixedWidth = 54.0;

  // double panelWidth(double screenWidth) =>
  //     direction == PanelDirection.left ? 54.0 : screenWidth - 54.0;

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      height: 38.0,
      // width: panelWidth(screenWidth),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: AppTheme.of(context).accent,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: child,
    );
  }
}
