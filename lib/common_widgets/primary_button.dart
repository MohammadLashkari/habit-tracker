import 'package:flutter/material.dart';
import 'package:habit_tracker/theming/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.onPressed,
    required this.title,
  });
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: AppTheme.of(context).settingsCta,
        fixedSize: const Size.fromHeight(60),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: AppTheme.of(context).settingsText,
            ),
      ),
    );
  }
}
