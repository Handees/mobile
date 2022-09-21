import 'package:flutter/material.dart';
import 'package:handees/features/auth/ui/screens/signin_screen.dart';
import 'package:handees/features/auth/ui/screens/signup_screen.dart';
import 'package:handees/features/auth/ui/screens/verify_screen.dart';
import 'package:handees/features/history/ui/history_screen.dart';
import 'package:handees/features/home/ui/home_screen.dart';
import 'package:handees/features/home/ui/pick_service_dialog.dart';
import 'package:handees/features/notifications/ui/notifications_screen.dart';
import 'package:handees/features/profile/ui/profile.dart';
import 'package:handees/features/settings/ui/settings.dart';
import 'package:handees/features/tracker/ui/tracking_screen.dart';
import 'package:handees/theme/theme.dart';

abstract class AppRoutes {
  static const String signin = '/auth/sign-in';
  static const String signup = '/auth/sign-up';
  static const String verify = '/auth/verify';

  static const String home = '/home';
  static const String pickService = '/pick-service';
  static const String tracking = '/tracking';
  static const String chat = '/chat';
  static const String notifications = '/notifications';
  static const String history = '/history';
  static const String help = '/help';
  static const String helpDetails = '/help-details';
  static const String profile = '/profile';
  static const String editEmail = '/profile/edit-email';
  static const String editAddress = '/profile/edit-address';
  static const String editPrimary = '/profile/edit-primary';

  static const String settings = '/settings';
  static const String support = '/support';
  static const String servicesData = '/services-data';
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  Widget? page;
  MaterialPageRoute? pageRoute;
  switch (settings.name) {
    case '/':
      page = Theme(
        data: authTheme,
        child: SignupScreen(),
      );
      break;
    case AppRoutes.signin:
      page = Theme(
        data: authTheme,
        child: SigninScreen(),
      );
      break;
    case AppRoutes.signup:
      page = Theme(
        data: authTheme,
        child: SignupScreen(),
      );
      break;
    case AppRoutes.verify:
      page = Theme(
        data: authTheme,
        child: const VerifyScreen(),
      );
      break;

    case AppRoutes.home:
      page = const HomeScreen();
      break;
    case AppRoutes.profile:
      page = const ProfileScreen();
      break;
    case AppRoutes.notifications:
      page = const NotificationsScreen();
      break;
    case AppRoutes.history:
      page = const HistoryScreen();
      break;
    case AppRoutes.settings:
      page = const SettingsScreen();
      break;
    case AppRoutes.tracking:
      page = const TrackingScreen();
      break;
    case AppRoutes.pickService:
      pageRoute = MaterialPageRoute(
        builder: ((context) => const PickServiceDialog()),
        fullscreenDialog: true,
      );
      break;
    default:
      throw Exception('Unknown route: ${settings.name}');
  }
  return page != null
      ? MaterialPageRoute(builder: (context) => page!)
      : pageRoute!;
}
