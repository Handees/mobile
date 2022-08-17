import 'package:flutter/material.dart';
import 'package:handees/service_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        itemBuilder: (context, index) => HistoryCard(
          icon: Icon(Icons.abc),
          iconBackground: Colors.orange,
        ),
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    Key? key,
    required this.icon,
    required this.iconBackground,
  }) : super(key: key);

  final Color iconBackground;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          Ink(
            decoration: ShapeDecoration(
              color: iconBackground.withOpacity(0.2),
              shape: CircleBorder(),
            ),
            height: 56,
            width: 56,
            child: Center(
              child: CircleAvatar(
                backgroundColor: iconBackground,
                radius: 16,
                child: icon,
              ),
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Text('Your handee man has arrived'),
          ),
          SizedBox(width: 16.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ServiceStateWidget.canceled(),
              Text(
                '4th Jan 2022',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
