import 'package:flutter/material.dart';
import 'package:habit_tracker/theming/app_theme.dart';

class HomeScreenBottomOptions extends StatelessWidget {
  const HomeScreenBottomOptions({super.key, this.onFlip});
  final VoidCallback? onFlip;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onFlip,
          icon: Icon(
            Icons.flip,
            color: AppTheme.of(context).settingsLabel,
          ),
        ),
      ],
    );
  }
}
