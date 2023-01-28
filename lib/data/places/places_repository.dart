import 'dart:convert';

import 'package:handees/data/places/place_model.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';

import 'package:handees/res/constants.dart';

class PlacesRepository {
  static PlacesRepository _instance = PlacesRepository._();
  PlacesRepository._();

  factory PlacesRepository() {
    return _instance;
  }

  /// Get Predictions based on the specified input
  Future<List<PlaceModel>> getPredictions(
      String input, String sessionToken) async {
    final request = Uri.https(
      AppConstants.mapsUrl,
      '/maps/api/place/autocomplete/json',
      {
        'input': input,
        // 'types': 'geocode', //necessary?
        'components': 'country:ng', //Localize?
        'key': AppConstants.kMapsApiKey,
        'sessionToken': sessionToken,
      },
    );

    final response = await http.get(request);

    final json = jsonDecode(response.body);

    //return list of prediction results
    final result = (json['predictions'] as List).map<PlaceModel>((e) {
      final model = PlaceModel.fromJson(e);
      print(model);

      return model;
    }).toList();

    return result;
  }

  Future<String> getLocation(String id, String sessionToken) async {
    final request = Uri.https(
      'maps.googleapis.com',
      '/maps/api/place/details/json',
      {
        'place_id': id,
        'fields': 'formatted_address,geometry',
        'key': AppConstants.kMapsApiKey,
        'sessionToken': sessionToken,
      },
    );

    final response = await http.get(request);

    final json = jsonDecode(response.body);
    print(json);

    //return list of prediction results
    final result = json['candidates'];

    return result.toString();
  }
}
