import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handee/handee_colors.dart';
import 'package:handee/icons/handee_icons.dart';
import 'package:handee/map_style.dart';
import 'package:handee/services/places_service.dart';
import 'package:handee/widgets/button.dart';
import 'package:handee/widgets/loading_indicator.dart';

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen({Key? key}) : super(key: key);
  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen>
    with WidgetsBindingObserver {
  final _searchFocus = FocusNode();
  Size? _size;

  final _recentAdresses = const [
    '1 Church Road, London, E3 5GP',
    '27 Church Street, Wolverhampton, WV7 9KO',
    '94 Queens Road, Enfield, London, EN10 8KT',
    '12 The Crescent, Hereford, HR56 0IO' '1 Church Road, London, E3 5GP',
    'Onosa'
  ];

  Future<List<String>>? _suggestionsFuture;
  final _searchController = TextEditingController();
  Position? _initialPosition;
  late GoogleMapController _mapController;

  // MarkerId _userMarkerId = MarkerId("user");
  // late Marker _userMarker;

  Set<Marker> markers = <Marker>{};

  final _placeService = PlacesService.instance;
  String searchCache = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getUserLocation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _size ??= MediaQuery.of(context).size;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _getUserLocation();
    }
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    _searchController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _getUserLocation() async {
    _initialPosition =
        await _placeService.determinePosition().onError(_requestLocationAccess);

    _addMarker('user',
        LatLng(_initialPosition!.latitude, _initialPosition!.longitude));
  }

  Future<Position> _requestLocationAccess(error, stackTrace) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            //backgroundColor: Colors.white,
            title: const Text('Turn on Location Services'),
            //content: Text('Accept'),
            actions: [
              TextButton(
                onPressed: () async {
                  await _placeService.geolocatorInstance.openLocationSettings();
                  if (mounted) Navigator.of(ctx).pop();
                },
                child: const Text('Sure'),
              ),
              TextButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text(
                          'This service cannot work without location services'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Okay'),
                        )
                      ],
                    ),
                  );
                },
                child: const Text('At all boss'),
              ),
            ],
          );
        },
      );
    });

    return _placeService.determinePosition();
  }

  void _addMarker(String markerId, LatLng location) async {
    // final t = await BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration.empty, 'assets/images/untitled.png');
    if (markers.isNotEmpty) {
      markers.removeWhere((element) => element.markerId.value == 'user');
    }
    setState(() {
      markers.add(Marker(
        markerId: MarkerId(markerId),
        position: location,
        // icon: t,
      ));
    });
  }

  Future<void> _getSuggestions(String value) async {
    _suggestionsFuture = _placeService.getPredictions(value);
  }

  Future<void> _animateToAddress(String value) async {
    var location = await _placeService.getCoordinates(value);
    _addMarker('user', LatLng(location.latitude, location.longitude));
    log(markers.toString());

    _mapController.animateCamera(
        CameraUpdate.newLatLng(LatLng(location.latitude, location.longitude)));
  }

  Widget buildSuggestions(List<String> suggestions) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: suggestions.length, //_recentAdresses.length,
      itemBuilder: (ctx, i) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                FocusManager.instance.primaryFocus?.unfocus();
                _searchController.text = suggestions[i];
                _animateToAddress(suggestions[i]);
              });
            },
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    HandeeIcons.map_pin,
                    color: HandeeColors.blue,
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      suggestions[i],
                      style: const TextStyle(color: HandeeColors.blue),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // GestureDetector(
                  //   onTap: () {
                  //     _searchController.text = suggestions[i];
                  //     _searchController.selection = TextSelection.collapsed(
                  //       offset: _searchController.text.length,
                  //     );
                  //     setState(() {
                  //       _getSuggestions(_searchController.text);
                  //     });
                  //   },
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  //     child: const Icon(
                  //       Icons.north_west,
                  //       color: HandeeColors.blue,
                  //       size: 18,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
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
            _initialPosition == null
                ? const Center(
                    child: CircleFadeOutLoader(
                      color: HandeeColors.blue,
                    ),
                  )
                : GoogleMap(
                    markers: markers,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_initialPosition!.latitude,
                          _initialPosition!.longitude),
                      zoom: 17,
                    ),
                    zoomControlsEnabled: false,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    mapToolbarEnabled: false,
                    compassEnabled: false,
                    onMapCreated: (controller) {
                      _mapController = controller;
                      controller.setMapStyle(mapStyle);
                    },
                  ),
            Positioned(
              bottom: 110,
              right: 20,
              child: FloatingActionButton(
                child: const Icon(Icons.location_searching),
                onPressed: () async {
                  var res = await _placeService.determinePosition();
                  _mapController.animateCamera(
                    CameraUpdate.newLatLngZoom(
                      LatLng(res.latitude, res.longitude),
                      17,
                    ),
                  );
                  _searchController.text =
                      await _placeService.getAddress(_initialPosition!);
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
                  color: Theme.of(context).backgroundColor,
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
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              boxShadow: const [
                                BoxShadow(
                                  color: HandeeColors.shadowBlack,
                                  blurRadius: 4,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: HandeeColors.white,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
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
                                  if (searchCache != value) {
                                    setState(() {
                                      _getSuggestions(value);
                                    });
                                    searchCache = value;
                                  }
                                },
                                autofocus: false,
                                focusNode: _searchFocus,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(8),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: HandeeColors.grey89,
                                    size: 20,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _searchController.clear();
                                      });
                                    },
                                    child: const Icon(Icons.cancel),
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
                                minHeight: 70, maxHeight: _size!.height - 220),
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
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
