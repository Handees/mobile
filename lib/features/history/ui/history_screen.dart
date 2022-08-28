import 'package:flutter/material.dart';
import 'package:handees/service_state.dart';

import 'history_tile.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => HistoryTile(
          icon: Icon(Icons.abc),
          iconBackground: Colors.orange,
        ),
      ),
    );
  }
}
