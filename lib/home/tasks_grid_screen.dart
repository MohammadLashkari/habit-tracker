import 'package:flutter/material.dart';
import 'package:habit_tracker/home/home_screen_bottom_options.dart';
import 'package:habit_tracker/home/tasks_grid.dart';
import 'package:habit_tracker/models/task.dart';
import 'package:habit_tracker/theming/app_theme.dart';

class TasksGridScreen extends StatelessWidget {
  const TasksGridScreen({
    super.key,
    required this.tasks,
    this.onFlip,
  });
  final List<Task> tasks;
  final VoidCallback? onFlip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: SafeArea(
        child: TasksGridContents(
          tasks: tasks,
          onFlip: onFlip,
        ),
      ),
    );
  }
}

class TasksGridContents extends StatelessWidget {
  const TasksGridContents({
    super.key,
    required this.tasks,
    this.onFlip,
  });
  final List<Task> tasks;
  final VoidCallback? onFlip;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: TasksGrid(
              tasks: tasks,
            ),
          ),
        ),
        HomeScreenBottomOptions(
          onFlip: onFlip,
        ),
      ],
    );
  }
}
