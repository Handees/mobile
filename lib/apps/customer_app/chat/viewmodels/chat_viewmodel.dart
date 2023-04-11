import 'package:flutter/foundation.dart';
import 'package:handees/data/chats/model/message_model.dart';
import 'package:handees/services/chat_service.dart';

class ChatViewModel extends ChangeNotifier {
  ChatViewModel(this.bookingId, this.chatService) {
    chatService.getMessages(bookingId).listen((messages) {
      print('Updating messages');
      this.messages = messages;
      notifyListeners();
    });
  }
  List<MessageModel> messages = [];

  final String bookingId;

  final ChatService chatService;

  void sendMessage(String message) {
    chatService.sendMessage(
      message,
      'rubbish',
    );
  }
}
