import 'package:flutter/material.dart';
import 'package:habit_tracker/models/task_preset.dart';
import 'package:habit_tracker/task/animated_task.dart';
import 'package:habit_tracker/theming/app_theme.dart';

class TaskWithName extends StatelessWidget {
  const TaskWithName({super.key, required this.task});

  final TaskPreset task;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedTask(iconName: task.iconName),
        const SizedBox(height: 10.0),
        Text(
          task.name.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppTheme.of(context).accent,
              ),
        ),
      ],
    );
  }
}
