import 'package:flutter/material.dart';
import 'package:handee/utils/handee_colors.dart';

final darkTheme = ThemeData.dark().copyWith(
  appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.background,
      foregroundColor: colorScheme.onBackground),
  colorScheme: colorScheme,
  scaffoldBackgroundColor: colorScheme.background,
);

const colorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: HandeeColors.black,
  onPrimary: HandeeColors.white,
  secondary: HandeeColors.black,
  onSecondary: HandeeColors.white,
  error: HandeeColors.red,
  onError: HandeeColors.white,
  background: HandeeColors.black22,
  onBackground: HandeeColors.white,
  surface: HandeeColors.black22,
  onSurface: HandeeColors.white,
);
