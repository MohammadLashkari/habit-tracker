import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/add_task/add_task_screen.dart';
import 'package:habit_tracker/add_task/task_details_screen.dart';
import 'package:habit_tracker/animations/fade_animation.dart';
import 'package:habit_tracker/animations/staggerd_scale_animation.dart';
import 'package:habit_tracker/common_widgets/add_task_item.dart';
import 'package:habit_tracker/common_widgets/edit_task_button.dart';
import 'package:habit_tracker/models/front_or_back_side.dart';
import 'package:habit_tracker/models/task.dart';
import 'package:habit_tracker/task/task_with_name_loader.dart';
import 'package:habit_tracker/theming/app_theme.dart';

class TasksGrid extends StatefulWidget {
  const TasksGrid({
    super.key,
    required this.tasks,
    this.onAddOrEditTask,
  });
  final List<Task> tasks;
  final VoidCallback? onAddOrEditTask;

  @override
  State<TasksGrid> createState() => TasksGridState();
}

class TasksGridState extends State<TasksGrid>
    with SingleTickerProviderStateMixin {
  late final AnimationController _contrller;
  bool _isEditing = false;
  @override
  void initState() {
    super.initState();
    _contrller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 270),
    );
  }

  @override
  void dispose() {
    _contrller.dispose();
    super.dispose();
  }

  void enterEditMode() {
    _contrller.forward();
    setState(() => _isEditing = true);
  }

  void exitEditMode() {
    _contrller.reverse();
    setState(() => _isEditing = false);
  }

  Future<void> _addTask(WidgetRef ref) async {
    final frontOrBackSide = ref.read(frontOrBackSideProvider);
    widget.onAddOrEditTask?.call();
    await Future.delayed(const Duration(milliseconds: 270));
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => AppTheme(
            data: AppTheme.of(context),
            child: AddTaskScreen(
              frontOrBackSide: frontOrBackSide,
            ),
          ),
        ),
      );
    }
  }

  Future<void> _editTask(WidgetRef ref, Task task) async {
    widget.onAddOrEditTask?.call();
    final frontOrBackSide = ref.read(frontOrBackSideProvider);
    await Future.delayed(const Duration(milliseconds: 270));
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => AppTheme(
            data: AppTheme.of(context),
            child: TaskDetailsScreen(
              task: task,
              isNewTask: false,
              frontOrBackSide: frontOrBackSide,
            ),
          ),
        ),
      );
    }
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
        return Consumer(
          builder: (context, ref, child) {
            if (index == widget.tasks.length) {
              return FadeAnimation(
                animation: _contrller,
                child: AddTaskItem(
                  onCompleted: () => _isEditing ? _addTask(ref) : null,
                ),
              );
            }
            final task = widget.tasks[index];
            return TaskWithNameLoader(
              task: task,
              isEditing: _isEditing,
              editTaskButton: StaggeredScaleAnimation(
                animation: _contrller,
                index: index,
                child: EditTaskButton(
                  onPressed: () => _editTask(ref, task),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
