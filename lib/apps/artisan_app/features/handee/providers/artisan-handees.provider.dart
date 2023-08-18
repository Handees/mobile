import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/shared/data/handees/handee.dart';
import 'package:handees/shared/utils/utils.dart';

final artisanHandeesProvider =
    StateNotifierProvider<ArtisanHandeesStateNotifier, List<Handee>>(
        (ref) => ArtisanHandeesStateNotifier());

class ArtisanHandeesStateNotifier extends StateNotifier<List<Handee>> {
  ArtisanHandeesStateNotifier() : super(generateHandeeList(20));
}
