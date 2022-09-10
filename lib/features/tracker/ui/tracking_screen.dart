import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handees/res/shapes.dart';
import 'package:handees/theme/theme.dart';
import 'package:handees/utils/widgets/circle_fadeout_loader.dart';

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
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        _trackingState = TrackingState.inProgress;
      });
    }).then((value) {
      Future.delayed(Duration(seconds: 800000)).then((value) => {
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
        bottomSheet = LoadingBottomSheet();
        break;
      case TrackingState.inProgress:
        bottomSheet = InProgressBottomSheet();
        break;
      case TrackingState.arrived:
        bottomSheet = ArrivedBottomSheet();
        break;
      default:
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      bottomSheet: bottomSheet,
      body: _trackingState == TrackingState.loading
          ? Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 48.0),
                child: CircleFadeOutLoader(),
              ),
            )
          : GoogleMap(
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
    print('building');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Your handee man is here',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Row(
              children: [
                CircleAvatar(radius: 28),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jane Doe',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.money,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          '₦500/hr',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  decoration: ShapeDecoration(
                    color: Color.fromRGBO(253, 223, 242, 1),
                    shape: Shapes.mediumShape,
                  ),
                  height: 64,
                  width: 64,
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Color.fromRGBO(255, 125, 203, 1),
                      child: Icon(Icons.abc),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Call'),
                  style: Theme.of(context)
                      .extension<ButtonThemeExtensions>()
                      ?.filled,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                // width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Message'),
                  style: Theme.of(context)
                      .extension<ButtonThemeExtensions>()
                      ?.tonal,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
