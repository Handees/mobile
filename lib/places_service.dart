import 'package:http/http.dart';
import 'dart:convert';

const kMapsApiKey = 'AIzaSyA3NoblRziyftfiaqUmF5X1BYURfknrzV0';

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  final apiKey = kMapsApiKey;

  Future<List<String>> fetchSuggestions(String input) async {

    final request = Uri.https(
      'maps.googleapis.com',
      '/maps/api/place/autocomplete/json',
      {
        'input' : input,//"$input",
        'types' : 'address',
        //'language' : lang,
        //'components': 'country:ch',
        'key':apiKey,
        'sessionToken': sessionToken,
      },
    );
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<String>((p) => p['description']);
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
