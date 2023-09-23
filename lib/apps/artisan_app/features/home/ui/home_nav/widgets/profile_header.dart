import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/artisan_app/features/home/ui/home_nav/widgets/accept_handee_dialog.dart';
import 'package:handees/apps/customer_app/features/home/providers/user.provider.dart';
import 'package:handees/apps/customer_app/features/home/ui/widgets/swap_button.dart';
import 'package:handees/shared/data/handees/offer.dart';
import 'package:handees/shared/routes/routes.dart';
import 'package:handees/shared/services/auth_service.dart';
import 'package:handees/shared/ui/widgets/custom_bottom_sheet.dart';

class ProfileHeader extends ConsumerWidget {
  ProfileHeader(this.isProfileComplete, {super.key});

  final bool isProfileComplete;

  final firebaseUser = AuthService.instance.user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => showDialog(
            context: context,
            builder: (ctx) => AcceptHandeeDialog(
              externalContext: context,
              offer: Offer.empty(),
              onClose: () {
                Navigator.of(ctx).pop();
              },
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffc4c4c4),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(4),
            child: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(firebaseUser.photoURL ??
                  "https://fcb-abj-pre.s3.amazonaws.com/img/jugadors/MESSI.jpg"),
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              user.getName(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const Spacer(),
        SwapButton(() {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (sheetCtx) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(sheetCtx).viewInsets.bottom,
                ),
                child: CTABottomSheet(
                  title: 'Switch Apps',
                  text:
                      "Are you sure you would like to switch to the customer app?",
                  ctaText: "Switch to Customer",
                  leading: SwapButton(() {}),
                  onPressCta: () async {
                    await Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed(CustomerAppRoutes.home);
                  },
                ),
              );
            },
          );
        })
      ],
    );
  }
}
