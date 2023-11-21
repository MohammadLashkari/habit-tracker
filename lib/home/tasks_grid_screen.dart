import 'package:flutter/material.dart';
import 'package:habit_tracker/home/home_screen_bottom_options.dart';
import 'package:habit_tracker/home/tasks_grid.dart';
import 'package:habit_tracker/models/app_theme_settings.dart';
import 'package:habit_tracker/models/task.dart';
import 'package:habit_tracker/sliding_panel/animated_sliding_panel.dart';
import 'package:habit_tracker/sliding_panel/sliding_panel.dart';
import 'package:habit_tracker/sliding_panel/theme_selection_close.dart';
import 'package:habit_tracker/sliding_panel/theme_selection_list.dart';
import 'package:habit_tracker/theming/animated_app_theme.dart';
import 'package:habit_tracker/theming/app_theme.dart';

class TasksGridScreen extends StatelessWidget {
  const TasksGridScreen({
    super.key,
    required this.tasks,
    required this.leftAnimatedKey,
    required this.rightAnimatedKey,
    required this.themeSettings,
    required this.gridKey,
    this.onColorIndexSelected,
    this.onVariantIndexSelected,
    this.onFlip,
  });
  final List<Task> tasks;
  final VoidCallback? onFlip;
  final GlobalKey<AnimatedSlidingPanelState> leftAnimatedKey;
  final GlobalKey<AnimatedSlidingPanelState> rightAnimatedKey;
  final GlobalKey<TasksGridState> gridKey;
  final AppThemeSettings themeSettings;
  final ValueChanged<int>? onColorIndexSelected;
  final ValueChanged<int>? onVariantIndexSelected;

  void _enterEditMode() {
    leftAnimatedKey.currentState?.slidIn();
    rightAnimatedKey.currentState?.slidIn();
    gridKey.currentState?.enterEditMode();
  }

  void _exitEditMode() {
    leftAnimatedKey.currentState?.slidOut();
    rightAnimatedKey.currentState?.slidOut();
    gridKey.currentState?.exitEditMode();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedAppTheme(
      data: themeSettings.themeData,
      duration: const Duration(seconds: 5),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppTheme.of(context).primary,
            body: SafeArea(
              child: Stack(
                children: [
                  TasksGridContents(
                    gridKey: gridKey,
                    tasks: tasks,
                    onFlip: onFlip,
                    onEnterEditMode: _enterEditMode,
                  ),
                  Positioned(
                    bottom: 7.0,
                    left: 0.0,
                    width: SlidingPanel.leftPanelFixedWidth,
                    child: AnimatedSlidingPanel(
                      key: leftAnimatedKey,
                      direction: PanelDirection.left,
                      child: ThemeSelectionClose(
                        onClose: _exitEditMode,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 7.0,
                    right: 0.0,
                    width: MediaQuery.sizeOf(context).width -
                        SlidingPanel.leftPanelFixedWidth,
                    child: AnimatedSlidingPanel(
                      key: rightAnimatedKey,
                      direction: PanelDirection.right,
                      child: ThemeSelectionList(
                        currentThemeSettings: themeSettings,
                        onColorIndexSelected: onColorIndexSelected,
                        onVariantIndexSelected: onVariantIndexSelected,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TasksGridContents extends StatelessWidget {
  const TasksGridContents({
    super.key,
    required this.tasks,
    this.gridKey,
    this.onFlip,
    this.onEnterEditMode,
  });
  final List<Task> tasks;
  final Key? gridKey;
  final VoidCallback? onFlip;
  final VoidCallback? onEnterEditMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: TasksGrid(
              key: gridKey,
              tasks: tasks,
            ),
          ),
        ),
        HomeScreenBottomOptions(
          onFlip: onFlip,
          onEnterEditMode: onEnterEditMode,
        ),
      ],
    );
  }
}
