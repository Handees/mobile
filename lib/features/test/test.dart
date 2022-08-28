import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  Future<void> submit() async {
    // final loc = await PlacesService.instance.determinePosition();
    final future = http.post(
      Uri.https(
        '49c7-102-89-32-36.ngrok.io',
        '/bookings/',
      ),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(
        {
          "lat": 6.517871336509268,
          "lon": 3.399740067230001,
          "user_id": "jksdhfuihewuiohio2",
        },
      ),
    );

    final response = await future;
    print(response.body);
    // setState(() {
    //   status = Status.submitting;
    // });
    // await Future.delayed(const Duration(seconds: 1));
    // setState(() {
    //   status = Status.failed;
    // });
  }

// Dart client
  IO.Socket socket = IO.io('https://49c7-102-89-32-36.ngrok.io/',
      IO.OptionBuilder().setTransports(['websocket']).build());

  @override
  void initState() {
    socket.connect();

    socket.onConnect((_) {
      print('connect');
    });
    // socket.on('event', (data) => print("Event $data"));
    socket.onDisconnect((_) => print('client disconnect'));

    socket.on('msg', (data) => print('Offer $data'));

    super.initState();
  }

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
                socket.emit('close_offer', {
                  {"booking_id": "9f04dd34-0c9a-48d6-b7a1-d00ab3e12536"}
                });
                print('Close');
              },
              child: Container(
                height: 80,
                width: 80,
                color: Colors.blue,
              ),
            ),
            InkWell(
              onTap: () {
                socket.emit('booking_update', {
                  {"booking_id": "9f04dd34-0c9a-48d6-b7a1-d00ab3e12536"}
                });
                print('Update');
              },
              child: Container(
                height: 80,
                width: 80,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
