import 'package:bounce/main_page.dart';
import 'package:bounce/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:bounce/themes.dart';
import 'package:flutter/services.dart';
import 'package:bounce/userprofiles.dart';
import 'package:bounce/search.dart';
import 'package:bounce/smsemail.dart';
import 'category.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await UserPreferences.init();

  runApp(MyApp());
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
