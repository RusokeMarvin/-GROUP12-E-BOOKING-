//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' show File, Platform;
import 'package:http/http.dart' as http;

import 'package:rxdart/subjects.dart';
//import 'package:timezone/data/latest.dart' as tz;

//import 'package:flutter/material.dart';
//import 'package:flutter_web_paystack_popup/notification/nort2.dart';
//mport 'package:flutter_web_paystack_popup/notification/nort3.dart';

class NotificationPlugin {
  //
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final BehaviorSubject<ReceivedNotification>
      didReceivedLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();
  var initializationSettings;

  NotificationPlugin._() {
    init();
  }

  init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isAndroid) {
      //_requestIOSPermission();
    }
    initializePlatformSpecifics();
  }

  initializePlatformSpecifics() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_notf_icon');

    initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
  }

  showNotificationWithAttachment() {}

  showNotification() {}

  void setListenerForLowerVersions(
      Function(ReceivedNotification receivedNotification)
          onNotificationInLowerVersions) {}

  void setOnNotificationClick(Function(String payload) onNotificationClick) {}

  //_requestIOSPermission() {
  //flutterLocalNotificationsPlugin
  //.resolvePlatformSpecificImplementation<
  // IOSFlutterLocalNotificationsPlugin>()
  //.requestPermissions(
  //alert: false,
  //badge: true,
  //sound: true,
  // );
}

setListenerForLowerVersions(Function onNotificationInLowerVersions) {
  // didReceivedLocalNotificationSubject.listen((receivedNotification) {
  // ignore: prefer_typing_uninitialized_variables
  var receivedNotification;
  onNotificationInLowerVersions(receivedNotification);
}

setOnNotificationClick(Function onNotificationClick) async {
  // ignore: prefer_typing_uninitialized_variables
  var initializationSettings;
  // ignore: prefer_typing_uninitialized_variables
  var flutterLocalNotificationsPlugin;
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    onNotificationClick(payload);
  });
}

Future<void> showNotification() async {
  var androidChannelSpecifics = const AndroidNotificationDetails(
    'CHANNEL_ID',
    'CHANNEL_NAME',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    timeoutAfter: 5000,
    styleInformation: DefaultStyleInformation(true, true),
  );

  var platformChannelSpecifics =
      NotificationDetails(android: androidChannelSpecifics);
  // ignore: prefer_typing_uninitialized_variables
  var flutterLocalNotificationsPlugin;
  await flutterLocalNotificationsPlugin.show(
    0,
    'Test Title',
    'Test Body', //null
    platformChannelSpecifics,
    payload: 'New Payload',
  );
}

Future<void> showDailyAtTime() async {
  var time = const Time(21, 3, 0);
  var androidChannelSpecifics = const AndroidNotificationDetails(
    'CHANNEL_ID 4',
    'CHANNEL_NAME 4',
    importance: Importance.max,
    priority: Priority.high,
  );
  var platformChannelSpecifics =
      NotificationDetails(android: androidChannelSpecifics);
  // ignore: prefer_typing_uninitialized_variables
  var flutterLocalNotificationsPlugin;
  await flutterLocalNotificationsPlugin.showDailyAtTime(
    0,
    'Test Title at ${time.hour}:${time.minute}.${time.second}',
    'Test Body', //null
    time,
    platformChannelSpecifics,
    payload: 'Test Payload',
  );
}

Future<void> showWeeklyAtDayTime() async {
  var time = const Time(21, 5, 0);
  var androidChannelSpecifics = const AndroidNotificationDetails(
    'CHANNEL_ID 5',
    'CHANNEL_NAME 5',
    importance: Importance.max,
    priority: Priority.high,
  );
  var platformChannelSpecifics =
      NotificationDetails(android: androidChannelSpecifics);
  // ignore: prefer_typing_uninitialized_variables
  var flutterLocalNotificationsPlugin;
  await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
    0,
    'Test Title at ${time.hour}:${time.minute}.${time.second}',
    'Test Body', //null
    Day.saturday,
    time,
    platformChannelSpecifics,
    payload: 'Test Payload',
  );
}

Future<void> repeatNotification() async {
  var androidChannelSpecifics = const AndroidNotificationDetails(
    'CHANNEL_ID 3',
    'CHANNEL_NAME 3',
    importance: Importance.max,
    priority: Priority.high,
    styleInformation: DefaultStyleInformation(true, true),
  );
  var platformChannelSpecifics =
      NotificationDetails(android: androidChannelSpecifics);
  // ignore: prefer_typing_uninitialized_variables
  var flutterLocalNotificationsPlugin;
  await flutterLocalNotificationsPlugin.periodicallyShow(
    0,
    'Repeating Test Title',
    'Repeating Test Body',
    RepeatInterval.everyMinute,
    platformChannelSpecifics,
    payload: 'Test Payload',
  );
}

Future<void> scheduleNotification() async {
  var scheduleNotificationDateTime =
      DateTime.now().add(const Duration(seconds: 5));
  var androidChannelSpecifics = const AndroidNotificationDetails(
    'CHANNEL_ID 1',
    'CHANNEL_NAME 1',
    icon: 'secondary_icon',
    sound: RawResourceAndroidNotificationSound('my_sound'),
    largeIcon: DrawableResourceAndroidBitmap('large_notf_icon'),
    enableLights: true,
    color: Color.fromARGB(255, 255, 0, 0),
    ledColor: Color.fromARGB(255, 255, 0, 0),
    ledOnMs: 1000,
    ledOffMs: 500,
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    timeoutAfter: 5000,
    styleInformation: DefaultStyleInformation(true, true),
  );
  var platformChannelSpecifics = NotificationDetails(
    android: androidChannelSpecifics,
  );
  // ignore: prefer_typing_uninitialized_variables
  var flutterLocalNotificationsPlugin;
  await flutterLocalNotificationsPlugin.schedule(
    0,
    'Test Title',
    'Test Body',
    scheduleNotificationDateTime,
    platformChannelSpecifics,
    payload: 'Test Payload',
  );
}

Future<void> showNotificationWithAttachment() async {
  var attachmentPicturePath = await _downloadAndSaveFile(
      'https://via.placeholder.com/800x200', 'attachment_img.jpg');
  var bigPictureStyleInformation = BigPictureStyleInformation(
    FilePathAndroidBitmap(attachmentPicturePath),
    contentTitle: '<b>Attached Image</b>',
    htmlFormatContentTitle: true,
    summaryText: 'Test Image',
    htmlFormatSummaryText: true,
  );
  var androidChannelSpecifics = AndroidNotificationDetails(
    'CHANNEL ID 2',
    'CHANNEL NAME 2',
    importance: Importance.high,
    priority: Priority.high,
    styleInformation: bigPictureStyleInformation,
  );
  var notificationDetails =
      NotificationDetails(android: androidChannelSpecifics);
  // ignore: prefer_typing_uninitialized_variables
  var flutterLocalNotificationsPlugin;
  await flutterLocalNotificationsPlugin.show(
    0,
    'Title with attachment',
    'Body with Attachment',
    notificationDetails,
  );
}

_downloadAndSaveFile(String url, String fileName) async {
  var directory = await getApplicationDocumentsDirectory();
  var filePath = '${directory.path}/$fileName';
  var response = await http
      .get(Uri.parse('https://paystack.com/pay/hob')); // some http toredirect
  var file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

Future<int> getPendingNotificationCount() async {
  // ignore: prefer_typing_uninitialized_variables
  var flutterLocalNotificationsPlugin;
  List<PendingNotificationRequest> p =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  return p.length;
}

Future<void> cancelNotification() async {
  var flutterLocalNotificationsPlugin;
  await flutterLocalNotificationsPlugin.cancel(0);
}

Future<void> cancelAllNotification() async {
  // ignore: prefer_typing_uninitialized_variables
  var flutterLocalNotificationsPlugin;
  await flutterLocalNotificationsPlugin.cancelAll();
}

NotificationPlugin notificationPlugin = NotificationPlugin._();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}
