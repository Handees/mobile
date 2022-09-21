import 'package:flutter/material.dart';

mixin InputValidationMixin {
  bool isEmailValid(String email) {
    var pattern = r'^\S+@\S+\.\S+$';
    var regex = RegExp(pattern);

    return regex.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    var light = r'^(?=.*?[A-Za-z])(?=.*?[0-9]).{6,}$';
    // var extreme =
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$';
    var regex = RegExp(light);

    return regex.hasMatch(password);
  }

  bool isNumberValid(String number) {
    var pattern = r'^[0-9-+\s]+$';
    var regex = RegExp(pattern);

    return regex.hasMatch(number);
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(10),
      // ),
    ),
  );
}
