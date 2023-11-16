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
import 'package:handees/apps/customer_app/features/home/providers/user.provider.dart';
import 'package:handees/apps/test.dart';
import 'package:handees/shared/data/handees/offer.dart';
import 'package:handees/shared/utils/utils.dart';
import 'widgets/accept_handee_dialog.dart';
import 'providers/new_offer_provider.dart';


class HomeNavScreen extends ConsumerStatefulWidget {
  const HomeNavScreen({super.key});

  @override
  ConsumerState<HomeNavScreen> createState() => _HomeNavScreenState();
}

class _HomeNavScreenState extends ConsumerState<HomeNavScreen> {
  final isProfileComplete = false;
  final double horizontalPadding = 16.0;
  bool isDialogOpen = true;
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

  void showNewOffer() {
    // If there's data in the queue and no dialog is currently shown, show the next dialog
    final bookingState = ref.read(bookingStateProvider);
    final bkstateNotifier = ref.read(bookingStateProvider.notifier);

    Future<void> close() async
    {
      bkstateNotifier.detachFromBooking();
    }

    if (newOfferQueue.isNotEmpty && bookingState==BookingState.detached) {
      bkstateNotifier.attachToBooking();
      Offer newOffer = newOfferQueue.removeFirst();
      showDialog(
        context: context,
        builder: (ctx) {
          return AcceptHandeeDialog(
            externalContext: context,
            offer: newOffer,
            onClose: close
          );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    // final bookingState = ref.read(bookingStateProvider);

    // if (bookingState == BookingState.detached)
    // {
    //   Offer newOffer = newOfferQueue.removeFirst(); 
    // }

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
