import 'package:flutter/material.dart';
import 'package:habit_tracker/add_task/custom_text_field.dart';
import 'package:habit_tracker/add_task/task_details_screen.dart';
import 'package:habit_tracker/add_task/task_preset_list_tile.dart';
import 'package:habit_tracker/add_task/text_field_header.dart';
import 'package:habit_tracker/models/front_or_back_side.dart';
import 'package:habit_tracker/models/task.dart';
import 'package:habit_tracker/theming/app_theme.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      appBar: AppBar(
        backgroundColor: AppTheme.of(context).secondary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Add Task',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: AppTheme.of(context).settingsText,
              ),
        ),
        leading: CloseButton(
          color: AppTheme.of(context).settingsText,
        ),
      ),
      body: const AddTaskContents(),
    );
  }
}

class AddTaskContents extends StatelessWidget {
  const AddTaskContents({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const TextFieldHeader('CREATE YOUR OWN'),
          CustomTextField(
            hintText: 'Enter task title...',
            showChevron: true,
            onSubmit: (value) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AppTheme(
                    data: AppTheme.of(context),
                    child: TaskDetailsScreen(
                      frontOrBackSide: FrontOrBackSide.front,
                      isNewTask: true,
                      task: Task(
                        name: value,
                        iconName: value.substring(0, 1).toUpperCase(),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 28),
          const TextFieldHeader('OR CHOOSE A PRESET'),
          const SizedBox(height: 8),
          Container(
            color: AppTheme.of(context).secondary,
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 8.0, bottom: 50.0),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: Task.taskPerest.length,
              itemBuilder: (context, index) {
                return TaskPresetListTile(
                  task: Task.taskPerest[index],
                  onPressed: (task) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => AppTheme(
                          data: AppTheme.of(context),
                          child: TaskDetailsScreen(
                            frontOrBackSide: FrontOrBackSide.front,
                            isNewTask: true,
                            task: task,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
