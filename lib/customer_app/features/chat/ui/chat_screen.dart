import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/res/shapes.dart';

import '../providers/messages_provider.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(messagesProvider.notifier);

    final messages = ref.watch(messagesProvider);

    print(messages);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
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
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  // return Text('How');
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
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        decoration: BoxDecoration(
                          borderRadius:
                              (Shapes.smallShape.borderRadius as BorderRadius)
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
                                    ? Theme.of(context).colorScheme.onSecondary
                                    : Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ),
                      Text(
                        messages[index].time.toString(),
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

      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Type a message',
            suffixIcon: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                print('added how');
                ref.read(messagesProvider.notifier).sendMessage('Very far');
                // model.sendMessage('Very far');
              },
            ),
          ),
        ),
      ),
      // bottomNavigationBar: TextField(),
    );
  }
}
