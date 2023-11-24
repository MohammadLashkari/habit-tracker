import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_tracker/constants/app_colors.dart';
import 'package:habit_tracker/models/task.dart';
import 'package:habit_tracker/theming/app_theme.dart';

class TaskPresetListTile extends StatelessWidget {
  const TaskPresetListTile({
    super.key,
    required this.task,
    this.showChevron = true,
    this.onPressed,
  });
  final Task task;
  final bool showChevron;
  final ValueChanged<Task>? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onPressed?.call(task);
      },
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.of(context).settingsListIconBackground,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          height: 24,
          width: 24,
          task.iconName,
          colorFilter: const ColorFilter.mode(
            AppColors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
      title: Text(
        task.name,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppTheme.of(context).settingsText,
            ),
      ),
      trailing: showChevron
          ? Icon(
              Icons.chevron_right,
              color: AppTheme.of(context).accent,
              size: 32,
            )
          : null,
    );
  }
}
