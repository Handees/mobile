import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handees/res/constants.dart';
import 'package:handees/res/uri.dart';
import 'package:handees/shared/widgets/utils.dart';
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
  late String token;

// Dart client
  io.Socket customerSocket = io.io(AppUris.customerSocketUri.toString(),
      io.OptionBuilder().setTransports(['websocket']).build());

  io.Socket chatSocket = io.io(AppUris.chatSocketUri.toString(),
      io.OptionBuilder().setTransports(['websocket']).build());

  String? bookingId;
  String? artisanId;

  @override
  void initState() {
    print("Uri is ${AppUris.customerSocketUri.toString()}");

    FirebaseAuth.instance.currentUser!
        .getIdToken()
        .then((value) => token = value);

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

      artisanId = data['artisan_id'];
    });

    chatSocket.on('msg', (data) {
      print('Chat update: $data');
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
                customerSocket.emit('close_offer', {
                  {'booking_id': '9f04dd34-0c9a-48d6-b7a1-d00ab3e12536'}
                });
                print('Close');
              },
              child: Ink(
                height: 80,
                width: 80,
                color: Colors.blue,
              ),
            ),
            InkWell(
              onTap: () async {
                print('submitting');
                final future = http.post(
                  Uri.http(
                    site,
                    '/api/bookings/',
                  ),
                  headers: {
                    HttpHeaders.contentTypeHeader: 'application/json',
                    'access-token': token,
                  },
                  body: jsonEncode(
                    {
                      'lat': 6.517871336509268,
                      'lon': 3.399740067230001,
                      'user_id': FirebaseAuth.instance.currentUser!.uid,
                      'job_category': 'carpentary',
                    },
                  ),
                );

                final response = await future;
                print(response.body);

                final json = jsonDecode(response.body);
                bookingId = json['data']['booking_id'];

                customerSocket.emit('booking_update', {
                  {'booking_id': bookingId}
                });
                print(bookingId);
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
              onSubmitted: (_) {
                FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: _,
                  verificationCompleted: (phoneAuthCredential) {},
                  verificationFailed: (error) {},
                  codeSent: (verificationId, forceResendingToken) {},
                  codeAutoRetrievalTimeout: (verificationId) {},
                );

                showHandeeDialog(
                  context,
                  title: 'Your handee has been completed!',
                  subtitle: 'Kindly confirm the status of your handee',
                  positiveButtonText: 'Completed',
                  onPositiveButton: () {},
                  negativeButtonText: 'Incomplete',
                );
              },
            ),
            InkWell(
              onTap: () async {
                // print(token);
                // final loc = await PlacesService.instance.determinePosition();
                final future = http.get(
                  Uri.https(
                    site,
                    '/user/bookings',
                  ),
                  headers: {
                    // HttpHeaders.contentTypeHeader: 'application/json',
                    'access-token': token,
                  },
                );

                final response = await future;
                print(response.body);
              },
              child: Ink(
                height: 80,
                width: 80,
                color: Colors.brown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
