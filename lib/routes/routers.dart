import 'package:flutter/material.dart';
import 'package:handees/apps/artisan_app/features/auth/ui/complete_profile/screens/complete_profile.dart';
import 'package:handees/apps/artisan_app/features/auth/ui/complete_profile/screens/basic_info.dart';
import 'package:handees/apps/artisan_app/features/auth/ui/complete_profile/screens/document_upload.dart';
import 'package:handees/apps/artisan_app/features/auth/ui/complete_profile/screens/handee_details.dart';
import 'package:handees/apps/artisan_app/features/auth/ui/complete_profile/screens/passport_photograph.dart';
import 'package:handees/apps/artisan_app/features/auth/ui/complete_profile/screens/payment_details.dart';
import 'package:handees/apps/artisan_app/features/auth/ui/complete_profile/screens/valid_id.dart';
import 'package:handees/apps/artisan_app/features/home/home.artisan.dart';
import 'package:handees/apps/customer_app/profile/ui/edit_address.dart';
import 'package:handees/apps/customer_app/profile/ui/edit_email.dart';
import 'package:handees/apps/customer_app/profile/ui/edit_profile.dart';
import 'package:handees/routes/pages.dart';
import 'package:handees/services/auth_service.dart';
import 'package:handees/ui/widgets/navigator.dart';

import 'package:handees/theme/theme.dart';

import 'routes.dart';

final mainRouter = NavRouter(
  onGenerateRoute: (RouteSettings settings) {
    NavRouter? router;

    switch (settings.name) {
      case '/':
        router =
            AuthService.isAuthenticated() && AuthService.isProfileComplete()
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

    switch (settings.name) {
      case '/':
      case AuthRoutes.root:
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
    Widget? page;

    MaterialPageRoute? pageRoute;
    switch (settings.name) {
      case '/':
      case CustomerAppRoutes.root:
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
      case CustomerAppRoutes.editEmail:
        page = const EditEmail();
        break;
      case CustomerAppRoutes.editAddress:
        page = const EditAddress();
        break;
      case CustomerAppRoutes.editPrimary:
        page = const EditProfile();
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
        page = BasicInfoScreen();
        break;
      case ArtisanAppRoutes.documentUpload:
        page = DocumentUploadScreen();
        break;
      case ArtisanAppRoutes.handeeDetails:
        page = const HandeeDetailsScreen();
        break;
      case ArtisanAppRoutes.paymentDetails:
        page = const PaymentDetailsScreen();
        break;
      case ArtisanAppRoutes.validId:
        page = ValidIDScreen();
        break;
      case ArtisanAppRoutes.passportPhotograph:
        page = const PasspportPhotographScreen();
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
