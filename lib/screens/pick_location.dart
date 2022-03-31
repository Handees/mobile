import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handee/handee_colors.dart';
import 'package:handee/icons/handee_icons.dart';
import 'package:handee/places_service.dart';
import 'package:handee/widgets/button.dart';
import 'package:handee/widgets/loading_indicator.dart';

class PickLocation extends StatefulWidget {
  const PickLocation({Key? key}) : super(key: key);
  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation>
    with WidgetsBindingObserver {
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
  Position? _position;
  late GoogleMapController _mapController;

  // MarkerId _userMarkerId = MarkerId("user");
  // late Marker _userMarker;

  Set<Marker> markers = <Marker>{};

  final _placeService = PlacesService();
  bool _serviceEnabled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    print('position');
    _getPosition();
  }

  Future<void> _getPosition() async {
    final future =
        _placeService.determinePosition().onError((error, stackTrace) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                //backgroundColor: Colors.white,
                title: Text('Turn on Location Services'),
                //content: Text('Accept'),
                actions: [
                  TextButton(
                    onPressed: () async {
                      await _placeService.geolocatorInstance
                          .openLocationSettings();
                      Navigator.of(ctx).pop();
                    },
                    child: Text('Sure'),
                  ),
                  TextButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(
                              'This service cannot work without location services'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: Text('Okay'),
                            )
                          ],
                        ),
                      );
                    },
                    child: Text('At all boss'),
                  ),
                ],
              );
            });
      });

      return _placeService.determinePosition();
    });

    _position = await future;
    //if (!_placeService.serviceEnabled) {

    //}
    _addMarker('user', LatLng(_position!.latitude, _position!.longitude));
    setState(() {});
  }

  void _addMarker(String markerId, LatLng location) async {
    //final t = await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/images/untitled.png');
    if (markers.isNotEmpty) {
      markers.removeWhere((element) => element.markerId.value == 'user');
    }
    markers.add(Marker(
      markerId: MarkerId(markerId),
      position: location,
      //icon: t,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _size ??= MediaQuery.of(context).size;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('State ${state}');
    super.didChangeAppLifecycleState(state);
    print('State ${state}');
    if (state == AppLifecycleState.resumed) {
      _getPosition();
    }
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    _searchController.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  Future<void> _getSuggestions(String value) async {
    _suggestionsFuture = _placeService.getPredictions(value);
  }

  Future<void> _animateToAddress(String value) async {
    var position = await _placeService.getCoordinates(value);
    _mapController.animateCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
  }

  Widget buildSuggestions(List<String> suggestions) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: suggestions.length, //_recentAdresses.length,
      itemBuilder: (ctx, i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: GestureDetector(
            onTap: () {
              setState(() {
                FocusManager.instance.primaryFocus?.unfocus();
                _searchController.text = suggestions[i];
                _animateToAddress(suggestions[i]);
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  HandeeIcons.map_pin,
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
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    _searchController.text = suggestions[i];
                  },
                  child: const Icon(
                    Icons.location_on_outlined,
                    color: HandeeColors.blue,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HandeeColors.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            _position == null
                ? const Center(
                    child: CircleFadeOutLoader(
                      color: HandeeColors.blue,
                    ),
                  )
                : GoogleMap(
                    markers: markers,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_position!.latitude, _position!.longitude),
                      zoom: 15,
                    ),
                    zoomControlsEnabled: false,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    mapToolbarEnabled: false,
                    compassEnabled: false,
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                  ),
            Positioned(
              bottom: 110,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: HandeeColors.backgroundDark,
                foregroundColor: Colors.white,
                child: const Icon(Icons.location_searching),
                onPressed: () async {
                  var res = await _placeService.determinePosition();
                  _mapController.animateCamera(
                    CameraUpdate.newLatLng(
                      LatLng(res.latitude, res.longitude),
                    ),
                  );
                  _searchController.text =
                      await _placeService.getAddress(_position!);
                },
              ),
            ),
            IgnorePointer(
              ignoring: !_searchFocus.hasFocus,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                curve: Curves.decelerate,
                opacity: _searchFocus.hasFocus ? 1.0 : 0.0,
                child: Container(
                  color: HandeeColors.white,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 45,
                            height: 40,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: HandeeColors.white,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            decoration: BoxDecoration(
                              color: HandeeColors.backgroundDark,
                              boxShadow: const [
                                BoxShadow(
                                    color: HandeeColors.shadowBlack,
                                    blurRadius: 4),
                              ],
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          const SizedBox(width: 13),
                          Expanded(
                            child: Container(
                              //alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: HandeeColors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: HandeeColors.shadowBlack,
                                      blurRadius: 4),
                                ],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              height: 40,
                              child: TextField(
                                controller: _searchController,
                                onSubmitted: (value) {
                                  _getSuggestions(value);
                                  _animateToAddress(value);
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _getSuggestions(value);
                                  });
                                },
                                autofocus: false,
                                focusNode: _searchFocus,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(8),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: HandeeColors.grey89,
                                    size: 20,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.decelerate,
                        opacity: _searchFocus.hasFocus ? 1.0 : 0.0,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: HandeeColors.lightBlue,
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight: 100, maxHeight: _size!.height - 220),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _searchController.text.isNotEmpty
                                  ? FutureBuilder<List<String>>(
                                      future: _suggestionsFuture,
                                      builder: (context, snapshot) {
                                        return snapshot.connectionState ==
                                                ConnectionState.done
                                            ? buildSuggestions(
                                                snapshot.data!,
                                              )
                                            : const Padding(
                                                padding: EdgeInsets.all(30.0),
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                      },
                                    )
                                  : buildSuggestions(
                                      _recentAdresses,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  HandeeButton(
                      text: 'Done',
                      onTap: () {
                        Navigator.of(context).pop(_searchController.text);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
