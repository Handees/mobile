import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/data/places/place_model.dart';
import 'package:handees/apps/customer_app/services/places_service.dart';

final suggestionsProvider =
    StateNotifierProvider<SuggestionsNotifier, List<PlaceModel>>((ref) {
  return SuggestionsNotifier(ref.watch(placesServiceProvider));
});

class SuggestionsNotifier extends StateNotifier<List<PlaceModel>> {
  SuggestionsNotifier(this.placesService) : super([]);

  final placesService;

  void getSuggestions(String query) async {
    state = await placesService.getPredictions(query);
  }

  void getLoc(String id) async {
    await placesService.getLocation(id);
  }
}