import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/models/task.dart';
import 'package:habit_tracker/persistence/hive_database.dart';
import 'package:habit_tracker/task/task_with_name.dart';

class TaskWithNameLoader extends ConsumerWidget {
  const TaskWithNameLoader({
    super.key,
    required this.task,
    this.isEditing = false,
    this.editTaskButton,
  });
  final Task task;
  final bool isEditing;
  final Widget? editTaskButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(hiveDataBaseProvider);
    return ValueListenableBuilder(
      valueListenable: database.taskStateListenble(task: task),
      builder: (context, box, child) {
        final taskState = database.taskState(box, task: task);
        return TaskWithName(
          task: task,
          completed: taskState.completed,
          editTaskButtonBuilder: editTaskButton,
          onCompleted: (completed) {
            ref.read(hiveDataBaseProvider).setTaskState(
                  task: task,
                  completed: completed,
                );
          },
        );
      },
    );
  }
}
