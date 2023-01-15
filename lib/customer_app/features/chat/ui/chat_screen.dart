import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/customer_app/features/chat/models/message_model.dart';
import 'package:handees/res/shapes.dart';
import 'package:intl/intl.dart';

import '../providers/messages_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  void _onSubmit() {
    if (_textController.text.isEmpty) return;
    ref.read(messagesProvider.notifier).sendMessage(_textController.text);
    _textController.clear();
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  void initState() {
    // ref.read(messagesProvider.notifier).clear();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(messagesProvider.notifier);

    final messages = ref.watch(messagesProvider);

    print(messages);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar.medium(
                expandedHeight: 144,
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 16),
                    const Text('Jane Doe'),
                  ],
                ),
                centerTitle: true,
              ),
              SliverPadding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 100.0, //TODO: no light?
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final isUser = messages[index].isUser;

                      return Column(
                        crossAxisAlignment: isUser
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 2.0),
                            decoration: BoxDecoration(
                              borderRadius: (Shapes.smallShape.borderRadius
                                      as BorderRadius)
                                  .copyWith(
                                topLeft: isUser ? Radius.zero : null,
                                topRight: !isUser ? Radius.zero : null,
                              ),
                              color: isUser
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).colorScheme.primary,
                            ),
                            child: Text(
                              messages[index].message,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: isUser
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onSecondary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                  ),
                            ),
                          ),
                          if (!(index < messages.length - 1 &&
                              messages[index].isSimilar(messages[index + 1])))
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                right: 8.0,
                                bottom: 4.0,
                              ),
                              child: Text(messages[index].formattedString),
                            ),
                        ],
                      );
                    },
                    childCount: messages.length,
                  ),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Theme.of(context).colorScheme.surface,
              child: TextField(
                controller: _textController,
                onSubmitted: (_) => _onSubmit(),
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _onSubmit,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // bottomSheet: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: TextField(
      //     controller: _textController,
      //     onSubmitted: (_) => _onSubmit(),
      //     decoration: InputDecoration(
      //       hintText: 'Type a message',
      //       suffixIcon: IconButton(
      //         icon: const Icon(Icons.send),
      //         onPressed: _onSubmit,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

extension MessageComparator on MessageModel {
  bool isSimilar(MessageModel other) =>
      isUser == other.isUser && formattedString == other.formattedString;
}
