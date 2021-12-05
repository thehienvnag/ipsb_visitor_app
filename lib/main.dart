import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ipsb_visitor_app/src/common/app_init.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/common/strings.dart';
import 'package:ipsb_visitor_app/src/routes/app_pages.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ipsb_visitor_app/src/utils/firebase_helper.dart';

Future _showNotificationWithDefaultSound(String? title, String? message) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    channelDescription: 'channel_description',
    importance: Importance.max,
    priority: Priority.high,
  );
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await FirebaseHelper.flutterLocalNotificationInstance()
      .show(
        0,
        '$title',
        '$message',
        platformChannelSpecifics,
        payload: 'Default_Sound',
      )
      .then((value) => Future.delayed(const Duration(seconds: 2), () {
            FirebaseHelper.flutterLocalNotificationInstance().cancel(0);
          }));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage? message) async {
  if (message?.data != null) {
    await _showNotificationWithDefaultSound(
        message?.notification?.title, message?.notification?.body);
  }

  print("Handling a background message: ${message?.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  AppInit.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Strings.appName,
      builder: BotToastInit(),
      theme: ThemeData(fontFamily: Fonts.montserrat),
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      getPages: AppPages.routes,
    );
  }
}
