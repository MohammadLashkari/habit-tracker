import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/home/tasks_grid_screen.dart';
import 'package:habit_tracker/persistence/hive_database.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final box = ref.watch(hiveDataBaseProvider);
    return ValueListenableBuilder(
      valueListenable: box.taskListenble(),
      builder: (context, box, child) {
        return TasksGridScreen(
          tasks: box.values.toList(),
        );
      },
    );
  }
}
