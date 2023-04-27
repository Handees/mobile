import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:handees/data/chats/model/message_model.dart';
import 'package:handees/services/chat_service.dart';

class ChatViewModel extends ChangeNotifier {
  ChatViewModel(this.bookingId, this.chatService) {
    _messageSubscription =
        chatService.getMessages(bookingId).listen((messages) {
      print('Updating messages');
      this.messages = messages;
      notifyListeners();
    });
  }
  late final StreamSubscription<List<MessageModel>> _messageSubscription;

  List<MessageModel> messages = [];

  final String bookingId;

  final ChatService chatService;

  void sendMessage(String message) {
    chatService.sendMessage(
      message,
      'rubbish',
    );
  }

  @override
  void dispose() {
    print('Disposing chat');
    _messageSubscription.cancel();
    super.dispose();
  }
}
