import 'package:flutter/material.dart';
import 'package:handees/shared/utils/logger.dart';
import 'package:url_launcher/url_launcher.dart';

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

Color getHexColor(String hexColor) {
  if (hexColor.length != 6) {
    throw 'hexColor must be of length 6';
  }

  int val = 0xff000000 + int.parse(hexColor, radix: 16);
  return Color(val);
}

void dPrint(dynamic message) {
  MyLogger.instance.logger.d(message);
}

void ePrint(dynamic message) {
  MyLogger.instance.logger.e(message);
}

Future<void> openUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
