import 'dart:convert';
import 'dart:io';

import 'package:handees/shared/data/user/models/api_user.model.dart';
import 'package:handees/shared/res/uri.dart';

import 'package:http/http.dart' as http;

class UserRemoteDataSource {
  Future<ApiUserModel> fetchUserData(String token) async {
    final response = await http.get(AppUris.userDataUri, headers: {
      'access-token': token,
    });

    print('fetchUserData response ${response.body}');
    print('fetchUserData code ${response.statusCode}');

    switch (response.statusCode) {
      case 200:
        final decodedJson = jsonDecode(response.body);
        return ApiUserModel.fromJson(decodedJson['data']);
      case 404:
        throw 'User not found';
      default:
        throw Exception('fetchUserData get error: ${response.statusCode} ');
    }
  }

  Future<bool> submitArtisanData({
    required String uid,
    required int hourlyRate,
    required String jobCategory,
    required String jobTitle,
    required String token,
  }) async {
    final future = http.post(AppUris.addNewArtisanUri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'access-token': token,
        },
        body: jsonEncode({
          "user_profile_id": uid,
          "hourly_rate": hourlyRate,
          "job_category": jobCategory,
          "job_title": jobTitle,
        }));
    print(AppUris.addNewArtisanUri);
    print(token);
    print({
      "user_profile_id": uid,
      "hourly_rate": hourlyRate,
      "job_category": jobCategory,
      "job_title": jobTitle,
    });
    late final http.Response response;
    try {
      response = await future;
    } catch (e) {
      print(e);
      return false;
    }

    print('submitArtisanData response ${response.body}');
    print('submitArtisanData code ${response.statusCode}');

    if (response.statusCode >= 200 && response.statusCode < 400) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> submitUserData({
    required String name,
    required String phone,
    required String email,
    required String uid,
    required String token,
  }) async {
    final future = http.post(
      AppUris.addNewUserUri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'access-token': token,
      },
      body: jsonEncode(
        {
          'name': name,
          'telephone': phone,
          'email': email,
          'user_id': uid,
        },
      ),
    );

    final response = await future;
    print("Submit user data response ${response.body}");

    print("Submit user data response code ${response.statusCode}");

    //TODO: Error handling
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateUserData({
    required String name,
    required String phone,
    required String email,
    required String uid,
    required String token,
  }) async {
    final future = http.patch(
      AppUris.addNewUserUri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'access-token': token,
      },
      body: jsonEncode(
        {
          'name': name,
          'telephone': phone,
          'email': email,
          'user_id': uid,
        },
      ),
    );

    final response = await future;
    print("Patch user data response ${response.body}");

    print("Patch user data response code ${response.statusCode}");

    //TODO: Error handling
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> getArtisanData(String token) async {
    final future = http.get(AppUris.addNewUserUri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'access-token': token,
    });

    final response = await future;
    print("Get artisan data response ${response.body}");

    print("Get artisan data response code ${response.statusCode}");

    //TODO: Error handling
    if (response.statusCode > 200 && response.statusCode < 400) {
      return true;
    } else {
      return false;
    }
  }
}
