import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker/animations/fade_animation.dart';
import 'package:habit_tracker/animations/staggerd_scale_animation.dart';
import 'package:habit_tracker/common_widgets/add_task_item.dart';
import 'package:habit_tracker/common_widgets/edit_task_button.dart';
import 'package:habit_tracker/models/task.dart';
import 'package:habit_tracker/task/task_with_name_loader.dart';

class TasksGrid extends StatefulWidget {
  const TasksGrid({
    super.key,
    required this.tasks,
    this.onEditTask,
  });
  final List<Task> tasks;
  final VoidCallback? onEditTask;

  @override
  State<TasksGrid> createState() => TasksGridState();
}

class TasksGridState extends State<TasksGrid>
    with SingleTickerProviderStateMixin {
  late final AnimationController _contrller;
  @override
  void initState() {
    super.initState();
    _contrller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _contrller.dispose();
    super.dispose();
  }

  void enterEditMode() {
    _contrller.forward();
  }

  void exitEditMode() {
    _contrller.reverse();
  }

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
      itemCount: min(6, widget.tasks.length + 1),
      itemBuilder: (context, index) {
        if (index == widget.tasks.length) {
          return FadeAnimation(
            animation: _contrller,
            child: const AddTaskItem(),
          );
        }
        final task = widget.tasks[index];
        return TaskWithNameLoader(
          task: task,
          isEditing: false,
          editTaskButton: StaggeredScaleAnimation(
            animation: _contrller,
            index: index,
            child: EditTaskButton(
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }
}
