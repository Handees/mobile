import 'dart:io';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handees/apps/customer_app/features/home/providers/home.provider.dart';

import 'package:handees/shared/routes/routers.dart';
import 'package:handees/shared/services/auth_service.dart';
import 'package:handees/shared/services/user_data_service.dart';

import 'firebase_options.dart';
import 'shared/theme/theme.dart';

import 'package:stack_trace/stack_trace.dart' as stack_trace;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  GoogleFonts.config.allowRuntimeFetching = false;

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
  ));

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };

  // All async calls that must be made to allow the app function properly should be put here

  // START

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FirebaseAppCheck.
  await FirebaseAppCheck.instance.activate();

  // Get the firebase user object token
  await AuthService.instance.getToken();

  // Fetch the user object from the backend
  await UserDataService.instance.getUser();

  // END
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNotifier = ref.read(userProvider.notifier);
    if (AuthService.isAuthenticated()) {
      userNotifier.getUserObject().then((_) {
        FlutterNativeSplash.remove();
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Handees',
      theme: buildTheme(lightColorScheme),
      // darkTheme: darkTheme,

      onGenerateRoute: mainRouter.onGenerateRoute,
      key: mainRouter.navigatorKey,
    );
  }
}
