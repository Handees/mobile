import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/customer_app/services/booking_service.customer.dart';
import 'package:handees/shared/data/handees/job_category.dart';
import 'package:location/location.dart';

final bookingProvider = StateNotifierProvider<BookingNotifier, BookingState>(
    (ref) => BookingNotifier(
          FirebaseAuth.instance,
          ref.watch(bookingServiceProvider),
          Location.instance,
        ));

class BookingNotifier extends StateNotifier<BookingState> {
  final BookingService _bookingService;
  final FirebaseAuth _auth;
  final Location _location;

  BookingNotifier(this._auth, this._bookingService, this._location)
      : super(BookingState.idle) {}

  void init() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<String> bookService({
    required JobCategory category,
  }) async {
    final token = await _auth.currentUser!.getIdToken();
    final location = await _location.getLocation();

    return await _bookingService.bookService(
      token: token,
      lat: location.latitude!,
      lon: location.longitude!,
      category: category,
    );
  }
}

enum BookingState { idle, loading }
