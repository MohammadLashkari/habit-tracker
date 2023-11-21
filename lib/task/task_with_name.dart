import 'package:flutter/material.dart';
import 'package:habit_tracker/common_widgets/edit_task_button.dart';
import 'package:habit_tracker/models/task.dart';
import 'package:habit_tracker/task/animated_task.dart';
import 'package:habit_tracker/theming/app_theme.dart';

class TaskWithName extends StatelessWidget {
  const TaskWithName({
    super.key,
    required this.task,
    this.completed = false,
    this.isEditing = false,
    this.hasCompletedState = true,
    this.onCompleted,
    this.editTaskButton,
  });

  final Task task;
  final bool completed;
  final bool hasCompletedState;
  final bool isEditing;
  final ValueChanged<bool>? onCompleted;
  final Widget? editTaskButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0),
          child: Stack(
            children: [
              AnimatedTask(
                iconName: task.iconName,
                completed: completed,
                onCompleted: onCompleted,
                hasCompletedState: hasCompletedState,
              ),
              if (editTaskButton != null)
                Positioned.fill(
                  child: FractionallySizedBox(
                    widthFactor: EditTaskButton.scaleFactor,
                    heightFactor: EditTaskButton.scaleFactor,
                    alignment: Alignment.bottomRight,
                    child: editTaskButton!,
                  ),
                ),
            ],
          ),
        ),
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
