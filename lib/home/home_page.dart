import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/app_assets.dart';
import 'package:habit_tracker/models/task_preset.dart';
import 'package:habit_tracker/task/task_with_name.dart';
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
          child: TaskWithName(
            task: TaskPreset(name: 'Do Some Coding', iconName: AppAssets.html),
          ),
        ),
      ),
    );
  }
}
