import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/customer_app/home/providers/home_provider.dart';
import 'package:handees/apps/customer_app/profile/providers/profile_provider.dart';
import 'package:handees/data/user/datasources/local.dart';
import 'package:hive/hive.dart';

class EditEmail extends ConsumerWidget {
  const EditEmail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email'),
      ),
      body: Center(
          child: Column(
        children: [
          TextField(
            onSubmitted: (value) {
              print(value);
              ref.read(profileProvider.notifier).updateEmail(value);
            },
          ),
          FilledButton(
            onPressed: () async {},
            child: Text('Done'),
          )
        ],
      )),
    );
  }
}
