import 'package:flutter/material.dart';
import 'package:handees/shared/data/handees/job_category.dart';

import 'history_tile.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Handee history'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => HistoryTile(
          jobCategory: jobCategories[0],
        ),
      ),
    );
  }
}
