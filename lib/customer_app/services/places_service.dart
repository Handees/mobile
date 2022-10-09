import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/customer_app/services/auth_service.dart';
import 'package:http/http.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:uuid/uuid.dart';

const kMapsApiKey = 'AIzaSyARglR29MXnF774yULbD_4h3xYBj0vIHfk';

// final placeServiceProvider =
//     Provider<PlacesService>((ref) => PlacesService._());

class PlacesService {
  PlacesService._();
  static final PlacesService _instance = PlacesService._();
  static PlacesService get instance => _instance;

  final sessionToken = const Uuid().v4();
  final geolocatorInstance = GeolocatorPlatform.instance;
  // final geocodingInstance = GeocodingPlatform.instance;
  bool serviceEnabled = false;

  /// Get Predictions based on the specified input
  Future<List<String>> getPredictions(String input) async {
    final request = Uri.https(
      'maps.googleapis.com',
      '/maps/api/place/autocomplete/json',
      {
        'input': input,
        'types': 'geocode',
        'components': 'country:ng', //Localize?
        'key': kMapsApiKey,
        'sessionToken': sessionToken,
      },
    );

    final response = await get(request);

    final json = jsonDecode(response.body);

    //return list of prediction results
    final result = (json['predictions'] as List)
        .map<String>((e) => e['description'])
        .toList();

    return result;
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await geolocatorInstance.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await geolocatorInstance.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await geolocatorInstance.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await geolocatorInstance.getCurrentPosition();
  }

  // Future<String> getAddress(Position position) async {
  //   final res = await geocodingInstance.placemarkFromCoordinates(
  //       position.latitude, position.longitude);
  //   final address = res[0].street;

  //   return address!;
  // }

  // Future<Location> getCoordinates(String address) async {
  //   final res = await geocodingInstance.locationFromAddress(address);

  //   return res[0];
  // }
}
