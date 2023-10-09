import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/shared/res/uri.dart';
import 'package:handees/shared/services/auth_service.dart';
import 'package:handees/shared/utils/utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

final customerSocketProvider =
    Provider((ref) => CustomerSocket._(AuthService.instance));

class CustomerSocket {
  CustomerSocket._(this._authService) {
    _socket.onConnect((_) => debugPrint('customer connected'));

    _socket.onDisconnect((_) => debugPrint('customer disconnected'));

    _socket.onAny((event, data) {
      dPrint('Customer update any: Event($event) $data');
    });
  }
  // static final CustomerSockets _instance = CustomerSockets._();
  // static CustomerSockets get instance => _instance;
  final AuthService _authService;

  late io.Socket _socket = io.io(
    AppUris.customerSocketUri.toString(),
    io.OptionBuilder()
        .setAuth({'access_token': _authService.token}).setTransports(
            ['websocket']).build(),
  );

  void connect() => _socket.connect();

  void disconnect() => _socket.disconnect();

  void cancelOffer(String bookingId) {
    _socket.emit("cancel_offer", {"booking_id": bookingId});
  }

  void confirmJobDetails({
    required String bookingId,
    required bool isContract,
    required String settlementType,
    required double settlementAmount,
    required int duration,
    required String durationUnit,
  }) {
    _socket.emit('confirm_job_details', {
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

  void rejectJobDetails(String bookingId) {
    _socket.emit("reject_job_details", {"booking_id": bookingId});
  }

  void onBookingOfferAccepted(void Function(dynamic) handler) {
    _socket.on("booking_offer_accepted", handler);
  }

  void onOfferCancelled(void Function(dynamic) handler) {
    _socket.on("offer_cancelled", handler);
  }

  void onApproveBookingDetails(void Function(dynamic) handler) {
    _socket.on('approve_booking_details', handler);
  }

  void onArtisanArrived(void Function(dynamic) handler) {
    _socket.on('artisan_arrived', handler);
  }

  void onJobAlreadyConfirmed(void Function(dynamic) handler) {
    _socket.on('job_details_already_confirmed', handler);
  }

  void onError(void Function(dynamic) handler) {
    _socket.on('error', handler);
  }
}
