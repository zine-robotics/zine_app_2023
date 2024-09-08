import 'package:flutter/material.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:zineapp2023/background/firebase_setup.dart';
import 'package:zineapp2023/background/notification_handle.dart';
import 'firebase_options.dart';

import './screens/onboarding/splash/splash.dart';
import './app_providers.dart';
import './common/data_store.dart';
import './providers/dictionary.dart';
import './providers/user_info.dart';
import './common/navigator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final Language _language = Language();


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _language.init();
  await initializeFirebase();
  await initializeNotifications();
  setupForegroundMessageListener();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
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

