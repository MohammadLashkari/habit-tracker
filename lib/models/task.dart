import 'package:flutter/foundation.dart' show immutable;
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@immutable
@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String iconName;

  Task({
    String? id,
    required this.name,
    required this.iconName,
  }) : id = id ?? const Uuid().v4();
}
