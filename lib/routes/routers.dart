import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:handees/customer_app/services/auth_service.dart';
import 'package:handees/routes/auth/router.dart';
import 'package:handees/routes/customer_app/router.dart';
import 'package:handees/theme/theme.dart';
import 'auth/routes.dart';
import 'customer_app/routes.dart';
import 'pages.dart';

Route<dynamic> mainRouter(RouteSettings settings) {
  print('MainRouter working  ${settings.name}');

  return MaterialPageRoute(
    builder: (context) => AuthService.instance.isAuthenticated() &&
            AuthService.instance.isProfileComplete()
        ? Navigator(
            onGenerateRoute: customerAppRouter,
          )
        : Navigator(
            onGenerateRoute: authRouter,
          ),
  );
}

// final mainRouter = GoRouter(

//   routes: [
//     GoRoute(
//       path: 'auth',
//       builder: (context, state) => Navigator(onGenerateRoute: authRouter),
//     ),
//     GoRoute(
//       path: 'customer',
//       builder: (context, state) =>
//           Navigator(onGenerateRoute: customerAppRouter),
//     ),
//     // GoRoute(
//     //   path: 'artisan',
//     //   builder: (context, state) =>
//     //       Navigator(onGenerateRoute: ),
//     // ),
//   ],
//   redirect: (context, state) async {
//     return 
//   },
// );
