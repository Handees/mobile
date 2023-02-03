import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/data/chat/message_model.dart';

class MessagesNotifier extends StateNotifier<List<MessageModel>> {
  MessagesNotifier() : super([]);

  final rand = Random(DateTime.now().millisecond);

  void samp() {
    state.addAll(
      [
        MessageModel(
          message: 'How far',
          time: DateTime.fromMillisecondsSinceEpoch(
              rand.nextInt(25200000) + 1665922275000),
          senderId: rand.nextInt(10) % 2 == 0 ? 'a' : 'b',
        ),
        MessageModel(
          message: 'Don\'t go naow',
          time: DateTime.fromMillisecondsSinceEpoch(
              rand.nextInt(25200000) + 1665922275000),
          senderId: rand.nextInt(10) % 2 == 0 ? 'a' : 'b',
        ),
        MessageModel(
          message: 'Lol',
          time: DateTime.fromMillisecondsSinceEpoch(
              rand.nextInt(25200000) + 1665922275000),
          senderId: rand.nextInt(10) % 2 == 0 ? 'a' : 'b',
        ),
      ],
    );
  }

  void clear() => state.clear();

  void _addMessage(MessageModel message) {
    state = [...state, message];
  }

  void sendMessage(String message) {
    _addMessage(
      MessageModel(
        message: message,
        time: DateTime.now(),
        senderId: rand.nextInt(10) % 2 == 0 ? 'a' : 'b',
      ),
    );
  }
}

final messagesProvider =
    StateNotifierProvider<MessagesNotifier, List<MessageModel>>((ref) {
  return MessagesNotifier();
});
