import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class MessageModel {
  final String message;
  final DateTime time;
  final String senderId;
  final String bookingId;

  MessageModel({
    required this.message,
    required this.time,
    required this.senderId,
    required this.bookingId,
  });

  @override
  String toString() {
    // TODO: implement toString
    return 'MessageModel(message: $message, time: $time, senerId: $senderId, bookingId: $bookingId)';
  }

  //TODO: compare with uid
  bool get isUser => senderId == FirebaseAuth.instance.currentUser!.uid;

  String get formattedString => DateFormat.Hm().format(time);
}
