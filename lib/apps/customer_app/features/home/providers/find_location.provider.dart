import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/shared/data/places/place_model.dart';
import 'package:handees/shared/services/places_service.dart';

final findLocationProvider =
    StateNotifierProvider<FindLocationStateNotifier, List<PlaceModel>>(
        (ref) => FindLocationStateNotifier(PlacesService.instance));

class FindLocationStateNotifier extends StateNotifier<List<PlaceModel>> {
  final PlacesService _placesService;
  FindLocationStateNotifier(this._placesService) : super([]);

  List<PlaceModel> _suggestions = [];
  List<PlaceModel> get suggestions => _suggestions;

  void getSuggestions(String query) async {
    _suggestions = await _placesService.getPredictions(query);
  }

  void getLocation(String id) async {
    await _placesService.getLocation();
  }
}
