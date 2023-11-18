import 'package:flutter/foundation.dart' show immutable;
import 'package:hive/hive.dart';

part 'task_state.g.dart';

@immutable
@HiveType(typeId: 1)
class TaskState {
  @HiveField(0)
  final String taskId;
  @HiveField(1)
  final bool completed;

  const TaskState({
    required this.taskId,
    required this.completed,
  });
}
