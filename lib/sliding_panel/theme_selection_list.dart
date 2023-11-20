import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/app_colors.dart';
import 'package:habit_tracker/models/app_theme_settings.dart';
import 'package:habit_tracker/sliding_panel/sliding_panel.dart';
import 'package:habit_tracker/sliding_panel/theme_variant_picker.dart';

class ThemeSelectionList extends StatefulWidget {
  const ThemeSelectionList({
    super.key,
    required this.currentThemeSettings,
    this.onColorIndexSelected,
    this.onVariantIndexSelected,
  });
  final AppThemeSettings currentThemeSettings;
  final ValueChanged<int>? onColorIndexSelected;
  final ValueChanged<int>? onVariantIndexSelected;

  @override
  State<StatefulWidget> createState() => _ThemeSelectionListState();
}

class _ThemeSelectionListState extends State<ThemeSelectionList> {
  late final _controller = ScrollController(initialScrollOffset: scrollOffset);

  double get scrollOffset {
    final availableWidth =
        MediaQuery.sizeOf(context).width - SlidingPanel.leftPanelFixedWidth;
    final contentWidth =
        ThemeVariantPicker.itemSize * AppColors.allSwatches.length;
    final selectedIndex = widget.currentThemeSettings.colorIndex;
    final offset = ThemeVariantPicker.itemSize * selectedIndex -
        (availableWidth / 2 - ThemeVariantPicker.itemSize / 2);

    return max(min(offset, contentWidth - availableWidth), 0);
  }

  @override
  Widget build(BuildContext context) {
    final allColors = AppColors.allSwatches.map((swatch) => swatch[0]).toList();
    return ListView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      children: [
        for (final color in allColors)
          ThemeVariantPicker(
            color: color,
            isSelected: widget.currentThemeSettings.colorIndex ==
                allColors.indexOf(color),
            selectedVariantIndex: widget.currentThemeSettings.variantIndex,
            onColorSelected: (color) {
              final newIndex = allColors.indexOf(color);
              final previousIndex = widget.currentThemeSettings.colorIndex;
              if (previousIndex != newIndex) {
                widget.onColorIndexSelected?.call(
                  allColors.indexOf(color),
                );
              } else {
                final newVariantIndex =
                    (widget.currentThemeSettings.variantIndex + 1) % 3;
                widget.onVariantIndexSelected?.call(newVariantIndex);
              }
            },
          ),
      ],
    );
  }
}
