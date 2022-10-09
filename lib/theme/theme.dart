import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handees/res/shapes.dart';

final _textTheme = GoogleFonts.cabinTextTheme();
// .copyWith(
//     // titleMedium: TextStyle(fontSize: 18),
//     // labelLarge: TextStyle(fontSize: 16),
// );

const _lightColorScheme = ColorScheme.light(
  primary: Color.fromRGBO(20, 22, 28, 1),
  onPrimary: Colors.white,
  // secondary: Color.fromRGBO(242, 243, 244, 1),
  onSecondary: Color.fromRGBO(20, 22, 28, 1),
  secondary: Color.fromRGBO(235, 237, 240, 1),
  // primaryContainer: Color.fromRGBO(20, 22, 28, 1),
  // onPrimaryContainer: Colors.white,
  brightness: Brightness.light,
);

const _authColorScheme = ColorScheme.dark(
  primary: Colors.white,
  onPrimary: Colors.black,
  // primaryContainer: Colors.white,
  // onPrimaryContainer: Colors.black,
  brightness: Brightness.dark,
);

final _darkColorScheme = ColorScheme.dark(
  primary: Color.fromARGB(255, 97, 97, 97),
  onPrimary: Colors.white,
  // primaryContainer: Color.fromARGB(255, 97, 97, 97),
  // onPrimaryContainer: Colors.white,
  background: ThemeData.dark().scaffoldBackgroundColor,
  brightness: Brightness.dark,
);

final _buttonStyle = ButtonStyle(
  padding: MaterialStateProperty.all<EdgeInsets>(
    EdgeInsets.all(16),
  ),
  shape: MaterialStateProperty.all(Shapes.bigShape),
);

InputDecorationTheme _buildInputDecorationTheme(ColorScheme colorScheme) =>
    InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: Shapes.bigShape.borderRadius as BorderRadius,
        borderSide: BorderSide.none,
      ),
      fillColor: colorScheme.secondary,
      filled: true,
    );

ThemeData _buildTheme(ColorScheme colorScheme) => ThemeData.from(
      colorScheme: colorScheme,
      useMaterial3: true,
    ).copyWith(
      textTheme: _textTheme,
// dialogTheme: DialogTheme(),
      appBarTheme: AppBarTheme().copyWith(centerTitle: true),
      scaffoldBackgroundColor: colorScheme.background,
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(colorScheme.primary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: _buttonStyle),
      outlinedButtonTheme: OutlinedButtonThemeData(style: _buttonStyle),
      textButtonTheme: TextButtonThemeData(style: _buttonStyle),
      inputDecorationTheme: _buildInputDecorationTheme(colorScheme),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorScheme.primary,
        selectionColor: colorScheme.primary.withOpacity(0.5),
        selectionHandleColor: colorScheme.primary,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.surface,
        shape: Shapes.smallShape,
        // elevation: 8,
        behavior: SnackBarBehavior.floating,
      ),
      extensions: [
        ButtonThemeExtensions(
          filled: ElevatedButton.styleFrom(
            foregroundColor: colorScheme.onPrimary,
            backgroundColor: colorScheme.primary,
          ).copyWith(
            elevation: ButtonStyleButton.allOrNull(0.0),
          ),
          tonal: ElevatedButton.styleFrom(
            foregroundColor: colorScheme.onSecondaryContainer,
            backgroundColor: colorScheme.secondaryContainer,
          ).copyWith(
            elevation: ButtonStyleButton.allOrNull(0.0),
          ),
        )
      ],
    );

final lightTheme = _buildTheme(_lightColorScheme);

final darkTheme = _buildTheme(_darkColorScheme);

final authTheme = _buildTheme(_authColorScheme).copyWith(
  inputDecorationTheme: _buildInputDecorationTheme(_authColorScheme).copyWith(
    border: const OutlineInputBorder(),
    filled: false,
    // enabledBorder: OutlineInputBorder(
    //   borderSide: BorderSide(
    //     width: 2.0,
    //     color: authColorScheme.onBackground,
    //   ),
    // ),
    // errorBorder: OutlineInputBorder(
    //   borderSide: BorderSide(
    //     width: 2.0,
    //     color: authColorScheme.error,
    //   ),
    // ),
  ),
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
