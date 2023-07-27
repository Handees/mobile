import "package:flutter/material.dart";
import 'package:handees/shared/routes/routes.dart';

class CompleteProfileCard extends StatelessWidget {
  const CompleteProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xfff4f4f4),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "PLEASE COMPLETE YOUR PROFILE",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                const Icon(
                  Icons.info,
                )
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Text(
                  "Complete your profile by providing the necessary information required and start earning money in no time!",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: const Color(0xff949494)),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(ArtisanAppRoutes.completeProfile);
                },
                icon: const Icon(
                  Icons.arrow_forward,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
