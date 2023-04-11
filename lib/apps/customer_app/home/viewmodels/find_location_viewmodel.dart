import 'package:flutter/foundation.dart';
import 'package:handees/data/places/place_model.dart';
import 'package:handees/services/places_service.dart';

class FindLocationViewModel extends ChangeNotifier {
  FindLocationViewModel(this.placesService);

  final PlacesService placesService;

  List<PlaceModel> _suggestions = [];
  List<PlaceModel> get suggestions => _suggestions;

  void getSuggestions(String query) async {
    _suggestions = await placesService.getPredictions(query);
    print('Them suggest is $suggestions');
    notifyListeners();
  }

  void getLocation(String id) async {
    await placesService.getLocation(id);
  }
}
