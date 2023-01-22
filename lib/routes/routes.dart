import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handees/artisan_app/features/home/home.dart';
import 'package:handees/customer_app/features/auth/ui/auth_screen.dart';
import 'package:handees/customer_app/features/chat/ui/chat_screen.dart';
import 'package:handees/customer_app/features/payments/ui/add_card_screen.dart';
import 'package:handees/customer_app/features/payments/ui/payments_screen.dart';
import 'package:handees/customer_app/features/auth/ui/screens/verify_screen.dart';
import 'package:handees/customer_app/features/history/ui/history_screen.dart';
import 'package:handees/customer_app/features/home/ui/home_screen.dart';
import 'package:handees/customer_app/features/home/ui/pick_service_dialog.dart';
import 'package:handees/customer_app/features/notifications/ui/notifications_screen.dart';
import 'package:handees/customer_app/features/payments/ui/verify_code_screen.dart';
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
  static const String home = '/customer/home';
  static const String pickService = '/customer/pick-service';
  static const String tracking = '/customer/tracking';
  static const String chat = '/customer/chat';
  static const String notifications = '/customer/notifications';
  static const String history = '/customer/history';
  static const String help = '/customer/help';
  static const String helpDetails = '/customer/help-details';
  static const String profile = '/customer/profile';
  static const String editEmail = '/customer/profile/edit-email';
  static const String editAddress = '/customer/profile/edit-address';
  static const String editPrimary = '/customer/profile/edit-primary';

  static const String payments = '/customer/payments';
  static const String addCard = '/customer/payments/add-card';
  static const String verifyCode = '/customer/payments/verify';

  static const String settings = '/customer/settings';
  static const String support = '/customer/support';
  static const String servicesData = '/customer/services-data';
}

abstract class ArtisanAppRoutes {
  static const String completeProfile = '/artisan/complete-profile';
  static const String basicInfo = '/artisan/complete-profile/basic-info';
  static const String documentUpload =
      '/artisan/complete-profile/document-upload';
  // static const String completeProfile = '/form/complete-profile';

  static const String home = '/artisan/home';
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  Widget? page;

  MaterialPageRoute? pageRoute;
  switch (settings.name) {
    case '/':
      page = StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).popUntil((route) {
              return (route.settings.name ?? "") != AuthRoutes.verify;
            });
          });
          return snapshot.hasData
              ? const HomeScreen()
              : Theme(
                  data: authTheme,
                  child: const AuthScreen(),
                );
        },
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

    case CustomerAppRoutes.addCard:
      page = AddCardScreen();
      break;
    case CustomerAppRoutes.payments:
      page = const PaymentsScreen();
      break;
    case CustomerAppRoutes.verifyCode:
      page = const VerifyCodeScreen();
      break;
    case ArtisanAppRoutes.home:
      page = const ArtisanHomeScreen();
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
      ? MaterialPageRoute(
          builder: (context) => page!,
          settings: RouteSettings(
            name: settings.name,
          ),
        )
      : pageRoute!;
}
