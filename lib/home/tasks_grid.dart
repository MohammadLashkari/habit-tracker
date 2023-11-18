import 'package:flutter/material.dart';
import 'package:habit_tracker/models/task_preset.dart';
import 'package:habit_tracker/task/task_with_name.dart';

class TasksGrid extends StatelessWidget {
  const TasksGrid({super.key, required this.tasks});
  final List<TaskPreset> tasks;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 40,
        childAspectRatio: 0.8,
      ),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskWithName(
          task: task,
        );
      },
    );
  }
}
