import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/models/app_theme_settings.dart';
import 'package:habit_tracker/models/front_or_back_side.dart';
import 'package:habit_tracker/persistence/hive_database.dart';

final frontThemeProvider =
    StateNotifierProvider<AppThemeNotifier, AppThemeSettings>(
  (ref) {
    throw UnimplementedError();
  },
);

final backThemeProvider =
    StateNotifierProvider<AppThemeNotifier, AppThemeSettings>(
  (ref) {
    throw UnimplementedError();
  },
);

class AppThemeNotifier extends StateNotifier<AppThemeSettings> {
  final HiveDatabase hiveDatabase;
  final FrontOrBackSide side;

  AppThemeNotifier({
    required AppThemeSettings themeSttings,
    required this.hiveDatabase,
    required this.side,
  }) : super(themeSttings);

  void updateColorIndex(int colorIndex) {
    state = state.copyWith(colorIndex: colorIndex);
    hiveDatabase.setAppThemeSettings(settings: state, side: side);
  }

  void updateVariantIndex(int variantIndex) {
    state = state.copyWith(variantIndex: variantIndex);
    hiveDatabase.setAppThemeSettings(settings: state, side: side);
  }
}
