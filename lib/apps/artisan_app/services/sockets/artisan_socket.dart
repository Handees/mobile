import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/artisan_app/features/home/providers/home.artisan.provider.dart';
import 'package:handees/apps/artisan_app/services/sockets/artisan_socket_events.dart';
import 'package:handees/shared/res/uri.dart';
import 'package:handees/shared/services/auth_service.dart';
import 'package:handees/shared/utils/utils.dart';
import 'package:location/location.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

final artisanSocketProvider =
    StateNotifierProvider<ArtisanSocketNotifier, io.Socket>(
        (ref) => ArtisanSocketNotifier(ref));

class ArtisanSocketNotifier extends StateNotifier<io.Socket>
    with InputValidationMixin {
  StateNotifierProviderRef<ArtisanSocketNotifier, io.Socket> ref;

  ArtisanSocketNotifier(this.ref)
      : super(io.io(
          AppUris.artisanSocketUri.toString(),
          io.OptionBuilder()
              .setTransports(['websocket'])
              .setAuth({"access_token": AuthService.instance.token})
              .disableAutoConnect()
              .build(),
        )) {
    state.onAny((event, data) {
      dPrint('Artisan update any: Event($event) $data');
    });
    state.onDisconnect((_) => dPrint("Socket Disconnected"));
    state.onConnect((_) async {
      dPrint("Socket Connected");

      // When socket first connects, immediately send the user's current location

      final location = ref.read(locationProvider);
      updateArtisanLocation(location);
    });
  }

  void connectArtisan() => state.connect();
  void disconnectArtisan() => state.disconnect();

  void updateArtisanLocation(LocationData location) {
    dPrint(
        "lat:${location.latitude} , lon:${location.longitude} emitted through sockets");
    state.emit(
      ArtisanSocketEvents.locationUpdate,
      {
        "lat": location.latitude,
        "lon": location.longitude,
        "artisan_id": AuthService.instance.user.uid,
        "job_category": "carpentary",
      },
    );
  }

  Stream<T> onArtisanEvent<T>(String event) {
    if (state.disconnected) throw const SocketException.closed();

    final controller = StreamController<T>();

    state.on(event, (data) {
      dPrint(data);
      controller.add(data);
    });

    return controller.stream;
  }
}
