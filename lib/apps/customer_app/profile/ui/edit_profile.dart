import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // const SizedBox(height: 84),
            const Spacer(),
            const Icon(Icons.account_circle_rounded, size: 80),
            const SizedBox(height: 41.17),
            const _EditProfileTextField(
                label: 'Full name', keyboard: TextInputType.name),
            const SizedBox(height: 24),
            const _EditProfileTextField(
                label: 'Last name', keyboard: TextInputType.name),
            const SizedBox(height: 24),
            const _EditProfileTextField(
                label: 'Phone number', keyboard: TextInputType.phone),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 64,
              child: FilledButton(
                onPressed: () {},
                child: const Text('Done'),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _EditProfileTextField extends StatelessWidget {
  const _EditProfileTextField({
    required this.label,
    required this.keyboard,
  });

  final String label;
  final TextInputType keyboard;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).disabledColor,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          keyboardType: keyboard,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            suffixIcon: Container(
              margin: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: const Icon(
                  Icons.clear,
                  size: 25,
                  color: Colors.grey,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}
