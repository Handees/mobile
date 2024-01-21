import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/customer_app/features/home/providers/booking.provider.dart';

import 'package:handees/shared/res/shapes.dart';
import 'package:handees/shared/routes/routes.dart';
import 'package:handees/shared/ui/widgets/circle_fadeout_loader.dart';

import 'in_progress_bottom_sheet.dart';
import 'loading_bottom_sheet.dart';
import '../providers/trackingProvider.dart';


class TrackingScreen extends ConsumerWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    late final Widget bottomSheet;
    late final Widget backgroundScreen;
    final trackingState = ref.watch(bookingProvider);
    final model = ref.watch(bookingProvider.notifier);
    final background = ref.watch(blurBackgroundProvider);
    const mapWidget = Text("Map", style: TextStyle(fontSize: 80));

    switch (trackingState) {
      case BookingState.loading:
        bottomSheet = LoadingBottomSheet(
          category: model.category,
        );
        backgroundScreen = const Center(
          child: CircleFadeOutLoader(),
        );
        break;
      case BookingState.inProgress:
        bottomSheet = const InProgressBottomSheet();
        switch (background) 
        {
          case BottomSheetState.inView:
            backgroundScreen = ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: const Center(child: mapWidget)
            );
            break;
          case BottomSheetState.minimized:
            backgroundScreen = const Center(child: mapWidget);
            break;
        }
        break;
      case BookingState.arrived:
        bottomSheet = const ArrivedBottomSheet();
        switch (background) 
        {
          case BottomSheetState.inView:
            backgroundScreen = ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: const Center(child:mapWidget)
            );
            break;
          case BottomSheetState.minimized:
            backgroundScreen = const Center(child: mapWidget);
            break;
        }
        break;
      default:
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: backgroundScreen,
      bottomSheet: Material(
        elevation: 24,
        shadowColor: Colors.black,
        child: bottomSheet,
      ),
    );
  }
}

class ArrivedBottomSheet extends StatelessWidget {
  const ArrivedBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Your handee man is here',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 8.0),
          const ProgressCard(),
          const SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {},
                  child: const Text('Call'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                // width: double.infinity,
                child: FilledButton.tonal(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CustomerAppRoutes.chat);
                  },
                  child: const Text('Message'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}

class ProgressCard extends StatelessWidget {
  const ProgressCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 28),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jane Doe',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Icon(
                    Icons.money,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    '₦500/hr',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Container(
            decoration: const ShapeDecoration(
              color: Color.fromRGBO(253, 223, 242, 1),
              shape: Shapes.mediumShape,
            ),
            height: 64,
            width: 64,
            child: const Center(
              child: CircleAvatar(
                backgroundColor: Color.fromRGBO(255, 125, 203, 1),
                child: Icon(Icons.abc),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
