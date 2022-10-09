import 'package:auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/customer_app/services/auth_service.dart';
import 'package:handees/customer_app/services/places_service.dart';
import 'package:handees/utils/utils.dart';

final locationProvider =
    StateNotifierProvider<LocationNotifier, List<String>>((ref) {
  // final placesService = ref.watch(placeServiceProvider);
  return LocationNotifier();
});

class LocationNotifier extends StateNotifier<List<String>> {
  LocationNotifier() : super([]);

  final placesService = PlacesService.instance;

  void getSuggestions(String query) async {
    state = await placesService.getPredictions(query);
  }
}
