import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/constants/app_colors.dart';
import 'package:habit_tracker/home/home_page.dart';
import 'package:habit_tracker/theming/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
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
