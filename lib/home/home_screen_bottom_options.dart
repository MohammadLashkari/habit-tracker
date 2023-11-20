import 'package:flutter/material.dart';
import 'package:habit_tracker/theming/app_theme.dart';

class HomeScreenBottomOptions extends StatelessWidget {
  const HomeScreenBottomOptions({
    super.key,
    this.onFlip,
    this.onEnterEditMode,
  });

  final VoidCallback? onFlip;
  final VoidCallback? onEnterEditMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onEnterEditMode,
          icon: Icon(
            Icons.settings,
            color: AppTheme.of(context).settingsLabel,
          ),
        ),
        IconButton(
          onPressed: onFlip,
          icon: Icon(
            Icons.flip,
            color: AppTheme.of(context).settingsLabel,
          ),
        ),
        const Opacity(
          opacity: 0.0,
          child: IconButton(
            onPressed: null,
            icon: Icon(
              Icons.flip,
            ),
          ),
        ),
      ],
    );
  }
}
