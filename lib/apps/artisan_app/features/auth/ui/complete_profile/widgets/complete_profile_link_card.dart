import 'package:flutter/material.dart';
import 'package:handees/artisan_app/complete_profile_link_model.dart';

class CompleteProfileLinkCard extends StatelessWidget {
  const CompleteProfileLinkCard(this.completeProfileLink, {super.key});

  final CompleteProfileLink completeProfileLink;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(completeProfileLink.routerLink);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  completeProfileLink.title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  completeProfileLink.subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: const Color(0xff949494)),
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
            )
          ],
        ),
      ),
    );
  }
}
