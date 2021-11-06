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
      flutterLocalNotificationInstance()
          .show(
              0,
              data.title,
              data.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                    'channel id', 'channel name',
                    channelDescription: 'channel desc',
                    icon: android?.smallIcon,
                    setAsGroupSummary: true,
                    importance: Importance.max,
                    priority: Priority.high),
                iOS: const IOSNotificationDetails(
                    presentAlert: true, presentSound: true),
              ),
              payload: 'referenceName')
          .then((value) => Future.delayed(const Duration(seconds: 2), () {
                FirebaseHelper.flutterLocalNotificationInstance().cancel(0);
              }));
      if (message.data['notificationType'] == 'coupon_changed' ||
          message.data['notificationType'] == 'coupon_in_use_changed') {
        unsubscribeFromTopic(
            "coupon_in_use_id_" + message.data['couponInUseId']);
      }
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
  }

  Future<void> subscribeToTopic(String topic) async {
    print(
        'FlutterFire Messaging Example: Subscribing to topic "' + topic + '".');
    await _messaging.subscribeToTopic(topic);
    print('FlutterFire Messaging Example: Subscribing to topic "' +
        topic +
        '" successful.');
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    print('FlutterFire Messaging Example: Unsubscribing from topic "' +
        topic +
        '".');
    await _messaging.unsubscribeFromTopic(topic);
    print('FlutterFire Messaging Example: Unsubscribing from topic "' +
        topic +
        '" successful.');
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
              Get.back();
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
    if (data['notificationType'] == 'coupon_changed') {
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
            child: const Text('GO TO COUPON'),
            onPressed: () {
              Get.back();
              Get.toNamed(
                Routes.couponDetail,
                parameters: {
                  "couponId": data['couponId'],
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
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['notificationType'] == 'shopping_list_changed') {
        Get.toNamed(
          Routes.shoppingListDetail,
          parameters: {
            "shoppingListId": message.data['shoppingListId'],
          },
        );
      }
      if (message.data['notificationType'] == 'coupon_changed') {
        Get.toNamed(
          Routes.couponDetail,
          parameters: {
            "couponId": message.data['couponId'],
          },
        );
      }
    });
  }
}
