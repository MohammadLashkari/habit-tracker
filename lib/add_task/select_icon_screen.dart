import 'package:flutter/material.dart';
import 'package:habit_tracker/common_widgets/svg_icon.dart';
import 'package:habit_tracker/constants/app_colors.dart';
import 'package:habit_tracker/models/task.dart';
import 'package:habit_tracker/theming/app_theme.dart';

class SelectIconScreen extends StatefulWidget {
  const SelectIconScreen({
    super.key,
    required this.selectedIconName,
  });
  final String selectedIconName;

  @override
  State<StatefulWidget> createState() => _SelectIconScreenState();
}

class _SelectIconScreenState extends State<SelectIconScreen> {
  late String _selectedIconName = widget.selectedIconName;

  void _select(String selectedIconName) {
    // * If the currently selected icon is chosen again
    if (_selectedIconName == selectedIconName) {
      // * call the callback, which will dismiss the page and return the icon name
      Navigator.of(context).pop(_selectedIconName);
    } else {
      // * Otherwise update the state (but don't call anything just yet)
      setState(() => _selectedIconName = selectedIconName);
      Navigator.of(context).pop(_selectedIconName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.85,
      decoration: BoxDecoration(
        color: AppTheme.of(context).primary,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: Task.taskPerest.length,
        itemBuilder: (context, index) {
          final iconName = Task.taskPerest[index].iconName;
          return SelectTaskIcon(
            iconName: iconName,
            isSelected: _selectedIconName == iconName,
            onPressed: () => _select(iconName),
          );
        },
      ),
    );
  }
}

class SelectTaskIcon extends StatelessWidget {
  const SelectTaskIcon({
    super.key,
    required this.iconName,
    required this.isSelected,
    this.onPressed,
  });
  final String iconName;
  final bool isSelected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? AppTheme.of(context).accent
              : AppTheme.of(context).settingsInactiveIconBackground,
        ),
        child: SvgIcon(
          iconName: iconName,
          color: isSelected
              ? AppTheme.of(context).accentNegative
              : AppColors.white,
        ),
      ),
    );
  }
}
