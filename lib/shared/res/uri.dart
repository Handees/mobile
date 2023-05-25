import 'package:handees/shared/res/constants.dart';

abstract class AppUris {
  static final rootUri = Uri.http(
    AppConstants.url,
    '/',
  );

  static final customerSocketUri = Uri.http(
    AppConstants.url,
    '/customer',
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

  static final addNewArtisanUri = Uri.http(
    AppConstants.url,
    '/api/user/artisan/',
  );

  static final bookServiceUri = Uri.http(
    AppConstants.url,
    '/api/bookings/',
  );

  static final paymentsUri = Uri.http(
    AppConstants.url,
    '/api/payments/',
  );

  static Uri userDataUri = Uri.http(
    AppConstants.url,
    '/api/user/signin',
  );
}
