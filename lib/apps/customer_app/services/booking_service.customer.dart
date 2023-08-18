import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:handees/apps/customer_app/services/sockets/sockets.dart';
import 'package:handees/shared/data/handees/job_category.dart';
import 'package:handees/shared/res/constants.dart';

import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as io;

class BookingService {
  static final instance = BookingService._(AppSockets.instance);

  BookingService._(this._sockets) {}

  final AppSockets _sockets;

  void bookService({
    required String token,
    required double lat,
    required double lon,
    required JobCategory category,
    required void Function(String bookingId) onBooked,
  }) async {
    final future = http.post(
      Uri.http(
        AppConstants.url,
        '/api/bookings/',
      ),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'access-token': token,
      },
      body: jsonEncode(
        {
          'lat': lat,
          'lon': lon,
          // 'user_id': FirebaseAuth.instance.currentUser!.uid,
          'job_category': category.id,
        },
      ),
    );

    final response = await future;
    print(response.body);

    final json = jsonDecode(response.body);
    final bookingId = json['data']['booking_id'];
    onBooked(bookingId);
  }

  void cancelOffer(String bookingId) {
    _sockets.customerSocket.emit('cancel_offer', {'booking_id': bookingId});
  }

  void confirmJobDetails({
    required String bookingId,
    required bool isContract,
    required String settlementType,
    required double settlementAmount,
    required int duration,
    required String durationUnit,
  }) {
    print('Sbmitting');
    _sockets.customerSocket.emit('confirm_job_details', {
      'booking_id': bookingId,
      'is_contract': isContract,
      'settlement': {
        'type': settlementType,
        'amount': settlementAmount,
      },
      'duration': duration,
      'duration_unit': durationUnit,
    });
  }

  void rejectJobDetails() {
    _sockets.customerSocket.emit('reject_job_details');
  }

  //TODO shouldn't be dynamic
  getBookings(String token) async {
    final response = await http.get(
      Uri.https(
        AppConstants.url,
        '/user/bookings',
      ),
      headers: {
        // HttpHeaders.contentTypeHeader: 'application/json',
        'access-token': token,
      },
    );
  }
}
