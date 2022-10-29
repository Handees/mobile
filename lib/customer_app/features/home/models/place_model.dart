import 'package:flutter/foundation.dart';

@immutable
class PlaceModel {
  final String id;
  final String description;
  final List<dynamic> types;

  const PlaceModel({
    required this.id,
    required this.description,
    required this.types,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['place_id'],
      description: json['description'],
      types: json['types'],
    );
  }

  @override
  String toString() {
    return "[description: $description, id: $id, types: $types]";
  }
}
