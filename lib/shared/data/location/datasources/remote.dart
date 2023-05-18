import 'package:handees/apps/artisan_app/services/sockets/artisan_socket.dart';
import 'package:handees/apps/artisan_app/services/sockets/artisan_socket_events.dart';

class LocationRemoteDataSource {
  final artisanSocketInstance = ArtisanSocket.instance;

  LocationRemoteDataSource() {
    artisanSocketInstance.connectArtisan();
  }

  void updateLocation(Map<String, dynamic> locationDetails) {
    artisanSocketInstance.artisanSocket
        .emit(ArtisanSocketEvents.locationUpdate, locationDetails);
  }
}
