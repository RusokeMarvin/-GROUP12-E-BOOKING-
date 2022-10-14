import 'package:flutter/material.dart';
//import 'package:flutter_web_paystack_popup/page/home.dart';

import 'notification/not1.dart';

void main() {
  runApp(const MyApp());
}

const String projectTitle = 'MAKE PAY TO BOOK';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: projectTitle,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LocalNotificationScreen(),
    );
  }
}
