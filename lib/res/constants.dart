abstract class AppConstants {
  static const url = '20.9.22.141:5020';

  static final addNewUserUri = Uri.https(
    url,
    '/api/user/',
  );

  static final bookServiceUri = Uri.https(
    url,
    '/api/bookings',
  );
}
