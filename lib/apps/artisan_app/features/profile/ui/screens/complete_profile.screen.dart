import 'package:flutter/material.dart';
import 'package:handees/apps/artisan_app/features/profile/ui/widgets/complete_profile_link_card.dart';
import 'package:handees/apps/artisan_app/features/profile/ui/data/complete_profile_link_model.dart';
import 'package:handees/shared/routes/routes.dart';

class ArtisanCompleteProfileScreen extends StatelessWidget {
  ArtisanCompleteProfileScreen({super.key});

  final double horizontalPadding = 16.0;

  final List<CompleteProfileLink> _completeProfileLinks = [
    CompleteProfileLink(
      title: "Document Upload",
      subtitle: "Upload valid means of identification",
      routerLink: ArtisanAppRoutes.documentUpload,
    ),
    CompleteProfileLink(
      title: "Handee Details",
      subtitle: "Payment rate and skills",
      routerLink: ArtisanAppRoutes.handeeDetails,
    ),
    CompleteProfileLink(
      title: "Payment Details",
      subtitle: "Bank account",
      routerLink: ArtisanAppRoutes.paymentDetails,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Complete your profile",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return CompleteProfileLinkCard(_completeProfileLinks[index]);
              }, childCount: _completeProfileLinks.length),
            ),
          )
        ],
      ),
    );
  }
}
