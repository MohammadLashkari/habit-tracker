import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/home/tasks_grid_screen.dart';
import 'package:habit_tracker/persistence/hive_database.dart';
import 'package:page_flip_builder/page_flip_builder.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _pageFlipKey = GlobalKey<PageFlipBuilderState>();

  @override
  Widget build(BuildContext context) {
    final database = ref.watch(hiveDataBaseProvider);
    return PageFlipBuilder(
      key: _pageFlipKey,
      frontBuilder: (_) => ValueListenableBuilder(
        valueListenable: database.frontTaskListenble(),
        builder: (context, box, child) {
          return TasksGridScreen(
            key: GlobalKey(),
            tasks: box.values.toList(),
            onFlip: () => _pageFlipKey.currentState?.flip(),
          );
        },
      ),
      backBuilder: (_) => ValueListenableBuilder(
        valueListenable: database.backTaskListenble(),
        builder: (context, box, child) {
          return TasksGridScreen(
            key: GlobalKey(),
            tasks: box.values.toList(),
            onFlip: () => _pageFlipKey.currentState?.flip(),
          );
        },
      ),
    );
  }
}
