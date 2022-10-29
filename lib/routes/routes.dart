import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:handees/customer_app/features/chat/ui/chat_screen.dart';
import 'package:handees/customer_app/services/auth_service.dart';
import 'package:handees/customer_app/features/auth/ui/screens/signin_screen.dart';
import 'package:handees/customer_app/features/auth/ui/screens/signup_screen.dart';
import 'package:handees/customer_app/features/auth/ui/screens/verify_screen.dart';
import 'package:handees/customer_app/features/history/ui/history_screen.dart';
import 'package:handees/customer_app/features/home/ui/home_screen.dart';
import 'package:handees/customer_app/features/home/ui/pick_service_dialog.dart';
import 'package:handees/customer_app/features/notifications/ui/notifications_screen.dart';
import 'package:handees/customer_app/features/profile/ui/profile.dart';
import 'package:handees/customer_app/features/settings/ui/settings.dart';
import 'package:handees/customer_app/features/tracker/ui/tracking_screen.dart';
import 'package:handees/theme/theme.dart';

abstract class AuthRoutes {
  static const String signin = '/auth/sign-in';
  static const String signup = '/auth/sign-up';
  static const String verify = '/auth/verify';
}

abstract class CustomerAppRoutes {
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

abstract class HandeemanAppRoutes {
  static const String completeProfile = '/complete-profile';
  static const String basicInfo = '/complete-profile/basic-info';
  static const String documentUpload = '/complete-profile/document-upload';
  // static const String completeProfile = '/form/complete-profile';

  static const String home = '/home';
}

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
    case AuthRoutes.signin:
      page = Theme(
        data: authTheme,
        child: SigninScreen(),
      );
      break;
    case AuthRoutes.signup:
      page = Theme(
        data: authTheme,
        child: SignupScreen(),
      );
      break;
    case AuthRoutes.verify:
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
    case CustomerAppRoutes.chat:
      page = const ChatScreen();
      break;
    case CustomerAppRoutes.pickService:
      pageRoute = MaterialPageRoute(
        builder: ((context) => const PickServiceDialog()),
        fullscreenDialog: true,
      );
      break;

    //Artisan routes

    default:
      throw Exception('Unknown route: ${settings.name}');
  }
  return page != null
      ? MaterialPageRoute(builder: (context) => page!)
      : pageRoute!;
}
