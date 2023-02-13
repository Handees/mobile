import 'package:flutter/material.dart';

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
  String toString() => 'ButtonExtension(filled: $filled, tonal: $tonal)';
}
