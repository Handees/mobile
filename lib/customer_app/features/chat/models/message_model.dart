class MessageModel {
  final String message;
  final DateTime time;
  final String senderId;

  MessageModel({
    required this.message,
    required this.time,
    required this.senderId,
  });

  bool get isUser => senderId == 'a';
}
