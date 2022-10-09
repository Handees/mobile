import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handees/res/shapes.dart';
import 'package:handees/theme/theme.dart';
import 'package:handees/shared/widgets/circle_fadeout_loader.dart';

import 'in_progress_bottom_sheet.dart';
import 'loading_bottom_sheet.dart';

enum TrackingState { loading, inProgress, arrived, done }

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  var _trackingState = TrackingState.loading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 10)).then((value) {
      setState(() {
        _trackingState = TrackingState.inProgress;
      });
    }).then((value) {
      Future.delayed(const Duration(seconds: 20)).then((value) => {
            setState(() {
              _trackingState = TrackingState.arrived;
            })
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    late final bottomSheet;

    switch (_trackingState) {
      case TrackingState.loading:
        bottomSheet = const LoadingBottomSheet();
        break;
      case TrackingState.inProgress:
        bottomSheet = const InProgressBottomSheet();
        break;
      case TrackingState.arrived:
        bottomSheet = const ArrivedBottomSheet();
        break;
      default:
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // systemOverlayStyle: SystemUiOverlayStyle(
        //   systemNavigationBarIconBrightness: Brightness.dark,
        // ),
      ),
      extendBodyBehindAppBar: true,
      bottomSheet: Material(
        elevation: 24,
        shadowColor: Colors.black,
        child: bottomSheet,
      ),
      body: _trackingState == TrackingState.loading
          ? const Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 48.0),
                child: CircleFadeOutLoader(),
              ),
            )
          : const GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(12, 15),
              ),
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
          ProgressCard(),
          const SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Call'),
                  style: Theme.of(context)
                      .extension<ButtonThemeExtensions>()
                      ?.filled,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                // width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Message'),
                  style: Theme.of(context)
                      .extension<ButtonThemeExtensions>()
                      ?.tonal,
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
            decoration: ShapeDecoration(
              color: const Color.fromRGBO(253, 223, 242, 1),
              shape: Shapes.mediumShape,
            ),
            height: 64,
            width: 64,
            child: const Center(
              child: const CircleAvatar(
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
