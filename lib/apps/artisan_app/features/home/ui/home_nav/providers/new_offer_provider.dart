import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final newOfferDialogProvider = StateNotifierProvider<NewOfferNotifier, NewOfferDialogueState>(
  (ref) => NewOfferNotifier()
);

class NewOfferNotifier extends StateNotifier<NewOfferDialogueState>
{
  NewOfferNotifier(): super(NewOfferDialogueState.open);

  void showNewOffer()
  {
    state = NewOfferDialogueState.open;
  }

  void closeNewOffer()
  {
    state = NewOfferDialogueState.close;
  }
}

enum NewOfferDialogueState { open, close }


final bookingStateProvider = StateNotifierProvider<BookingStateNotifier, BookingState>(
  (ref) => BookingStateNotifier()
);


class BookingStateNotifier extends StateNotifier<BookingState>
{
  BookingStateNotifier(): super(BookingState.detached);

  void attachToBooking()
  {
    state = BookingState.attached;
  }

  void detachFromBooking()
  {
    state = BookingState.detached;
  }
}

enum BookingState { attached, detached }