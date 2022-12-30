import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handees/res/constants.dart';
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
  //   // final loc = await PlacesService.instance.determinePosition();
  //   final future = http.post(
  //     Uri.https(
  //       '49c7-102-89-32-36.ngrok.io',
  //       '/bookings/',
  //     ),
  //     headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  //     body: jsonEncode(
  //       {
  //         'lat': 6.517871336509268,
  //         'lon': 3.399740067230001,
  //         'user_id': 'jksdhfuihewuiohio2',
  //       },
  //     ),
  //   );

  //   final response = await future;
  //   print(response.body);
  //   // setState(() {
  //   //   status = Status.submitting;
  //   // });
  //   // await Future.delayed(const Duration(seconds: 1));
  //   // setState(() {
  //   //   status = Status.failed;
  //   // });
  // }

  final site = AppConstants.url;
  late String token;

// Dart client
  io.Socket socket = io.io('https://fef9-197-211-58-29.ngrok.io/',
      io.OptionBuilder().setTransports(['websocket']).build());

  String? bookingId;
  String? artisanId;

  @override
  void initState() {
    FirebaseAuth.instance.currentUser!
        .getIdToken()
        .then((value) => token = value);

    socket.connect();

    socket.onConnect((_) {
      print('connect');
    });
    // socket.on('event', (data) => print('Event $data'));
    socket.onDisconnect((_) => print('client disconnect'));

    socket.on('msg', (data) {
      print('Event update: $data');

      artisanId = data['artisan_id'];
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
                socket.emit('close_offer', {
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
                print('right');
                print(FirebaseAuth.instance.currentUser!.uid);
                // final loc = await PlacesService.instance.determinePosition();
                final future = http.get(
                  Uri.http(
                    site,
                    '/api/user/${FirebaseAuth.instance.currentUser!.uid}',
                  ),
                );

                final response = await future;
                print(response.statusCode);
                print(response.body);
              },
              child: Ink(
                height: 80,
                width: 80,
                color: Colors.green,
              ),
            ),
            InkWell(
              onTap: () async {
                final future = http.post(
                  Uri.https(
                    site,
                    '/bookings/',
                  ),
                  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
                  body: jsonEncode(
                    {
                      'lat': 6.517871336509268,
                      'lon': 3.399740067230001,
                      'user_id': 'u1ih272y8h3e',
                      'job_category': 'carpentary',
                    },
                  ),
                );

                final response = await future;
                print(response.body);

                final json = jsonDecode(response.body);
                bookingId = json['data']['booking_id'];

                socket.emit('booking_update', {
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
                print(token);
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
