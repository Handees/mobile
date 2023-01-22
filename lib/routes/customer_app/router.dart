import 'package:flutter/material.dart';
import 'package:handees/routes/pages.dart';

import 'routes.dart';

Route<dynamic> customerAppRouter(RouteSettings settings) {
  print('CustomerApp working  ${settings.name}  ${settings.name}');

  Widget? page;

  MaterialPageRoute? pageRoute;
  switch (settings.name) {
    case '/':
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
        )
      : pageRoute!;
}
