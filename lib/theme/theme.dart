import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handees/res/shapes.dart';

final textTheme = GoogleFonts.cabinTextTheme(const TextTheme()).copyWith(
    // titleMedium: TextStyle(fontSize: 18),
    // labelLarge: TextStyle(fontSize: 16),
    );

const lightColorScheme = ColorScheme.light(
  primary: Color.fromRGBO(20, 22, 28, 1),
  onPrimary: Colors.white,
  // secondary: Color.fromRGBO(242, 243, 244, 1),
  onSecondary: Color.fromRGBO(20, 22, 28, 1),
  secondary: Color.fromRGBO(235, 237, 240, 1),
  // primaryContainer: Color.fromRGBO(20, 22, 28, 1),
  // onPrimaryContainer: Colors.white,
  brightness: Brightness.light,
);

const authColorScheme = ColorScheme.dark(
  primary: Colors.white,
  onPrimary: Colors.black,
  // primaryContainer: Colors.white,
  // onPrimaryContainer: Colors.black,
  brightness: Brightness.dark,
);

final darkColorScheme = ColorScheme.dark(
  primary: Color.fromARGB(255, 97, 97, 97),
  onPrimary: Colors.white,
  // primaryContainer: Color.fromARGB(255, 97, 97, 97),
  // onPrimaryContainer: Colors.white,
  background: ThemeData.dark().scaffoldBackgroundColor,
  brightness: Brightness.dark,
);

final buttonStyle = ButtonStyle(
  padding: MaterialStateProperty.all<EdgeInsets>(
    EdgeInsets.all(16),
  ),
  shape: MaterialStateProperty.all(Shapes.bigShape),
);

ThemeData buildTheme(ColorScheme colorScheme) => ThemeData.from(
      colorScheme: colorScheme,
      useMaterial3: true,
    ).copyWith(
      // textTheme: textTheme,
      appBarTheme: AppBarTheme().copyWith(centerTitle: true),
      scaffoldBackgroundColor: colorScheme.background,
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(colorScheme.primary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
      outlinedButtonTheme: OutlinedButtonThemeData(style: buttonStyle),
      textButtonTheme: TextButtonThemeData(style: buttonStyle),
      extensions: [
        ButtonThemeExtensions(
          filled: ElevatedButton.styleFrom(
            onPrimary: colorScheme.onPrimary,
            primary: colorScheme.primary,
          ).copyWith(
            elevation: ButtonStyleButton.allOrNull(0.0),
          ),
          tonal: ElevatedButton.styleFrom(
            onPrimary: colorScheme.onSecondaryContainer,
            primary: colorScheme.secondaryContainer,
          ).copyWith(
            elevation: ButtonStyleButton.allOrNull(0.0),
          ),
        )
      ],
    );

final lightTheme = buildTheme(lightColorScheme);

final darkTheme = buildTheme(darkColorScheme);

final authTheme = buildTheme(authColorScheme);

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
