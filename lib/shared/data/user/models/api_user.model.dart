import 'package:flutter/foundation.dart';
import 'package:handees/shared/data/user/models/artisan.model.dart';

@immutable
class ApiUserModel {
  final ArtisanModel? artisanProfile;
  final DateTime createdAt;
  final String email;
  final bool isArtisan;
  final bool isEmailVerified;
  final String name;
  final DateTime signupDate;
  final String telephone;
  final String userId;

  ApiUserModel.fromJson(Map<String, dynamic> json)
      : artisanProfile = json['artisan_profile'] != null
            ? ArtisanModel.fromJson(json['artisan_profile'])
            : null,
        createdAt = DateTime.parse(json['created_at']),
        email = json['email'],
        isArtisan = json['is_artisan'],
        isEmailVerified = json['is_email_verified'],
        name = json['name'],
        signupDate = DateTime.parse(json['sign_up_date']),
        telephone = json['telephone'] ?? '',
        userId = json['user_id'];

  ApiUserModel.empty()
      : artisanProfile = null,
        createdAt = DateTime.now(),
        email = "",
        isArtisan = false,
        isEmailVerified = false,
        name = "",
        signupDate = DateTime.now(),
        telephone = "",
        userId = "";
}
