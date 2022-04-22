import 'package:flutter/material.dart';
import 'package:handee/screens/booking_details.dart';

import 'package:handee/screens/home_screen.dart';
import 'package:handee/screens/landing_page.dart';
import 'package:handee/screens/signin_page.dart';
import 'package:handee/screens/signup_page.dart';
import 'package:handee/screens/top_rated.dart';

// void main() {
//   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//     statusBarColor: HandeeColors.white,
//   ));
//   runApp(const MyApp());
// }

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const HomeScreen(),
      // const LandingPage(),
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.copyWith(
              titleMedium: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
      ),
      onGenerateRoute: (settings) {
        if (settings.name == SigninPage.routeName) {
          return MaterialPageRoute(
            builder: (_) => SigninPage(),
          );
        }
        if (settings.name == SignupPage.routeName) {
          return MaterialPageRoute(
            builder: (_) => SignupPage(),
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
        // if (settings.name == ServicePage.routeName) {
        //   return CupertinoPageRoute(
        //     builder: (_) => ServicePage(),
        //   );
        // }
        return null;
      },
    );
  }
}
