import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/models/front_or_back_side.dart';
import 'package:habit_tracker/onboarding/home_or_onboarding.dart';
import 'package:habit_tracker/persistence/hive_database.dart';
import 'package:habit_tracker/theming/app_theme_notifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Change SystemNavigationBar setting
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  final hiveDatabase = HiveDatabase();
  await hiveDatabase.init();
  // await hiveDatabase.createDemoTasks(
  //   frontTasks: [
  //     Task(name: 'Eat a Healthy Meal', iconName: AppAssets.carrot),
  //     Task(name: 'Walk the Dog', iconName: AppAssets.dog),
  //     Task(name: 'Do Some Coding', iconName: AppAssets.html),
  //     Task(name: 'Do 10 Pushups', iconName: AppAssets.pushups),
  //     Task(name: 'Play Sports', iconName: AppAssets.basketball),
  //   ],
  //   backTasks: [
  //     Task(name: 'Eat a Healthy Meal', iconName: AppAssets.carrot),
  //     Task(name: 'Do Some Coding', iconName: AppAssets.html),
  //     Task(name: 'Play Sports', iconName: AppAssets.basketball),
  //     Task(name: 'Spend Time Outside', iconName: AppAssets.sun),
  //   ],
  //   force: false,
  // );
  final frontThemeSettings = await hiveDatabase.appThemeSettings(
    side: FrontOrBackSide.front,
  );
  final backThemeSettings = await hiveDatabase.appThemeSettings(
    side: FrontOrBackSide.back,
  );
  runApp(
    ProviderScope(
      overrides: [
        hiveDatabaseProvider.overrideWithValue(hiveDatabase),
        frontThemeProvider.overrideWith(
          (ref) => AppThemeNotifier(
            themeSttings: frontThemeSettings,
            hiveDatabase: hiveDatabase,
            side: FrontOrBackSide.front,
          ),
        ),
        backThemeProvider.overrideWith(
          (ref) => AppThemeNotifier(
            themeSttings: backThemeSettings,
            hiveDatabase: hiveDatabase,
            side: FrontOrBackSide.back,
          ),
        ),
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
      home: const HomeOrOnboarding(),
    );
  }
}
