import 'package:handees/res/uri.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class AppSockets {
  AppSockets._() {
    print('try connect');
    customerSocket.connect();
    chatSocket.connect();

    customerSocket.onConnect((_) {
      print('customer connected');
    });
    chatSocket.onConnect((_) {
      print('Chat connected');
    });
    // socket.on('event', (data) => print('Event $data'));
    customerSocket.onDisconnect((_) => print('client disconnected'));
    chatSocket.onDisconnect((_) => print('Chat disconnected'));

    customerSocket.on('msg', (data) {
      print('Customer update: $data');
    });

    chatSocket.on('msg', (data) {
      print('Chat update: $data');
    });
  }

  io.Socket customerSocket = io.io(AppUris.customerSocketUri.toString(),
      io.OptionBuilder().setTransports(['websocket']).build());

  io.Socket chatSocket = io.io(AppUris.chatSocketUri.toString(),
      io.OptionBuilder().setTransports(['websocket']).build());
}
