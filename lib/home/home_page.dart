import 'package:flutter/material.dart';
import 'package:habit_tracker/common_widgets/animated_task.dart';
import 'package:habit_tracker/constants/app_assets.dart';
import 'package:habit_tracker/theming/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: const Center(
        child: SizedBox(
          width: 240,
          height: 240,
          child: AnimatedTask(
            iconName: AppAssets.dog,
          ),
        ),
      ),
    );
  }
}
