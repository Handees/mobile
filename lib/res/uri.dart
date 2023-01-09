import 'package:handees/res/constants.dart';

abstract class AppUris {
  static final customerSocketUri = Uri.http(
    AppConstants.url,
    '/cutomer',
  );

  static final artisanSocketUri = Uri.http(
    AppConstants.url,
    '/artisan',
  );

  static final chatSocketUri = Uri.http(
    AppConstants.url,
    '/chat',
  );

  static final addNewUserUri = Uri.http(
    AppConstants.url,
    '/api/user/',
  );

  static final bookServiceUri = Uri.http(
    AppConstants.url,
    '/api/bookings/',
  );

  static final paymentsUri = Uri.http(
    AppConstants.url,
    '/api/payments/',
  );

  static Uri userDataUri(String uid) => Uri.http(
        AppConstants.url,
        '/api/user/$uid',
      );
}
