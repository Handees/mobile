import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // const Spacer(),
            const SizedBox(height: 50),
            const Icon(Icons.account_circle_rounded, size: 80),
            const SizedBox(height: 41.17),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                const SizedBox(height: 4),
                const TextField(
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 24),
                Text(
                  'Phone number',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                const SizedBox(height: 4),
                const TextField(keyboardType: TextInputType.phone),
              ],
            ),
            const Spacer(flex: 2),
            // const SizedBox(height: 125),
            SizedBox(
              width: double.infinity,
              height: 64,
              child: FilledButton(
                onPressed: () {},
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
