import 'package:flutter_riverpod/flutter_riverpod.dart';


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