import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/data/chats/model/message_model.dart';
import 'package:handees/services/chat_service.dart';

class MessagesNotifier extends StateNotifier<List<MessageModel>> {
  MessagesNotifier(this.bookingId, this.chatService) : super([]) {
    chatService.getMessages(bookingId).listen((messages) {
      print('Updating messages');
      state = [...messages];
    });
  }
  final String bookingId;

  final ChatService chatService;

  void sendMessage(String message) {
    chatService.sendMessage(
      message,
      'rubbish',
    );
  }
}

final messagesProvider =
    StateNotifierProvider<MessagesNotifier, List<MessageModel>>((ref) {
  return MessagesNotifier('fakeBookingId', ref.watch(chatServiceProvider));
});
