import 'package:flutter/foundation.dart';

@immutable
class UserApiModel {
  final List<String> addresses;
  final artisanProfile; //TODO: Should be typed
  final List<String> bookings;
  final List cards; //TODO: Should be typed
  final String created_at;
  final String email;
  final bool isArtisan;
  final bool isEmailVerified;
  final String name;
  final List<String> payments;
  final List ratings; //TODO: Should be typed
  final String signUpDate;
  final String telephone;
  final String userId;

  UserApiModel.fromJson(Map<String, dynamic> json)
      : addresses = json['addresses'],
        artisanProfile = json['artisan_profile'],
        bookings = json['bookings'],
        cards = json['cards'],
        created_at = json['created_at'],
        email = json['email'],
        isArtisan = json['is_artisan'],
        isEmailVerified = json['is_email_verified'],
        name = json['name'],
        payments = json['payments'],
        ratings = json['ratings'],
        signUpDate = json['sign_up_dates'],
        telephone = json['telephone'],
        userId = json['user_id'];
}
