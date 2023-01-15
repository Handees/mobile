import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/customer_app/features/home/models/place_model.dart';
import 'package:handees/customer_app/services/places_service.dart';

final suggestionsProvider =
    StateNotifierProvider<SuggestionsNotifier, List<PlaceModel>>((ref) {
  return SuggestionsNotifier();
});

class SuggestionsNotifier extends StateNotifier<List<PlaceModel>> {
  SuggestionsNotifier() : super([]);

  final placesService = PlacesService.instance;

  void getSuggestions(String query) async {
    state = await placesService.getPredictions(query);
  }

  void getLoc(String id) async {
    await placesService.getLocation(id);
  }
}
