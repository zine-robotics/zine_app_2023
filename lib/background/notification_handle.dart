import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


//------------------------------local notification plugin setup-----------------------------------//
Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

//--------------------------------show foreground notification------------------------------------//
Future<void> _showNotification({String? title, String? body}) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
  );
  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    title,
    body,
    platformChannelSpecifics,
    payload: 'item x',
  );
}

//-------------------------------------listen notification by FCM--------------------------//
void setupForegroundMessageListener() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print("message data:${message.notification}");
    if (message.notification != null) {
      await _showNotification(
        title: message.notification!.title,
        body: message.notification!.body,
      );
    }
  });
}