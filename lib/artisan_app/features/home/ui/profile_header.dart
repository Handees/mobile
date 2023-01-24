import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader(this.isPhotoAvailable, {super.key});

  final bool isPhotoAvailable;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        isPhotoAvailable // TODO: photoIsAvailable
            ? const CircleAvatar(
                radius: 28,
                // backgroundImage: NetworkImage(
                // ),
              )
            : Container(
                height: 48,
                width: 48,
                decoration: ShapeDecoration(
                  shape: const CircleBorder(
                      side: BorderSide(
                    color: Color(0xffe5e5e5),
                  )),
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                child: const Icon(Icons.account_circle),
              ),
        const SizedBox(width: 16.0),
        Text(
          "Hello",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
