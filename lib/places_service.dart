import 'dart:convert';

import 'package:http/http.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

const kMapsApiKey = 'AIzaSyA3NoblRziyftfiaqUmF5X1BYURfknrzV0';

class PlacesService {
  /// Get Predictions based on the specified input
  Future<List<String>> getPredictions(String input) async {
    final request = Uri.https(
      'maps.googleapis.com',
      '/maps/api/place/autocomplete/json',
      {
        'input': input, //"$input",
        'types': 'geocode', //TODO: try address
        //'language' : lang,
        //'components': 'country:ch',
        'key': kMapsApiKey,
        //'sessionToken': sessionToken, //TODO: put token
      },
    );

    final response = await get(request);

    final json = jsonDecode(response.body);

    //return list of prediction results
    final result = (json['predictions'] as List)
        .map<String>((e) => e['description'])
        .toList();

    //print(json);
    print(result);

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
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
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
    return await Geolocator.getCurrentPosition();
  }

  Future<String> getAddress(Position position) async {
    final res = await GeocodingPlatform.instance
        .placemarkFromCoordinates(position.latitude, position.longitude);
    print(res);
    final address = res[0].street;

    return address!;
  }
}
