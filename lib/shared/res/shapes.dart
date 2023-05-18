import 'package:flutter/painting.dart';

class Shapes {
  static const smallShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)));

  static const mediumShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(24.0)));

  static const bigShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16.0)));

  static const extraBigShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(40.0)));

  static const authShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)));
}
