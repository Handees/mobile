import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:handees/apps/customer_app/chat/providers/chat.provider.dart';
import 'package:handees/data/chats/model/message_model.dart';
import 'package:handees/res/shapes.dart';
import 'package:handees/services/chat_service.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollToBottom();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _checkAndScrollToBottom();
    final messages = ref.watch(chatProvider);
    final chatStateNotifier = ref.watch(chatProvider.notifier);

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
                  bottom: 96.0,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final isUser = messages[index].isUser;

                      return Column(
                        crossAxisAlignment: isUser
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            margin: EdgeInsets.only(
                              top: 2.0,
                              bottom: 2.0,
                              left: isUser ? 32.0 : 0.0,
                              right: isUser ? 0.0 : 32.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: (Shapes.smallShape.borderRadius
                                      as BorderRadius)
                                  .copyWith(
                                topLeft: !isUser ? Radius.zero : null,
                                topRight: isUser ? Radius.zero : null,
                              ),
                              color: isUser
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.secondary,
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
                                            .onPrimary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
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
                onSubmitted: (_) => chatStateNotifier.onSubmit(_textController),
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                minLines: 1,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () =>
                        chatStateNotifier.onSubmit(_textController),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _scrollToBottom() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  ///checks current scroll position to determine whether the controller should
  ///scroll or not
  void _checkAndScrollToBottom() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.offset >
          _scrollController.position.maxScrollExtent - 120) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      }
    });
  }
}

extension MessageComparator on MessageModel {
  bool isSimilar(MessageModel other) =>
      isUser == other.isUser && formattedString == other.formattedString;
}
