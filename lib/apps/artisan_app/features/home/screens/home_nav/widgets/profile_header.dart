import 'package:flutter/material.dart';
import 'package:handees/apps/artisan_app/features/home/screens/home_nav/widgets/icon_avatar.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader(this.isProfileComplete, {super.key});

  final bool isProfileComplete;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: isProfileComplete
          ? [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffc4c4c4),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.all(4),
                child: const CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                      "https://fcb-abj-pre.s3.amazonaws.com/img/jugadors/MESSI.jpg"),
                ),
              ),
              //Color(0xffc4c4c4)
              const SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "John Doe",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              // TODO: Add live handees icon
            ]
          : [
              const IconAvatar(),
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
