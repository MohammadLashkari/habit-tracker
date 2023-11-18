import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/app_assets.dart';
import 'package:habit_tracker/home/tasks_grid.dart';
import 'package:habit_tracker/models/task_preset.dart';
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
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: TasksGrid(
          tasks: [
            TaskPreset(name: 'Eat a Healthy Meal', iconName: AppAssets.carrot),
            TaskPreset(name: 'Walk the Dog', iconName: AppAssets.dog),
            TaskPreset(name: 'Do Some Coding', iconName: AppAssets.html),
            TaskPreset(name: 'Meditate', iconName: AppAssets.meditation),
            TaskPreset(name: 'Do 10 Pushups', iconName: AppAssets.pushups),
            TaskPreset(name: 'Sleep 8 Hours', iconName: AppAssets.rest),
          ],
        ),
      ),
    );
  }
}
