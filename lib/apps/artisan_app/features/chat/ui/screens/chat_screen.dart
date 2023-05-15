import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/artisan_app/features/chat/providers/messages_provider.dart';

import 'package:handees/data/chats/model/message_model.dart';
import 'package:handees/res/shapes.dart';

class ArtisanChatScreen extends ConsumerStatefulWidget {
  const ArtisanChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ArtisanChatScreen> createState() => _ArtisanChatScreenState();
}

class _ArtisanChatScreenState extends ConsumerState<ArtisanChatScreen> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  void _onSubmit() {
    if (_textController.text.isEmpty) return;
    ref
        .read(artisanMessagesProvider.notifier)
        .sendMessage(_textController.text);
    _textController.clear();
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  void initState() {
    ref.read(artisanMessagesProvider.notifier).clear();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(artisanMessagesProvider.notifier);

    final messages = ref.watch(artisanMessagesProvider);

    print(messages);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              const SliverAppBar(),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://library.sportingnews.com/styles/crop_style_16_9_mobile_2x/s3/2022-09/Kylian%20Mbappe%20PSG%20042922%20169.jpg?itok=Rvhq8X-s"),
                            radius: 24,
                          ),
                          SizedBox(width: 16),
                          Text('Jane Doe'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: const Color(0xffe5e5e5),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Monday 26th Oct",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    )
                  ],
                ),
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
                              child: Text(
                                messages[index].formattedString,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
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
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                minLines: 1,
                maxLines: 4,
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
    );
  }
}

extension MessageComparator on MessageModel {
  bool isSimilar(MessageModel other) =>
      isUser == other.isUser && formattedString == other.formattedString;
}
