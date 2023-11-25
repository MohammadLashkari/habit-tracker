import 'package:flutter/material.dart';
import 'package:habit_tracker/add_task/add_task_screen.dart';
import 'package:habit_tracker/constants/app_assets.dart';
import 'package:habit_tracker/constants/app_colors.dart';
import 'package:habit_tracker/models/front_or_back_side.dart';
import 'package:habit_tracker/models/task.dart';
import 'package:habit_tracker/task/task_with_name.dart';
import 'package:habit_tracker/theming/app_theme.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  Future<void> _addTask(
    BuildContext context,
    AppThemeData appThemeData,
  ) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => AppTheme(
          data: AppTheme.of(context),
          child: const AddTaskScreen(
            frontOrBackSide: FrontOrBackSide.front,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const size = 150.0;
    final padding = (MediaQuery.of(context).size.width - size) / 2;
    const defaultColorSwatch = AppColors.red;
    final defaultAppThemeVariants = AppThemeVariants(
      swatch: defaultColorSwatch,
    );
    final appThemeData = defaultAppThemeVariants.themes[0];
    return AppTheme(
      data: appThemeData,
      child: Scaffold(
        backgroundColor: defaultColorSwatch[0],
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add a task to begin.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(
                height: 128,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Builder(
                  builder: (context) {
                    return TaskWithName(
                      task: Task(
                        id: '',
                        name: 'Tap and hold\nto add a task',
                        iconName: AppAssets.plus,
                      ),
                      hasCompletedState: false,
                      onCompleted: (completed) =>
                          _addTask(context, appThemeData),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
