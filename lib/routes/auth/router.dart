import 'package:flutter/material.dart';
import 'package:handees/routes/pages.dart';
import 'package:handees/theme/theme.dart';

import 'routes.dart';

Route<dynamic> authRouter(RouteSettings settings) {
  Widget? page;

  print('AuthRouter working  ${settings.name}');

  switch (settings.name) {
    case '/':
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
}
