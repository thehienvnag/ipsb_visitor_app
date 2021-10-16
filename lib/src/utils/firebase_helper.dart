import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';

class FirebaseHelper {
  static FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;

  String _fcmToken = "Get Firebase token";

  // static final _androidPlatformChannelSpecifics =
  //     new AndroidNotificationDetails('channel id', 'channel name',
  //         channelDescription: 'channel desc',
  //         importance: Importance.max,
  //         priority: Priority.high);
  //
  // static NotificationDetails platformSpecInstance() {
  //   return new NotificationDetails(android: _androidPlatformChannelSpecifics);
  // }

  static FlutterLocalNotificationsPlugin flutterLocalNotificationInstance() {
    if (_flutterLocalNotificationsPlugin == null) {
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    }
    return _flutterLocalNotificationsPlugin!;
  }

  Future _showNotification(RemoteMessage message) async {
    RemoteNotification? data = message.notification;

    AndroidNotification? android = message.notification?.android;
    if (data != null) {
      flutterLocalNotificationInstance().show(
          0,
          data.title,
          data.body,
          NotificationDetails(
            android: AndroidNotificationDetails('channel id', 'channel name',
                channelDescription: 'channel desc',
                icon: android?.smallIcon,
                setAsGroupSummary: true,
                importance: Importance.max,
                priority: Priority.high),
            iOS: const IOSNotificationDetails(
                presentAlert: true, presentSound: true),
          ),
          payload: 'referenceName');
      Get.dialog(_buildDialog(data.title, data.body, message.data));
    }
  }

  requestingPermissionForIOS() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: true,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  getToken() async {
    String? token = await _messaging.getToken();
    _fcmToken = token!;
    print("Token: " + _fcmToken);
  }

  Future<dynamic> _onSelectNotification(payload) async {
    // implement logic
    print('onSelectNotification: ' + payload);
  }

  void initPushNotification() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: iosInitializationSettings);

    flutterLocalNotificationInstance().initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);

    FirebaseMessaging.onMessage.listen((message) {
      _showNotification(message);
    });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new onMessageOpenedApp event was published!');
    //   if (message.data['notificationType'] == 'shopping_list_changed') {
    //     Get.toNamed(
    //       Routes.shoppingListDetail,
    //       parameters: {
    //         "shoppingListId": message.data['shoppingListId'],
    //       },
    //     );
    //   }
    // });
  }

  Future<void> subscribeToTopic(String topic) async {
    print('FlutterFire Messaging Example: Subscribing to topic "fcm_test".');
    await _messaging.subscribeToTopic(topic);
    print(
        'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.');
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    print(
        'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".');
    await _messaging.unsubscribeFromTopic(topic);
    print(
        'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.');
  }

  Widget _buildDialog(String? title, String? body, Map<String, dynamic> data) {
    if (data['notificationType'] == 'shopping_list_changed') {
      return AlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: <Widget>[
          FlatButton(
            child: const Text('CLOSE'),
            onPressed: () {
              Get.back();
            },
          ),
          FlatButton(
            child: const Text('GO TO SHOPPING LIST'),
            onPressed: () {
              Get.toNamed(
                Routes.shoppingListDetail,
                parameters: {
                  "shoppingListId": data['shoppingListId'],
                },
              );
            },
          ),
        ],
      );
    }
    return AlertDialog(
      title: Text(title!),
      content: Text(body!),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    // RemoteMessage? initialMessage =
    //     await _messaging.getInitialMessage();
    //
    // // If the message also contains a data property with a "type" of "chat",
    // // navigate to a chat screen
    // if (initialMessage != null) {
    //   _handleMessage(initialMessage);
    // }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['notificationType'] == 'shopping_list_changed') {
        Get.toNamed(
          Routes.shoppingListDetail,
          parameters: {
            "shoppingListId": message.data['shoppingListId'],
          },
        );
      }
    });
  }

  // Future<void> setupInteractedMessageWhenAppIsKilled() async {
  //   _messaging.getInitialMessage().then((RemoteMessage? message) => {
  //         if (message != null)
  //           {
  //             if (message.data['notificationType'] == 'shopping_list_changed')
  //               {
  //                 Get.toNamed(
  //                   Routes.shoppingListDetail,
  //                   parameters: {
  //                     "shoppingListId": message.data['shoppingListId'],
  //                   },
  //                 )
  //               }
  //           }
  //       });
  // }
}
