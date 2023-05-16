import 'dart:async';
import 'dart:math';

import 'package:handees/data/chats/model/message_model.dart';

class ChatRepository {
  static ChatRepository? _instance;

  ChatRepository._();

  factory ChatRepository() {
    return _instance ??= ChatRepository._();
  }

  void sendMessage(MessageModel message) => throw UnimplementedError();

  Stream<List<MessageModel>> getMessages(String bookingId) =>
      throw UnimplementedError();
}

class TestChatRepository implements ChatRepository {
  final _words = <String>[
    'Hi',
    'Changeable',
    'Burly',
    'Favor',
    'Dignitary',
    'Debonair',
    'Old - fashioned',
    'Founder',
    'Democracy',
    'Scrawny',
    'Discover',
    'Roomy',
    'Sew',
    'Top',
    'Latch',
    'Trick',
    'Drunken',
    'Countryside',
    'Critical',
    'Wine',
    'Flee',
    'Private',
    'Hallowed',
    'Threatening',
    'Aftermath',
    'Crate',
    'Preside',
    'Goose',
    'Beak',
    'Net',
    'Cadaver',
    'Thought',
    'Thumb',
    'Believable',
    'Almost',
    'Lucky',
    'Eggnog',
    'Gabby',
    'Ache',
    'Chicken',
    'Insect',
  ];

  final _rand = Random(DateTime.now().millisecond);

  final messages = <MessageModel>[];

  TestChatRepository() {
    _simulateMessages();
  }

  final _controller = StreamController<List<MessageModel>>.broadcast();

  void _simulateMessages() async {
    while (true) {
      print("Simulating, has listeners ${_controller.hasListener}");
      await Future.delayed(
          Duration(seconds: _rand.nextInt(5 + _rand.nextInt(25))));

      final message = _generateMessage();

      print('Adding message ${message.message}');
      _controller.add(messages..add(message));
    }
  }

  MessageModel _generateMessage() {
    final wordCount = 2 + _rand.nextInt(_rand.nextInt(15) + 1);

    String message = '';

    for (int i = 0; i < wordCount; ++i) {
      message += '${_words[_rand.nextInt(_words.length)]} ';
    }

    return MessageModel(
      message: message,
      time: DateTime.now(),
      senderId: 'fakeSender',
      bookingId: 'fakeRoom',
    );
  }

  @override
  Stream<List<MessageModel>> getMessages(String bookingId) {
    return _controller.stream;
  }

  @override
  void sendMessage(MessageModel message) {
    messages.add(message);
    _controller.add(messages);
  }
}
