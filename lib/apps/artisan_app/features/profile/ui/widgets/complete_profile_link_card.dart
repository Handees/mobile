import 'package:flutter/material.dart';
import 'package:handees/apps/artisan_app/features/profile/ui/data/complete_profile_link_model.dart';
import 'package:handees/shared/utils/utils.dart';

class CompleteProfileLinkCard extends StatelessWidget {
  const CompleteProfileLinkCard(this.completeProfileLink, {super.key});

  final CompleteProfileLink completeProfileLink;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!completeProfileLink.disabled) {
          Navigator.of(context).pushNamed(completeProfileLink.routerLink);
        } else {
          displaySnackbar(context, completeProfileLink.disabledText);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: completeProfileLink.disabled
            ? Opacity(
                opacity: .5,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          completeProfileLink.title,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
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
                        const SizedBox(height: 15),
                        Text(
                          completeProfileLink.disabledText,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
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
              )
            : Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        completeProfileLink.title,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
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
