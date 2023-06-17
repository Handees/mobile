import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:handees/shared/res/uri.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class AppSockets {
  AppSockets._() {
    customerSocket.onConnect((_) => debugPrint('customer connected'));
    chatSocket.onConnect((_) => debugPrint('Chat connected'));
    // socket.on('event', (data) => print('Event $data'));
    customerSocket.onDisconnect((_) => debugPrint('client disconnected'));
    chatSocket.onDisconnect((_) => debugPrint('Chat disconnected'));

    customerSocket.onAny((event, data) {
      print('Customer update any: Event($event) $data');
    });

    chatSocket.onAny((event, data) {
      print('Chat update any: Event($event) $data');
    });
  }
  static final AppSockets _instance = AppSockets._();
  static AppSockets get instance => _instance;

  io.Socket customerSocket = io.io(AppUris.customerSocketUri.toString(),
      io.OptionBuilder().setTransports(['websocket']).build());

  io.Socket chatSocket = io.io(AppUris.chatSocketUri.toString(),
      io.OptionBuilder().setTransports(['websocket']).build());

  void disconnectAll() {
    chatSocket.disconnect();
    customerSocket.disconnect();
  }

  //TODO: Needed?
  // void connectChat() => chatSocket.connect();
  // void disconnectChat() => chatSocket.disconnect();
  // void emitChatEvent(String event, dynamic data) {
  //   if (chatSocket.disconnected) throw const SocketException.closed();
  //   chatSocket.emit(event, data);
  // }

  // void connectCustomer() => customerSocket.connect();
  // void disconnectCustomer() => customerSocket.connect();
}
