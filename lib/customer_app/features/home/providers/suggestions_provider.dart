import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/customer_app/services/places_service.dart';

final suggestionsProvider =
    StateNotifierProvider<SuggestionsNotifier, List<String>>((ref) {
  // final placesService = ref.watch(placeServiceProvider);
  return SuggestionsNotifier();
});

class SuggestionsNotifier extends StateNotifier<List<String>> {
  SuggestionsNotifier() : super([]);

  final placesService = PlacesService.instance;

  void getSuggestions(String query) async {
    state = await placesService.getPredictions(query);
  }
}
