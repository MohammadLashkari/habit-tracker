import 'package:flutter/material.dart';
import 'package:habit_tracker/theming/app_theme.dart';

class TextFieldHeader extends StatelessWidget {
  const TextFieldHeader(
    this.text, {
    super.key,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppTheme.of(context).settingsLabel,
            ),
      ),
    );
  }
}
