import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handees/features/auth/ui/signup_screen.dart';
import 'package:handees/features/auth/ui/verify_screen.dart';
import 'package:handees/features/history/history_screen.dart';
import 'package:handees/features/home/ui/home_screen.dart';
import 'package:handees/features/notifications/ui/notifications_screen.dart';

abstract class AppRoutes {
  static const String signin = '/auth/sign-in';
  static const String signup = '/auth/sign-up';
  static const String verify = '/auth/verify';

  static const String home = '/home';
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
  late Widget page;
  switch (settings.name) {
    case '/':
      page = const SignupScreen();
      break;
    case AppRoutes.signin:
      page = const HomeScreen();
      break;
    case AppRoutes.signup:
      page = const SignupScreen();
      break;
    case AppRoutes.verify:
      page = const VerifyScreen();
      break;

    case AppRoutes.home:
      page = const HomeScreen();
      break;
    case AppRoutes.notifications:
      page = const NotificationsScreen();
      break;
    case AppRoutes.history:
      page = const HistoryScreen();
      break;
    default:
      throw Exception('Unknown route: ${settings.name}');
  }

  return MaterialPageRoute(builder: (context) => page);
}
