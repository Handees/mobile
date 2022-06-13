import 'package:flutter/material.dart';
import 'package:handee/utils/handee_colors.dart';

final lightTheme = ThemeData.light().copyWith(
  appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.background,
      foregroundColor: colorScheme.onBackground),
  colorScheme: colorScheme,
  scaffoldBackgroundColor: colorScheme.background,
);

const colorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: HandeeColors.black,
  onPrimary: HandeeColors.white,
  secondary: HandeeColors.black,
  onSecondary: HandeeColors.white,
  error: HandeeColors.red,
  onError: HandeeColors.white,
  background: HandeeColors.white,
  onBackground: HandeeColors.black,
  surface: HandeeColors.white,
  onSurface: HandeeColors.black,
);
