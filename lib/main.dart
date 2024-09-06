import 'package:flutter/material.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

import './screens/onboarding/splash/splash.dart';
import './app_providers.dart';
import './common/data_store.dart';
import './providers/dictionary.dart';
import './providers/user_info.dart';
import './common/navigator.dart';

final Language _language = Language();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _language.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // await FlutterNotificationChannel.registerNotificationChannel(
  //     description: 'For Showing Message Notification',
  //     id: 'chats',
  //     importance: NotificationImportance.IMPORTANCE_HIGH,
  //     name: 'Chats');
  // log('\nNotification Channel Result: $result');
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: true,
    provisional: false,
    sound: true,
  );
  await messaging.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    // print('Got a message whilst in the foreground!');
    // print('Message data: ${message.data}');

    if (message.notification != null) {
      print(
          'Message also contained a notification: ${message.notification?.title}');
    }
  });

  // ignore: unused_local_variable
  DataStore store = DefaultStore();
  UserProv userProv = UserProv(dataStore: store);
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  runApp(MyApp(store: store, userProv: userProv, secureStorage: secureStorage));
}

class MyApp extends StatelessWidget {
  final DataStore store;
  final UserProv userProv;
  final FlutterSecureStorage secureStorage;

  const MyApp(
      {super.key,
      required this.store,
      required this.userProv,
      required this.secureStorage});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      language: _language,
      userProv: userProv,
      store: store,
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        title: 'Zine',
        theme: ThemeData(
            fontFamily: 'Poppins',
            primarySwatch: Colors.blue,
            useMaterial3: false),
        home: const SplashScreen(),
      ),
    );
  }
}
