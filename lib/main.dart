import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handee/screens/booking_details.dart';

import 'package:handee/screens/main_screen.dart';
import 'package:handee/screens/auth_screen.dart';
import 'package:handee/screens/top_rated_screen.dart';
import 'package:handee/themes/dark_theme.dart';
import 'package:handee/themes/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handee',
      scrollBehavior: const CupertinoScrollBehavior(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return const MainScreen();
          }
          return const AuthScreen();
        },
      ),
      themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      onGenerateRoute: (settings) {
        if (settings.name == AuthScreen.routeName) {
          return MaterialPageRoute(
            builder: (_) => const AuthScreen(),
          );
        }
        if (settings.name == TopRatedScreen.routeName) {
          return MaterialPageRoute(
            builder: (_) => TopRatedScreen(),
          );
        }
        if (settings.name == TopRatedScreen.routeName) {
          return MaterialPageRoute(
            builder: (_) => TopRatedScreen(),
          );
        }
        if (settings.name == BookingDetailsScreen.routeName) {
          return MaterialPageRoute(
            builder: (_) => const BookingDetailsScreen(),
          );
        }
        return null;
      },
    );
  }
}
