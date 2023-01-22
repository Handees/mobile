import 'package:intl/intl.dart';

class MessageModel {
  final String message;
  final DateTime time;
  final String senderId;

  MessageModel({
    required this.message,
    required this.time,
    required this.senderId,
  });

  //TODO: compare with uid
  bool get isUser => senderId == 'a';

  String get formattedString => DateFormat.Hm().format(time);
}
