import 'package:flutter/foundation.dart' show immutable;
import 'package:habit_tracker/constants/app_assets.dart';
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

  static List<Task> taskPerest = [
    Task(name: 'Eat a Healthy Meal', iconName: AppAssets.carrot),
    Task(name: 'Walk the Dog', iconName: AppAssets.dog),
    Task(name: 'Do Some Coding', iconName: AppAssets.html),
    Task(name: 'Meditate', iconName: AppAssets.meditation),
    Task(name: 'Do 10 Pushups', iconName: AppAssets.pushups),
    Task(name: 'Sleep 8 Hours', iconName: AppAssets.rest),
    Task(name: 'Take Vitamins', iconName: AppAssets.vitamins),
    Task(name: 'Cycle to Work', iconName: AppAssets.bike),
    Task(name: 'Wash Your Hands', iconName: AppAssets.washHands),
    Task(name: 'Wear a Mask', iconName: AppAssets.mask),
    Task(name: 'Brush Your Teeth', iconName: AppAssets.toothbrush),
    Task(name: 'Floss Your Teeth', iconName: AppAssets.dentalFloss),
    Task(name: 'Drink Water', iconName: AppAssets.water),
    Task(name: 'Practice Instrument', iconName: AppAssets.guitar),
    Task(name: 'Read for 10 Minutes', iconName: AppAssets.book),
    Task(name: 'Don\'t Smoke', iconName: AppAssets.smoking),
    Task(name: 'Don\'t Drink Alcohol', iconName: AppAssets.beer),
    Task(name: 'Decrease Screen Time', iconName: AppAssets.phone),
    Task(name: 'Do a Workout', iconName: AppAssets.dumbell),
    Task(name: 'Do Karate', iconName: AppAssets.karate),
    Task(name: 'Go Running', iconName: AppAssets.run),
    Task(name: 'Go Swimming', iconName: AppAssets.swimmer),
    Task(name: 'Do Some Stretches', iconName: AppAssets.stretching),
    Task(name: 'Play Sports', iconName: AppAssets.basketball),
    Task(name: 'Spend Time Outside', iconName: AppAssets.sun),
  ];

  @override
  String toString() => 'Task(id: $id, name: $name, iconName: $iconName)';
}
