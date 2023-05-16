import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:handees/res/uri.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ArtisanSocket {
  ArtisanSocket._() {
    artisanSocket.onConnect((_) => debugPrint('Artisan Connected'));
    artisanSocket.onDisconnect((_) => debugPrint('Artisan disconnected'));
    artisanSocket.onConnectError((err) => debugPrint(err));
    artisanSocket.onError((err) => debugPrint(err));
    print("Did this");
    artisanSocket.onAny((event, data) {
      print('Artisan update any: Event($event) $data');
    });
  }
  static final ArtisanSocket _instance = ArtisanSocket._();
  static ArtisanSocket get instance => _instance;

  io.Socket artisanSocket = io.io(AppUris.artisanSocketUri.toString(),
      io.OptionBuilder().setTransports(['websocket']).build());

  void connectArtisan() => artisanSocket.connect();
  void disconnectArtisan() => artisanSocket.disconnect();
  Stream<T> onArtisanEvent<T>(String event) {
    if (artisanSocket.disconnected) throw const SocketException.closed();

    final controller = StreamController<T>();

    artisanSocket.on(event, (data) {
      print(data);
      controller.add(data);
    });

    return controller.stream;
  }
}
