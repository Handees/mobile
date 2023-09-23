import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/shared/res/uri.dart';
import 'package:handees/shared/utils/utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

final customerSocketProvider = Provider((ref) => CustomerSocket._());

class CustomerSocket {
  CustomerSocket._() {
    socket.onConnect((_) => debugPrint('customer connected'));

    socket.onDisconnect((_) => debugPrint('client disconnected'));

    socket.onAny((event, data) {
      dPrint('Customer update any: Event($event) $data');
    });
  }
  // static final CustomerSockets _instance = CustomerSockets._();
  // static CustomerSockets get instance => _instance;

  final io.Socket socket = io.io(AppUris.customerSocketUri.toString(),
      io.OptionBuilder().setTransports(['websocket']).build());

  void connect() => socket.connect();

  void disconnect() => socket.disconnect();

  void cancelOffer(String bookingId) {
    socket.emit("cancel_offer", {"booking_id": bookingId});
  }

  void confirmJobDetails({
    required String bookingId,
    required bool isContract,
    required String settlementType,
    required double settlementAmount,
    required int duration,
    required String durationUnit,
  }) {
    socket.emit('confirm_job_details', {
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
    socket.emit("reject_job_details", {"booking_id": bookingId});
  }

  void onBookingOfferAccepted(void Function(dynamic) handler) {
    socket.on("booking_offer_accepted", handler);
  }

  void onOfferCancelled(void Function(dynamic) handler) {
    socket.on("offer_cancelled", handler);
  }

  void onApproveBookingDetails(void Function(dynamic) handler) {
    socket.on('approve_booking_details', handler);
  }

  void onArtisanArrived(void Function(dynamic) handler) {
    socket.on('artisan_arrived', handler);
  }

  void onJobAlreadyConfirmed(void Function(dynamic) handler) {
    socket.on('job_details_already_confirmed', handler);
  }

  void onError(void Function(dynamic) handler) {
    socket.on('error', handler);
  }
}
