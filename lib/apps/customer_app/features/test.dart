import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handees/apps/customer_app/services/booking_service.customer.dart';
import 'package:handees/shared/res/constants.dart';
import 'package:handees/shared/res/uri.dart';
import 'package:handees/shared/services/auth_service.dart';
import 'package:handees/shared/ui/widgets/handee_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as io;

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  // Future<void> submit() async {

  final site = AppConstants.url;
  // late String token;

  io.Socket rootSocket = io.io(
    AppUris.rootUri.toString(),
    io.OptionBuilder()
        .setAuth({'access_token': AuthService.instance.token}).setTransports(
            ['websocket']).build(),
  );

// Dart client
  // io.Socket customerSocket = io.io(
  //   AppUris.customerSocketUri.toString(),
  //   io.OptionBuilder().setTransports(
  //       ['websocket']).build(),
  // );

  io.Socket chatSocket = io.io(AppUris.chatSocketUri.toString(),
      io.OptionBuilder().setTransports(['websocket']).build());

  final customerSocket = io.io(
    AppUris.customerSocketUri.toString(),
    io.OptionBuilder()
        .setAuth({'access_token': AuthService.instance.token}).setTransports(
            ['websocket']).build(),
  );

  String? bookingId;
  String? artisanId;

  @override
  void initState() {
    print("Uri is ${AppUris.customerSocketUri.toString()}");

    customerSocket.connect();

    customerSocket.onAny((event, data) {
      print('Customer update hany: Event($event) $data');
    });

    // rootSocket.connect();
    rootSocket.onAny((event, data) {
      print('Root update any: Event($event) $data');
    });

    print('try connect');

    chatSocket.connect();

    // customerSocket.onConnect((_) {
    //   print('customer connected');
    // });
    // chatSocket.onConnect((_) {
    //   print('Chat connected');
    // });
    // socket.on('event', (data) => print('Event $data'));
    // customerSocket.onDisconnect((_) => print('client disconnected'));
    chatSocket.onDisconnect((_) => print('Chat disconnected'));

    // customerSocket.on('msg', (data) {
    //   print('Customer update: $data');

    //   // artisanId = data['artisan_id'];
    // });

    chatSocket.on('msg', (data) {
      print('Chat update: $data');
    });

    chatSocket.onAny((event, data) {
      print('Chat update any: Event($event) $data');
    });

    super.initState();
  }

  late String vId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          runSpacing: 20,
          spacing: 20,
          children: [
            InkWell(
              onTap: () {
                // customerSocket.emit('close_offer', {
                //   {'booking_id': '9f04dd34-0c9a-48d6-b7a1-d00ab3e12536'}
                // });
                // print('Close');
              },
              child: Ink(
                height: 80,
                width: 80,
                color: Colors.blue,
              ),
            ),
            InkWell(
              onTap: () async {
                BookingService.instance.bookService(
                  token: AuthService.instance.token,
                  onBooked: (bookingId) {
                    print(bookingId);

                    chatSocket.emit('join_chat', {'booking_id': bookingId});
                    print('joined_chat');
                  },
                );
              },
              child: Ink(
                height: 80,
                width: 80,
                color: Colors.purple,
              ),
            ),
            TextField(
              onTap: () {
                showSucessSnackBar(context);
              },
              onSubmitted: (value) {
                chatSocket.emit('msg', {'msg': value, 'booking_id': bookingId});
                print('Sent $value to $bookingId');
              },
            ),
          ],
        ),
      ),
    );
  }
}
