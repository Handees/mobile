import 'package:flutter/material.dart';
import 'package:handees/artisan_app/features/complete_profile/complete_profile.dart';
import 'package:handees/artisan_app/features/home/home.dart';
import 'package:handees/routes/artisan_app/routes.dart';
import 'package:handees/routes/pages.dart';

Route<dynamic> artisanAppRouter(RouteSettings settings) {
  debugPrint('ArtisanApp working  ${settings.name}  ${settings.name}');

  Widget? page;

  switch (settings.name) {
    case ArtisanAppRoutes.home:
      page = const ArtisanHomeScreen();
      break;
    case ArtisanAppRoutes.basicInfo:
      page = const ProfileScreen();
      break;
    case ArtisanAppRoutes.completeProfile:
      page = const ArtisanCompleteProfileScreen();
      break;
    case ArtisanAppRoutes.documentUpload:
      page = const HistoryScreen();
      break;
    default:
      throw Exception('Unknown route: ${settings.name}');
  }
  return MaterialPageRoute(
    builder: (context) => page!,
  );
}
