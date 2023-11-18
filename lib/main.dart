import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/constants/app_assets.dart';
import 'package:habit_tracker/constants/app_colors.dart';
import 'package:habit_tracker/home/home_page.dart';
import 'package:habit_tracker/models/task.dart';
import 'package:habit_tracker/persistence/hive_database.dart';
import 'package:habit_tracker/theming/app_theme.dart';

Future<void> main() async {
  final hiveDataBase = HiveDataBase();
  await hiveDataBase.init();
  await hiveDataBase.createDemoTasks(
    tasks: [
      Task(name: 'Eat a Healthy Meal', iconName: AppAssets.carrot),
      Task(name: 'Walk the Dog', iconName: AppAssets.dog),
      Task(name: 'Do Some Coding', iconName: AppAssets.html),
      Task(name: 'Do 10 Pushups', iconName: AppAssets.pushups),
    ],
  );
  runApp(
    ProviderScope(
      overrides: [
        hiveDataBaseProvider.overrideWithValue(hiveDataBase),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: AppTheme(
        data: AppThemeData.defaultWithSwatch(AppColors.red),
        child: const HomePage(),
      ),
    );
  }
}
