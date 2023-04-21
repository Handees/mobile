import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:handees/data/user/models/user_api_model.dart';
import 'package:handees/res/uri.dart';

import 'package:http/http.dart' as http;

class UserRemoteDataSource {
  Future<UserApiModel> fetchUserData(String uid) async {
    final response = await http.get(
      AppUris.userDataUri(uid),
    );

    print('UserRemoteDataSource response ${response.body}');
    print('UserRemoteDataSource code ${response.statusCode}');

    switch (response.statusCode) {
      case 200:
        final decodedJson = jsonDecode(response.body);
        return UserApiModel.fromJson(decodedJson['data']);
      default:
        throw Exception(
            'UserRemoteDataSource get error: ${response.statusCode} ');
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
          // 'telephone': phone,
          'email': email,
          'user_id': uid,
        },
      ),
    );

    final response = await future;
    print("Submit user data response ${response.body}");

    print("Submit user data response code ${response.statusCode}");

    //TODO: Error handling
    if (response.statusCode > 200 && response.statusCode < 400) {
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
