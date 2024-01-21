import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/artisan_app/features/profile/ui/widgets/complete_profile_link_card.dart';
import 'package:handees/apps/artisan_app/features/profile/ui/data/complete_profile_link_model.dart';
import 'package:handees/apps/customer_app/features/home/providers/user.provider.dart';
import 'package:handees/shared/data/user/models/artisan.model.dart';
import 'package:handees/shared/routes/routes.dart';
import 'package:handees/shared/utils/utils.dart';

class DocumentUploadScreen extends ConsumerWidget {
  const DocumentUploadScreen({super.key});

  final double horizontalPadding = 16.0;

  String getKycText(String kycStatus) {
    switch (kycStatus) {
      case KYCStatus.inProgress:
        return 'KYC is in progress';
      case KYCStatus.completed:
        return 'KYC has been completed';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    dPrint(ref.watch(userProvider).artisanProfile!.kycStatus);
    final List<CompleteProfileLink> completeProfileLinks = [
      CompleteProfileLink(
          title: "Valid ID",
          subtitle: "Upload a valid means of identification",
          routerLink: ArtisanAppRoutes.validId,
          disabled: ref.watch(userProvider).artisanProfile!.kycStatus !=
              KYCStatus.uninitialized,
          disabledText:
              getKycText(ref.watch(userProvider).artisanProfile!.kycStatus)),
      CompleteProfileLink(
        title: "Passport Photograph",
        subtitle: "Upload your passport photograph",
        routerLink: ArtisanAppRoutes.passportPhotograph,
      ),
    ];

    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Document Upload",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Upload the required documents",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: const Color(0xff949494)),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return CompleteProfileLinkCard(
                    completeProfileLinks[index],
                  );
                },
                childCount: completeProfileLinks.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
