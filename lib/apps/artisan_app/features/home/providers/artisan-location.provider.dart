import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/artisan_app/services/sockets/artisan_socket.dart';
import 'package:handees/apps/customer_app/features/home/providers/user.provider.dart';
import 'package:handees/shared/utils/utils.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

final artisanOnlineProvider = StateProvider((ref) => false);

final locationProvider =
    StateNotifierProvider<LocationStateNotifier, LocationData>(
        (ref) => LocationStateNotifier(ref));

class LocationStateNotifier extends StateNotifier<LocationData> {
  final location = Location();
  bool _serviceEnabled = false;
  bool _backgroundModeEnabled = false;
  bool _handlerRegistered = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  StateNotifierProviderRef<LocationStateNotifier, LocationData> ref;
  LocationStateNotifier(this.ref) : super(LocationData.fromMap({}));

  void initLocation() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    final areLocationSettingsCompleted =
        sharedPrefs.getBool('locationSettingsCompleted');

    if (areLocationSettingsCompleted == null || !areLocationSettingsCompleted) {
      // Try to enable the location service
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          // TODO: Show snackbar to tell user that they didn't enable location
          dPrint('Location Service not enabled');
          return;
        }
      }

      // Try to enable the location permission
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied ||
          _permissionGranted == PermissionStatus.deniedForever) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          // TODO: Show snackbar to tell user that they didn't grant permissions
          dPrint('Location permissions not granted');
          return;
        }
      }

      _backgroundModeEnabled = await location.isBackgroundModeEnabled();
      if (!_backgroundModeEnabled) {
        try {
          _backgroundModeEnabled = await location.enableBackgroundMode();
        } catch (e) {
          dPrint('Background Location Service not enabled');
          ePrint(e.toString());
        }
      }

      sharedPrefs.setBool('locationSettingsCompleted', true);
    }

    location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 5000,
      distanceFilter: 5,
    );
    if (!_handlerRegistered) {
      location.onLocationChanged.listen((LocationData currLocation) {
        updateLocation(currLocation);

        if (ref.read(artisanOnlineProvider)) {
          ref.read(artisanSocketProvider.notifier).updateArtisanLocation(
              currLocation, ref.read(userProvider).artisanProfile!.jobCategory);
        }
      });
      _handlerRegistered = true;
    }
  }

  void updateLocation(LocationData newLocationData) {
    state = newLocationData;
  }
}
