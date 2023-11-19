import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/home/screen_flip.dart';
import 'package:habit_tracker/home/tasks_grid_screen.dart';
import 'package:habit_tracker/persistence/hive_database.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final _pageFlipKey = GlobalKey<ScreenFlipState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(hiveDataBaseProvider);
    return ScreenFlip(
      key: _pageFlipKey,
      front: ValueListenableBuilder(
        valueListenable: database.frontTaskListenble(),
        builder: (context, box, child) {
          return TasksGridScreen(
            tasks: box.values.toList(),
            onFlip: () => _pageFlipKey.currentState?.flip(),
          );
        },
      ),
      back: ValueListenableBuilder(
        valueListenable: database.backTaskListenble(),
        builder: (context, box, child) {
          return TasksGridScreen(
            tasks: box.values.toList(),
            onFlip: () => _pageFlipKey.currentState?.flip(),
          );
        },
      ),
    );
  }
}
