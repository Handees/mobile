import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handee/handee_colors.dart';
import 'package:handee/places_service.dart';
import 'package:handee/widgets/button.dart';

class PickLocation extends StatefulWidget {
  const PickLocation({Key? key}) : super(key: key);
  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  final _searchFocus = FocusNode();
  Size? _size;

  final _recentAdresses = const [
    '1 Church Road, London, E3 5GP',
    '27 Church Street, Wolverhampton, WV7 9KO',
    '94 Queens Road, Enfield, London, EN10 8KT',
    '12 The Crescent, Hereford, HR56 0IO' '1 Church Road, London, E3 5GP',
  ];

  Future<List<String>>? _suggestionsFuture;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _size ??= MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _getSuggestions(String value) async {
    _suggestionsFuture = PlaceService().getPredictions(value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HandeeColors.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            MapWidget(),
            FloatingActionButton(
              onPressed: () async {
                var res = await PlaceService().determinePosition();
                print(res);
              },
            ),
            // IgnorePointer(
            //   ignoring: !_searchFocus.hasFocus,
            //   child: AnimatedOpacity(
            //     duration: const Duration(milliseconds: 300),
            //     curve: Curves.decelerate,
            //     opacity: _searchFocus.hasFocus ? 1.0 : 0.0,
            //     child: Container(
            //       color: HandeeColors.white,
            //       height: double.infinity,
            //       width: double.infinity,
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Column(
            //         children: [
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Container(
            //                 width: 45,
            //                 height: 40,
            //                 child: IconButton(
            //                   icon: const Icon(
            //                     Icons.arrow_back,
            //                     color: HandeeColors.white,
            //                   ),
            //                   onPressed: () => Navigator.of(context).pop(),
            //                 ),
            //                 decoration: BoxDecoration(
            //                   color: HandeeColors.black,
            //                   boxShadow: const [
            //                     BoxShadow(
            //                         color: HandeeColors.shadowBlack,
            //                         blurRadius: 4),
            //                   ],
            //                   borderRadius: BorderRadius.circular(5),
            //                 ),
            //               ),
            //               const SizedBox(width: 13),
            //               Expanded(
            //                 child: Container(
            //                   //alignment: Alignment.center,
            //                   decoration: BoxDecoration(
            //                     color: HandeeColors.white,
            //                     boxShadow: const [
            //                       BoxShadow(
            //                           color: HandeeColors.shadowBlack,
            //                           blurRadius: 4),
            //                     ],
            //                     borderRadius: BorderRadius.circular(5),
            //                   ),
            //                   height: 40,
            //                   child: TextField(
            //                     controller: _searchController,
            //                     onSubmitted: (value) {
            //                       //setState(() {});
            //                       _getSuggestions(value);
            //                     },
            //                     onChanged: (value) {
            //                       setState(() {
            //                         _getSuggestions(value);
            //                       });
            //                     },
            //                     autofocus: false,
            //                     focusNode: _searchFocus,
            //                     decoration: const InputDecoration(
            //                       contentPadding: EdgeInsets.all(8),
            //                       prefixIcon: Icon(
            //                         Icons.search,
            //                         color: HandeeColors.grey89,
            //                         size: 20,
            //                       ),
            //                       border: InputBorder.none,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //           const SizedBox(height: 10),
            //           AnimatedOpacity(
            //             duration: const Duration(milliseconds: 300),
            //             curve: Curves.decelerate,
            //             opacity: _searchFocus.hasFocus ? 1.0 : 0.0,
            //             child: Container(
            //               margin: const EdgeInsets.only(bottom: 10),
            //               alignment: Alignment.center,
            //               width: double.infinity,
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(8),
            //                 color: HandeeColors.lightBlue,
            //               ),
            //               child: ConstrainedBox(
            //                 constraints: BoxConstraints(
            //                     minHeight: 100, maxHeight: _size!.height - 220),
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: _searchController.text.isNotEmpty
            //                       ? FutureBuilder<List<String>>(
            //                           future: _suggestionsFuture,
            //                           builder: (context, snapshot) {
            //                             return snapshot.connectionState ==
            //                                     ConnectionState.done
            //                                 ? SuggestionsWidget(snapshot.data!)
            //                                 : const Padding(
            //                                     padding: EdgeInsets.all(30.0),
            //                                     child:
            //                                         CircularProgressIndicator(),
            //                                   );
            //                           },
            //                         )
            //                       : SuggestionsWidget(_recentAdresses),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //       HandeeButton(text: 'Done', onTap: () {}),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class SuggestionsWidget extends StatelessWidget {
  const SuggestionsWidget(
    this.suggestions, {
    Key? key,
  }) : super(key: key);

  final List<String> suggestions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: suggestions.length, //_recentAdresses.length,
      itemBuilder: (ctx, i) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: HandeeColors.blue,
                size: 18,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  suggestions[i],
                  style: const TextStyle(color: HandeeColors.blue),
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        );
      },
    );
  }
}

class MapWidget extends StatefulWidget {
  const MapWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(6.518, 3.378),
        zoom: 15,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      mapToolbarEnabled: true,

      //zoomControlsEnabled: false,
    );
  }
}
