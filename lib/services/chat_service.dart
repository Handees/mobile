import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/data/chats/chat_repository.dart';
import 'package:handees/data/chats/model/message_model.dart';

final chatServiceProvider = Provider<ChatService>((ref) {
  return ChatService._(TestChatRepository());
});

class ChatService {
  ChatService._(this.chatRepository);

  static final instance = ChatService._(TestChatRepository());

  final ChatRepository chatRepository;

  void sendMessage(String message, String bookingId) =>
      chatRepository.sendMessage(
        MessageModel(
          message: message,
          time: DateTime.now(),
          senderId: FirebaseAuth.instance.currentUser!.uid,
          bookingId: 'rubbish',
        ),
      );

  Stream<List<MessageModel>> getMessages(String bookingId) =>
      chatRepository.getMessages(bookingId);
}
