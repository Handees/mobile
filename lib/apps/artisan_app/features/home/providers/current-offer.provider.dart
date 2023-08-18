import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/shared/data/handees/offer.dart';
import 'package:handees/shared/utils/utils.dart';

final currentOfferProvider =
    StateNotifierProvider<CurrentOfferStateNotifier, Offer>(
        (ref) => CurrentOfferStateNotifier());

class CurrentOfferStateNotifier extends StateNotifier<Offer>
    with InputValidationMixin {
  CurrentOfferStateNotifier() : super(Offer.empty());

  void changeOffer(Offer newOffer) {
    state = newOffer;
  }
}
