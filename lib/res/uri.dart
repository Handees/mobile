import 'package:handees/res/constants.dart';

abstract class AppUris {
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
