import 'package:flutter/material.dart';
import 'package:handees/artisan_app/features/complete_profile/complete_profile.dart';
import 'package:handees/artisan_app/features/complete_profile/ui/basic_info.dart';
import 'package:handees/artisan_app/features/complete_profile/ui/document_upload.dart';
import 'package:handees/artisan_app/features/complete_profile/ui/handee_details.dart';
import 'package:handees/artisan_app/features/complete_profile/ui/payment_details.dart';
import 'package:handees/artisan_app/features/home/home.dart';
import 'package:handees/customer_app/services/auth_service.dart';
import 'package:handees/routes/artisan_app/routes.dart';
import 'package:handees/shared/widgets/navigator.dart';

import 'package:handees/routes/customer_app/routes.dart';
import 'package:handees/routes/pages.dart';
import 'package:handees/theme/theme.dart';

import 'auth/routes.dart';

final mainRouter = NavRouter(
  onGenerateRoute: (RouteSettings settings) {
    NavRouter? router;

    print('MainRouter working  ${settings.name}');
    final authService = AuthService.instance;

    switch (settings.name) {
      case '/':
        router =
            authService.isAuthenticated() && authService.isProfileComplete()
                ? _customerAppRouter
                : _authRouter;
        break;
      case AuthRoutes.root:
        router = _authRouter;

        break;
      case CustomerAppRoutes.root:
        router = _customerAppRouter;
        break;
      case ArtisanAppRoutes.root:
        router = _artisanAppRouter;
        break;
      default:
    }

    return MaterialPageRoute(
      builder: (context) => RootNavigator(
        router: router!,
      ),
    );
  },
);

final _authRouter = NavRouter(
  onGenerateRoute: (RouteSettings settings) {
    Widget? page;

    print('AuthRouter working  ${settings.name}');

    switch (settings.name) {
      case '/':
      case AuthRoutes.root:
      case AuthRoutes.signin:
        page = SigninScreen();
        break;
      case AuthRoutes.signup:
        page = SignupScreen();
        break;
      case AuthRoutes.verify:
        page = VerifyScreen();
        break;
      default:
    }

    return MaterialPageRoute(
      builder: (context) => Theme(
        data: authTheme,
        child: page!,
      ),
    );
  },
);

final _customerAppRouter = NavRouter(
  onGenerateRoute: (RouteSettings settings) {
    print('CustomerAppRouter working  ${settings.name}');

    Widget? page;

    MaterialPageRoute? pageRoute;
    switch (settings.name) {
      case '/':
      case CustomerAppRoutes.root:
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
  },
);

final _artisanAppRouter = NavRouter(
  onGenerateRoute: (RouteSettings settings) {
    Widget? page;

    debugPrint('ArtisanAppRouter working  ${settings.name}');

    switch (settings.name) {
      case "/":
      case ArtisanAppRoutes.root:
        page = const ArtisanHomeScreen();
        break;
      case ArtisanAppRoutes.completeProfile:
        page = ArtisanCompleteProfileScreen();
        break;
      case ArtisanAppRoutes.basicInfo:
        page = const BasicInfoScreen();
        break;
      case ArtisanAppRoutes.documentUpload:
        page = const DocumentUploadScreen();
        break;
      case ArtisanAppRoutes.handeeDetails:
        page = const HandeeDetailsScreen();
        break;
      case ArtisanAppRoutes.paymentDetails:
        page = const PaymentDetailsScreen();
        break;
      default:
        throw Exception('Unknown route: ${settings.name}');
    }

    return MaterialPageRoute(
      builder: (context) => page!,
    );
  },
);

class NavRouter {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final Route<dynamic> Function(RouteSettings) onGenerateRoute;

  NavRouter({required this.onGenerateRoute});
}
