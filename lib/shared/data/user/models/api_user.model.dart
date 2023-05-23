import 'package:flutter/foundation.dart';

@immutable
class ApiUserModel {
  final List addresses;
  final artisanProfile; //TODO: Should be typed
  final List bookings;
  final List cards; //TODO: Should be typed
  final String createAt;
  final String email;
  final bool isArtisan;
  final bool isEmailVerified;
  final String name;
  final List payments;
  final List ratings; //TODO: Should be typed
  final String signUpDate;
  final String telephone;
  final String userId;

  ApiUserModel.fromJson(Map<String, dynamic> json)
      : addresses = json['addresses'],
        artisanProfile = json['artisan_profile'],
        bookings = json['bookings'],
        cards = json['cards'],
        createAt = json['created_at'],
        email = json['email'],
        isArtisan = json['is_artisan'],
        isEmailVerified = json['is_email_verified'],
        name = json['name'],
        payments = json['payments'],
        ratings = json['ratings'],
        signUpDate = json['sign_up_date'],
        telephone = json['telephone'] ?? '',
        userId = json['user_id'];

  ApiUserModel.empty()
      : addresses = [],
        artisanProfile = null,
        bookings = [],
        cards = [],
        createAt = "",
        email = "",
        isArtisan = false,
        isEmailVerified = false,
        name = "",
        payments = [],
        ratings = [],
        signUpDate = "",
        telephone = "",
        userId = "";
}
