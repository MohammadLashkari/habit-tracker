import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDataBase {
  static const tasksBoxName = 'tasks';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Task>(TaskAdapter());
    await Hive.openBox<Task>(tasksBoxName);
  }

  Future<void> createDemoTasks({
    required List<Task> tasks,
  }) async {
    final box = Hive.box<Task>(tasksBoxName);
    if (box.isEmpty) {
      await box.addAll(tasks);
    }
  }

  ValueListenable<Box<Task>> taskListenble() {
    return Hive.box<Task>(tasksBoxName).listenable();
  }
}

final hiveDataBaseProvider = Provider<HiveDataBase>((ref) {
  throw UnimplementedError();
});
