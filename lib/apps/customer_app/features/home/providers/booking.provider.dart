import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/customer_app/services/booking_service.customer.dart';
import 'package:handees/apps/customer_app/services/sockets/customer_socket.dart';
import 'package:handees/shared/data/handees/job_category.dart';
import 'package:location/location.dart';

final bookingProvider = StateNotifierProvider<BookingNotifier, BookingState>(
    (ref) => BookingNotifier(
        FirebaseAuth.instance,
        ref.watch(bookingServiceProvider),
        Location.instance,
        ref.watch(customerSocketProvider)));

class BookingNotifier extends StateNotifier<BookingState> {
  final BookingService _bookingService;
  final FirebaseAuth _auth;
  final Location _location;
  final CustomerSocket _socket;

  late JobCategory _category;
  JobCategory get category => _category;

  BookingNotifier(
      this._auth, this._bookingService, this._location, this._socket)
      : super(BookingState.idle) {
    _socket.connect();
    _socket.onBookingOfferAccepted((event) {
      state = BookingState.inProgress;
    });
    _socket.onArtisanArrived((event) {
      state = BookingState.arrived;
    });
    // _socket.onApproveBookingDetails((p0) { })
  }

  @override
  void dispose() {
    _socket.disconnect();
    super.dispose();
  }

  void init() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<String> bookService({
    required JobCategory category,
  }) async {
    state = BookingState.loading;
    _category = category;

    final token = await _auth.currentUser!.getIdToken();
    final location = await _location.getLocation();

    return await _bookingService.bookService(
      token: token,
      // lat: location.latitude!,
      // lon: location.longitude!,
      lat: 6.548281268456966,
      lon: 3.332248000980724,
      category: category,
    );
  }
}

enum BookingState { idle, loading, foundArtisan, inProgress, arrived, done }
