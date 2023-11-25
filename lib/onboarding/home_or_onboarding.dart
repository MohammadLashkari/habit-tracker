import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/home/home_screen.dart';
import 'package:habit_tracker/onboarding/onboarding_screen.dart';
import 'package:habit_tracker/persistence/hive_database.dart';

class HomeOrOnboarding extends ConsumerWidget {
  const HomeOrOnboarding({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(hiveDatabaseProvider);
    return ValueListenableBuilder(
      valueListenable: database.didAddFirstTaskListenable(),
      builder: (context, box, child) {
        return database.didAddFirstTask(box)
            ? const HomeScreen()
            : const OnboardingPage();
      },
    );
  }
}
