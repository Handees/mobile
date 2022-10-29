import 'dart:math';

import 'package:flutter/material.dart';
import 'package:handees/customer_app/features/chat/models/message_model.dart';
import 'package:handees/res/shapes.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rand = Random(DateTime.now().millisecond);

    final messages = [
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
      MessageModel(
        message: 'Try me',
        time: DateTime.fromMillisecondsSinceEpoch(
            rand.nextInt(25200000) + 1665922275000),
        senderId: rand.nextInt(10) % 2 == 0 ? 'a' : 'b',
      ),
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
      MessageModel(
        message: 'Try me',
        time: DateTime.fromMillisecondsSinceEpoch(
            rand.nextInt(25200000) + 1665922275000),
        senderId: rand.nextInt(10) % 2 == 0 ? 'a' : 'b',
      ),
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
      MessageModel(
        message: 'Try me',
        time: DateTime.fromMillisecondsSinceEpoch(
            rand.nextInt(25200000) + 1665922275000),
        senderId: rand.nextInt(10) % 2 == 0 ? 'a' : 'b',
      ),
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
      MessageModel(
        message: 'Try me',
        time: DateTime.fromMillisecondsSinceEpoch(
            rand.nextInt(25200000) + 1665922275000),
        senderId: rand.nextInt(10) % 2 == 0 ? 'a' : 'b',
      ),
    ];

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Jane Doe'),
      //   centerTitle: true,
      // ),
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
                SizedBox(width: 16),
                Text('Jane Doe'),
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
                  final isUser = messages[index].senderId == 'a';
                  return Column(
                    crossAxisAlignment: isUser
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        margin: EdgeInsets.symmetric(vertical: 4.0),
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
                icon: Icon(Icons.send),
                onPressed: () {},
              )),
        ),
      ),
      // bottomNavigationBar: TextField(),
    );
  }
}
