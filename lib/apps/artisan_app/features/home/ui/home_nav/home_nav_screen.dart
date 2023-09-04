import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/artisan_app/features/home/ui/home_nav/widgets/complete_profile_card.dart';
import 'package:handees/apps/artisan_app/features/home/ui/home_nav/widgets/online_toggle_card.dart';
import 'package:handees/apps/artisan_app/features/home/ui/home_nav/widgets/profile_header.dart';
import 'package:handees/apps/artisan_app/features/home/ui/home_nav/widgets/user_stats_container.dart';
import 'package:handees/apps/artisan_app/services/sockets/artisan_socket.dart';
import 'package:handees/apps/artisan_app/services/sockets/artisan_socket_events.dart';
import 'package:handees/apps/customer_app/features/home/providers/home.customer.provider.dart';
import 'package:handees/shared/data/handees/offer.dart';
import 'package:handees/shared/utils/utils.dart';
import 'widgets/accept_handee_dialog.dart';

class HomeNavScreen extends ConsumerStatefulWidget {
  const HomeNavScreen({super.key});

  @override
  ConsumerState<HomeNavScreen> createState() => _HomeNavScreenState();
}

class _HomeNavScreenState extends ConsumerState<HomeNavScreen> {
  final isProfileComplete = false;
  final double horizontalPadding = 16.0;
  bool isDialogOpen = false;
  final Queue<Offer> newOfferQueue = Queue();

  @override
  void initState() {
    ref
        .read(artisanSocketProvider.notifier)
        .registerEventHandler(ArtisanSocketListenEvents.newOffer, (data) {
      dPrint('new offer received');
      Offer newOffer = Offer.fromJson(data);
      setState(() {
        newOfferQueue.add(newOffer);
      });

      showNewOffer();
    });
    super.initState();
  }

  void showNewOffer() async {
    // If there's data in the queue and no dialog is currently shown, show the next dialog
    if (newOfferQueue.isNotEmpty && !isDialogOpen) {
      isDialogOpen = true;
      Offer newOffer = newOfferQueue.removeFirst();
      showDialog(
        context: context,
        builder: (ctx) {
          return AcceptHandeeDialog(
            externalContext: context,
            offer: newOffer,
            onClose: () {
              Navigator.of(context).pop();
              // Check for the next data in the queue
              if (newOfferQueue.isNotEmpty) {
                // Show the next dialog after a delay to avoid overlapping
                Timer(const Duration(seconds: 1), () {
                  isDialogOpen = false;
                  showNewOffer();
                });
              } else {
                // No more data in the queue, allow showing new dialogs
                isDialogOpen = false;
              }
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    if (user.artisanProfile == null) {
      throw 'You got to the artisan home screen but there is no artisan on this user';
    }

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48.0),
                    child: ProfileHeader(isProfileComplete),
                  ),
                  user.artisanProfile!.isVerified
                      ? const OnlineToggleCard()
                      : const CompleteProfileCard(),
                  const SizedBox(height: 48),
                  const UserStatsContainer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
