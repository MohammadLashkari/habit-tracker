import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/models/app_theme_settings.dart';
import 'package:habit_tracker/models/front_or_back_side.dart';
import 'package:habit_tracker/models/task.dart';
import 'package:habit_tracker/models/task_state.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  static const frontTasksBoxName = 'frontTasks';
  static const backTasksBoxName = 'backTasks';
  static const tasksStateBoxName = 'tasksState';
  static const frontAppThemeBoxName = 'frontAppTheme';
  static const backAppThemeBoxName = 'backAppTheme';
  static const alwaysShowAddTaskKey = 'alwaysShowAddTask';
  static const didAddFirstTaskKey = 'didAddFirstTask';
  static const flagsBoxName = 'flags';
  static String taskStateKey(String key) => 'tasksState/$key';

  Future<void> init() async {
    await Hive.initFlutter();
    // Register adapters
    Hive.registerAdapter<Task>(TaskAdapter());
    Hive.registerAdapter<TaskState>(TaskStateAdapter());
    Hive.registerAdapter<AppThemeSettings>(AppThemeSettingsAdapter());
    // Open boxes
    await Hive.openBox<Task>(frontTasksBoxName);
    await Hive.openBox<Task>(backTasksBoxName);
    await Hive.openBox<TaskState>(tasksStateBoxName);
    await Hive.openBox<AppThemeSettings>(frontAppThemeBoxName);
    await Hive.openBox<AppThemeSettings>(backAppThemeBoxName);
    await Hive.openBox<bool>(flagsBoxName);
  }

  Future<void> createDemoTasks({
    required List<Task> frontTasks,
    required List<Task> backTasks,
    bool force = false,
  }) async {
    final frontBox = Hive.box<Task>(frontTasksBoxName);
    if (frontBox.isEmpty || force == true) {
      await frontBox.clear();
      await frontBox.addAll(frontTasks);
    }
    final backBox = Hive.box<Task>(backTasksBoxName);
    if (backBox.isEmpty || force == true) {
      await backBox.clear();
      await backBox.addAll(backTasks);
    }
  }

  // front and back tasks
  ValueListenable<Box<Task>> frontTaskListenble() {
    return Hive.box<Task>(frontTasksBoxName).listenable();
  }

  ValueListenable<Box<Task>> backTaskListenble() {
    return Hive.box<Task>(backTasksBoxName).listenable();
  }

  // TaskState methods
  Future<void> setTaskState({
    required Task task,
    required bool completed,
  }) async {
    final box = Hive.box<TaskState>(tasksStateBoxName);
    final taskState = TaskState(taskId: task.id, completed: completed);
    await box.put(taskStateKey(task.id), taskState);
  }

  ValueListenable<Box<TaskState>> taskStateListenble({
    required Task task,
  }) {
    final box = Hive.box<TaskState>(tasksStateBoxName);
    final key = taskStateKey(task.id);
    return box.listenable(keys: [key]);
  }

  TaskState taskState(Box<TaskState> box, {required Task task}) {
    final key = taskStateKey(task.id);
    return box.get(key) ?? TaskState(taskId: task.id, completed: false);
  }

  // App Theme Settings
  Future<void> setAppThemeSettings({
    required AppThemeSettings settings,
    required FrontOrBackSide side,
  }) async {
    final themeKey = side == FrontOrBackSide.front
        ? frontAppThemeBoxName
        : backAppThemeBoxName;
    final box = Hive.box<AppThemeSettings>(themeKey);
    await box.put(themeKey, settings);
  }

  Future<AppThemeSettings> appThemeSettings({
    required FrontOrBackSide side,
  }) async {
    final themeKey = side == FrontOrBackSide.front
        ? frontAppThemeBoxName
        : backAppThemeBoxName;
    final box = Hive.box<AppThemeSettings>(themeKey);
    final settings = box.get(themeKey);
    return settings ?? AppThemeSettings.defaults(side);
  }

  // Save and delete tasks
  Future<void> saveTask(Task task, FrontOrBackSide frontOrBackSide) async {
    final boxName = frontOrBackSide == FrontOrBackSide.front
        ? frontTasksBoxName
        : backTasksBoxName;
    final box = Hive.box<Task>(boxName);
    if (box.values.isEmpty) {
      await box.add(task);
    } else {
      final index = box.values
          .toList()
          .indexWhere((taskAtIndex) => taskAtIndex.id == task.id);
      if (index >= 0) {
        await box.putAt(index, task);
      } else {
        await box.add(task);
      }
    }
  }

  Future<void> deleteTask(Task task, FrontOrBackSide frontOrBackSide) async {
    final boxName = frontOrBackSide == FrontOrBackSide.front
        ? frontTasksBoxName
        : backTasksBoxName;
    final box = Hive.box<Task>(boxName);
    if (box.isNotEmpty) {
      final index = box.values
          .toList()
          .indexWhere((taskAtIndex) => taskAtIndex.id == task.id);
      if (index >= 0) {
        await box.deleteAt(index);
      }
    }
  }

  // Did Add First Task
  Future<void> setDidAddFirstTask(bool value) async {
    final box = Hive.box<bool>(flagsBoxName);
    await box.put(didAddFirstTaskKey, value);
  }

  ValueListenable<Box<bool>> didAddFirstTaskListenable() {
    return Hive.box<bool>(flagsBoxName)
        .listenable(keys: <String>[didAddFirstTaskKey]);
  }

  bool didAddFirstTask(Box<bool> box) {
    final value = box.get(didAddFirstTaskKey);
    return value ?? false;
  }

  // Always Show Add Task
  Future<void> setAlwaysShowAddTask(bool value) async {
    final box = Hive.box<bool>(flagsBoxName);
    await box.put(alwaysShowAddTaskKey, value);
  }

  ValueListenable<Box<bool>> alwaysShowAddTaskListenable() {
    return Hive.box<bool>(flagsBoxName)
        .listenable(keys: <String>[alwaysShowAddTaskKey]);
  }

  bool alwaysShowAddTask(Box<bool> box) {
    final value = box.get(alwaysShowAddTaskKey);
    return value ?? true;
  }
}

final hiveDatabaseProvider = Provider<HiveDatabase>((ref) {
  throw UnimplementedError();
});
