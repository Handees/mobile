import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:handees/features/auth/services/auth_service.dart';
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

abstract class CustomerAppRoutes {
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

abstract class HandeemanAppRoutes {}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  Widget? page;

  MaterialPageRoute? pageRoute;
  switch (settings.name) {
    case '/':
      final isAuth = FirebaseAuth.instance.currentUser != null &&
          FirebaseAuth.instance.currentUser!.email!.isNotEmpty;
      page = isAuth
          ? HomeScreen()
          : Theme(
              data: authTheme,
              child: SigninScreen(),
            );
      break;
    case CustomerAppRoutes.signin:
      page = Theme(
        data: authTheme,
        child: SigninScreen(),
      );
      break;
    case CustomerAppRoutes.signup:
      page = Theme(
        data: authTheme,
        child: SignupScreen(),
      );
      break;
    case CustomerAppRoutes.verify:
      page = Theme(
        data: authTheme,
        child: VerifyScreen(),
      );
      break;

    case CustomerAppRoutes.home:
      page = const HomeScreen();
      break;
    case CustomerAppRoutes.profile:
      page = const ProfileScreen();
      break;
    case CustomerAppRoutes.notifications:
      page = const NotificationsScreen();
      break;
    case CustomerAppRoutes.history:
      page = const HistoryScreen();
      break;
    case CustomerAppRoutes.settings:
      page = const SettingsScreen();
      break;
    case CustomerAppRoutes.tracking:
      page = const TrackingScreen();
      break;
    case CustomerAppRoutes.pickService:
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
