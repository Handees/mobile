import 'package:flutter/material.dart';

class ProfileEditingTextField extends StatelessWidget {
  const ProfileEditingTextField({
    super.key,
    required this.keyboard,
  });

  final TextInputType keyboard;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          keyboardType: keyboard,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            suffixIcon: Container(
              margin: const EdgeInsets.only(right: 2),
              child: IconButton(
                highlightColor: Colors.transparent,
                icon: const Icon(
                  Icons.clear,
                  size: 25,
                  color: Colors.grey,
                ),
                onPressed: () {},
              ),
            ),
          ),
        )
      ],
    );
  }
}
