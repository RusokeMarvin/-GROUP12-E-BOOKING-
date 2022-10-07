import 'package:bounce/main_page.dart';
import 'package:bounce/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:bounce/themes.dart';
import 'package:flutter/services.dart';
import 'package:bounce/userprofiles.dart';
import 'package:bounce/home.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'homefinal.dart';
import 'dart:ui';


Future<void> main() async {
  await SentryFlutter.init(
    (options) => options.dsn = 'https://examplePublicKey@o0.ingest.sentry.io/0',
    appRunner: () => runApp(MyApp()),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await UserPreferences.init();

  runApp(MyApp());

  // or define SENTRY_DSN via Dart environment variable (--dart-define)
}












class MyApp extends StatelessWidget {
  static final String title = 'User Profile';

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();
    return ThemeProvider(
        initTheme: user.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
        child: Builder(
            builder: (context) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'M-BOOKINGS',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: home(),
                )));
  }
}
