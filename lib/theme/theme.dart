import 'package:flutter/material.dart';
import 'package:handees/res/shapes.dart';

const lightColorScheme = ColorScheme.light(
  primary: Colors.black,
  onPrimary: Colors.white,
  primaryContainer: Colors.black,
  onPrimaryContainer: Colors.white,
);

const authColorScheme = ColorScheme.dark(
  primary: Colors.white,
  onPrimary: Colors.black,
  primaryContainer: Colors.white,
  onPrimaryContainer: Colors.black,
);

final darkColorScheme = ColorScheme.dark(
  primary: Color.fromARGB(255, 97, 97, 97),
  onPrimary: Colors.white,
  primaryContainer: Color.fromARGB(255, 97, 97, 97),
  onPrimaryContainer: Colors.white,
  background: ThemeData.dark().scaffoldBackgroundColor,
);

final buttonStyle = ButtonStyle(
  padding: MaterialStateProperty.all<EdgeInsets>(
    EdgeInsets.all(16),
  ),
  shape: MaterialStateProperty.all(Shapes.bigShape),
);

final lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  useMaterial3: true,
  elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
  outlinedButtonTheme: OutlinedButtonThemeData(style: buttonStyle),
  extensions: [
    ButtonThemeExtensions(
      filled: ElevatedButton.styleFrom(
        // Foreground color
        onPrimary: lightColorScheme.onPrimary,
        // Background color
        primary: lightColorScheme.primary,
      ).copyWith(
        elevation: ButtonStyleButton.allOrNull(0.0),
      ),
      tonal: ElevatedButton.styleFrom(
        // Foreground color
        onPrimary: lightColorScheme.onSecondaryContainer,
        // Background color
        primary: lightColorScheme.secondaryContainer,
      ).copyWith(
        elevation: ButtonStyleButton.allOrNull(0.0),
      ),
    )
  ],
);

final authTheme = ThemeData(
  colorScheme: authColorScheme,
  useMaterial3: true,
  scaffoldBackgroundColor: authColorScheme.background,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: buttonStyle.copyWith(
      shape: MaterialStateProperty.all(Shapes.authShape),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(style: buttonStyle),
  extensions: [
    ButtonThemeExtensions(
      filled: ElevatedButton.styleFrom(
        // Foreground color
        onPrimary: authColorScheme.onPrimary,
        // Background color
        primary: authColorScheme.primary,
      ).copyWith(
        elevation: ButtonStyleButton.allOrNull(0.0),
      ),
      tonal: ElevatedButton.styleFrom(
        // Foreground color
        onPrimary: authColorScheme.onSecondaryContainer,
        // Background color
        primary: authColorScheme.secondaryContainer,
      ).copyWith(
        elevation: ButtonStyleButton.allOrNull(0.0),
      ),
    )
  ],
);

final darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  useMaterial3: true,
  elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
  outlinedButtonTheme: OutlinedButtonThemeData(style: buttonStyle),
  extensions: [
    ButtonThemeExtensions(
      filled: ElevatedButton.styleFrom(
        // Foreground color
        onPrimary: darkColorScheme.onPrimary,
        // Background color
        primary: darkColorScheme.primary,
      ).copyWith(
        elevation: ButtonStyleButton.allOrNull(0.0),
      ),
      tonal: ElevatedButton.styleFrom(
        // Foreground color
        onPrimary: authColorScheme.onSecondaryContainer,
        // Background color
        primary: authColorScheme.secondaryContainer,
      ).copyWith(
        elevation: ButtonStyleButton.allOrNull(0.0),
      ),
    )
  ],
);

@immutable
class ButtonThemeExtensions extends ThemeExtension<ButtonThemeExtensions> {
  const ButtonThemeExtensions({
    required this.filled,
    required this.tonal,
  });

  final ButtonStyle? filled;
  final ButtonStyle? tonal;

  @override
  ButtonThemeExtensions copyWith({ButtonStyle? filled, ButtonStyle? tonal}) {
    return ButtonThemeExtensions(
      filled: filled ?? this.filled,
      tonal: tonal ?? this.tonal,
    );
  }

  @override
  ButtonThemeExtensions lerp(
      ThemeExtension<ButtonThemeExtensions>? other, double t) {
    if (other is! ButtonThemeExtensions) {
      return this;
    }
    return ButtonThemeExtensions(
      filled: ButtonStyle.lerp(filled, other.filled, t),
      tonal: ButtonStyle.lerp(tonal, other.tonal, t),
    );
  }

  // Optional
  @override
  String toString() => 'MyColors(brandColor: $filled, danger: $tonal)';
}
