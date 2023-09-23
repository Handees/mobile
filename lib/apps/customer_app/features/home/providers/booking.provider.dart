import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/artisan_app/features/home/providers/artisan-location.provider.dart';
import 'package:handees/apps/customer_app/services/booking_service.customer.dart';
import 'package:handees/shared/data/handees/job_category.dart';
import 'package:location/location.dart';

class BookingProvider extends StateNotifier<BookingState> {
  final BookingService _bookingService;
  final FirebaseAuth _auth;
  final LocationStateNotifier _location;

  BookingProvider(this._auth, this._bookingService, this._location)
      : super(BookingState.idle) {
    _location.initLocation();
  }

  Future<String> bookService({
    required JobCategory category,
    required void Function(String bookingId) onBooked,
  }) async {
    final token = await _auth.currentUser!.getIdToken();
    final location = await _location.location.getLocation();

    return await _bookingService.bookService(
      token: token,
      lat: location.latitude!,
      lon: location.longitude!,
      category: category,
    );
  }
}

enum BookingState { idle, loading }
