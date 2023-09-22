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

  const ApiUserModel(
      {required this.createdAt,
      required this.email,
      required this.isArtisan,
      required this.isEmailVerified,
      required this.firstName,
      required this.lastName,
      required this.signupDate,
      required this.telephone,
      required this.userId,
      required this.address,
      this.artisanProfile});

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

  ApiUserModel copyWith(
      {ArtisanModel? artisanProfile,
      DateTime? createdAt,
      String? email,
      bool? isArtisan,
      bool? isEmailVerified,
      String? firstName,
      String? lastName,
      DateTime? signupDate,
      String? telephone,
      String? userId,
      String? address}) {
    return ApiUserModel(
      artisanProfile: artisanProfile ?? this.artisanProfile,
      createdAt: createdAt ?? this.createdAt,
      address: address ?? this.address,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      isArtisan: isArtisan ?? this.isArtisan,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      lastName: lastName ?? this.lastName,
      signupDate: signupDate ?? this.signupDate,
      telephone: telephone ?? this.telephone,
      userId: userId ?? this.userId,
    );
  }

  String getName() {
    return '$firstName $lastName';
  }
}
