import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/add_task/custom_text_field.dart';
import 'package:habit_tracker/add_task/select_icon_screen.dart';
import 'package:habit_tracker/add_task/task_preset_list_tile.dart';
import 'package:habit_tracker/add_task/text_field_header.dart';
import 'package:habit_tracker/common_widgets/edit_task_button.dart';
import 'package:habit_tracker/common_widgets/primary_button.dart';
import 'package:habit_tracker/constants/app_assets.dart';
import 'package:habit_tracker/models/front_or_back_side.dart';
import 'package:habit_tracker/models/task.dart';
import 'package:habit_tracker/persistence/hive_database.dart';
import 'package:habit_tracker/task/task_ring.dart';
import 'package:habit_tracker/theming/app_theme.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({
    super.key,
    required this.task,
    required this.isNewTask,
    required this.frontOrBackSide,
  });
  final Task task;
  final bool isNewTask;
  final FrontOrBackSide frontOrBackSide;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppTheme.of(context).secondary,
        leading: isNewTask
            ? BackButton(
                color: AppTheme.of(context).settingsText,
              )
            : CloseButton(
                color: AppTheme.of(context).settingsText,
              ),
        title: Text(
          isNewTask ? 'Confirm Task' : 'Edit Task',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: AppTheme.of(context).settingsText,
              ),
        ),
      ),
      body: SafeArea(
        child: ConfirmTaskContents(
          task: task,
          isNewTask: isNewTask,
          frontOrBackSide: frontOrBackSide,
        ),
      ),
    );
  }
}

class ConfirmTaskContents extends ConsumerStatefulWidget {
  const ConfirmTaskContents({
    super.key,
    required this.task,
    required this.isNewTask,
    required this.frontOrBackSide,
  });
  final Task task;
  final bool isNewTask;
  final FrontOrBackSide frontOrBackSide;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConfirmTaskContentsState();
}

class _ConfirmTaskContentsState extends ConsumerState<ConfirmTaskContents> {
  final _textFieldKey = GlobalKey<FormFieldState>();
  late String _iconName = widget.task.iconName;

  Future<void> _saveTask() async {
    // final textFieldState = _textFieldKey.currentState;
    // if (textFieldState != null) {
    //   // Create new task with updated name and asset icon
    //   final task = Task(
    //     id: widget.task.id,
    //     name: textFieldState.text,
    //     iconName: _iconName,
    //   );

    try {
      final database = ref.read(hiveDatabaseProvider);
      // * Once the first task is added, we no longer need to show the onboarding screen
      await database.setDidAddFirstTask(true);
      await database.saveTask(widget.task, widget.frontOrBackSide);
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask() async {
    final didConfirm = await showAdaptiveDialog<bool?>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.of(context).primary,
              ),
              child: const Text('Delete'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.of(context).primary,
              ),
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);

    if (didConfirm == true) {
      try {
        final dataStore = ref.read(hiveDatabaseProvider);
        // * No longer show [AddTaskItem] widget by default after a task is deleted for the first time
        await dataStore.setAlwaysShowAddTask(false);
        await dataStore.deleteTask(widget.task, widget.frontOrBackSide);
        // * Pop back to HomePage, using `rootNavigator: true` to ensure we dismiss the entire navigation stack.
        if (mounted) {
          Navigator.of(context, rootNavigator: true).pop();
        }
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> changeIcon() async {
    final appThemeData = AppTheme.of(context);
    final iconName = await showModalBottomSheet<String?>(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      builder: (_) => AppTheme(
        data: appThemeData,
        child: SelectIconScreen(
          selectedIconName: _iconName,
        ),
      ),
    );
    setState(() => _iconName = iconName ?? _iconName);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32),
          ConfirmTaskHeader(
            iconName: _iconName,
            onChangeIcon: changeIcon,
          ),
          const SizedBox(height: 48),
          const TextFieldHeader('TITLE'),
          CustomTextField(
            key: _textFieldKey,
            initialValue: widget.task.name,
            hintText: 'Enter task title...',
          ),
          if (!widget.isNewTask) ...[
            Container(height: 48),
            TaskPresetListTile(
              showChevron: false,
              task: Task(
                name: 'Delete Task',
                iconName: AppAssets.delete,
              ),
              onPressed: (_) => deleteTask(),
            ),
          ],
          widget.isNewTask
              ? const SizedBox(height: 315)
              : const SizedBox(height: 230),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: PrimaryButton(
              title: widget.isNewTask ? 'SAVE TASK' : 'DONE',
              onPressed: _saveTask,
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}

class ConfirmTaskHeader extends StatelessWidget {
  const ConfirmTaskHeader({
    super.key,
    this.onChangeIcon,
    required this.iconName,
  });
  final String iconName;
  final VoidCallback? onChangeIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 120),
      child: Stack(
        children: [
          TaskRing(
            progress: 0,
            iconName: iconName,
          ),
          Positioned.fill(
            child: FractionallySizedBox(
              widthFactor: EditTaskButton.scaleFactor,
              heightFactor: EditTaskButton.scaleFactor,
              alignment: Alignment.bottomRight,
              child: EditTaskButton(
                onPressed: onChangeIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
