import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/shared/data/chats/model/message_model.dart';
import 'package:handees/apps/customer_app/services/chat_service.customer.dart';

final StateNotifierProvider<ChatStateNotifier, List<MessageModel>>
    chatProvider = StateNotifierProvider((ref) {
  // looks like we might have some trouble accessing the bookingId
  // when everything's set up but I think an easy fix we can use
  // is to store the booking Id in its own provider as well
  // then we simply read the value from that provider here

  return ChatStateNotifier('fakeBookingId', ChatService.instance);
});

class ChatStateNotifier extends StateNotifier<List<MessageModel>> {
  final String bookingId;
  final ChatService chatService;
  late final StreamSubscription<List<MessageModel>> _messageSubscription;

  ChatStateNotifier(this.bookingId, this.chatService) : super([]) {
    _messageSubscription =
        chatService.getMessages(bookingId).listen((messages) {
      this.messages = messages;
    });
  }

  List<MessageModel> messages = [];

  void sendMessage(String message) {
    chatService.sendMessage(message, bookingId);
  }

  void onSubmit(TextEditingController controller) {
    if (controller.text.isEmpty) return;
    sendMessage(controller.text);
    controller.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _messageSubscription.cancel();
  }
}
