import 'package:flutter/material.dart';
import 'package:handees/artisan_app/features/auth/ui/complete_profile/widgets/complete_profile_link_card.dart';
import 'package:handees/customer_app/models/complete_profile_link_model.dart';
import 'package:handees/routes/artisan_app/routes.dart';

class DocumentUploadScreen extends StatelessWidget {
  DocumentUploadScreen({super.key});

  final double horizontalPadding = 16.0;

  final List<CompleteProfileLink> _completeProfileLinks = [
    CompleteProfileLink(
      title: "Valid ID",
      subtitle: "Upload a valid means of identification",
      routerLink: ArtisanAppRoutes.validId,
    ),
    CompleteProfileLink(
      title: "Passport Photograph",
      subtitle: "Upload your passport photograph",
      routerLink: ArtisanAppRoutes.passportPhotograph,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
