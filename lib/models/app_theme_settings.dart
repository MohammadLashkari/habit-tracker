import 'package:flutter/foundation.dart' show immutable;
import 'package:habit_tracker/constants/app_colors.dart';
import 'package:habit_tracker/models/front_or_back_side.dart';
import 'package:habit_tracker/theming/app_theme.dart';
import 'package:hive/hive.dart';

part 'app_theme_settings.g.dart';

@immutable
@HiveType(typeId: 2)
class AppThemeSettings {
  // Index used to reference one of the colors in AppColors
  // Can range between 0 and AppColors.allColors.length - 1
  @HiveField(0)
  final int colorIndex;

  // Index used to reference the currently selected variant for each color
  // Can range between 0 and 2
  @HiveField(1)
  final int variantIndex;

  const AppThemeSettings({
    required this.colorIndex,
    required this.variantIndex,
  });

  factory AppThemeSettings.defaults(FrontOrBackSide side) {
    return AppThemeSettings(
      colorIndex: 0,
      variantIndex: side == FrontOrBackSide.front ? 0 : 2,
    );
  }

  // actual AppThemeData object to be used by widgets
  AppThemeData get themeData {
    final colorSwatch = AppColors.allSwatches[colorIndex];
    final variants = AppThemeVariants(swatch: colorSwatch);
    return variants.themes[variantIndex];
  }

  AppThemeSettings copyWith({
    int? colorIndex,
    int? variantIndex,
  }) {
    return AppThemeSettings(
      colorIndex: colorIndex ?? this.colorIndex,
      variantIndex: variantIndex ?? this.variantIndex,
    );
  }
}
