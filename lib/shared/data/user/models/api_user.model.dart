import 'package:flutter/foundation.dart';
import 'package:handees/shared/data/user/models/artisan.model.dart';

@immutable
class ApiUserModel {
  final ArtisanModel? artisanProfile;
  final DateTime createdAt;
  final String email;
  final bool isArtisan;
  final bool isEmailVerified;
  final String firstName;
  final String lastName;
  final DateTime signupDate;
  final String telephone;
  final String userId;
  final String address;

  ApiUserModel.fromJson(Map<String, dynamic> json)
      : artisanProfile = json['artisan_profile'] != null
            ? ArtisanModel.fromJson(json['artisan_profile'])
            : null,
        createdAt = DateTime.parse(json['created_at']),
        email = json['email'],
        isArtisan = json['is_artisan'],
        isEmailVerified = json['is_email_verified'],
        firstName = json['first_name'] ?? 'Curious',
        lastName = json['last_name'] ?? 'Paul',
        signupDate = DateTime.parse(json['sign_up_date']),
        telephone = json['telephone'] ?? '',
        userId = json['user_id'],
        address = json['address'] ?? '';

  ApiUserModel.empty()
      : artisanProfile = null,
        createdAt = DateTime.now(),
        email = "",
        isArtisan = false,
        isEmailVerified = false,
        firstName = "",
        lastName = '',
        signupDate = DateTime.now(),
        telephone = "",
        userId = "",
        address = '';

  String getName() {
    return '$firstName $lastName';
  }
}
