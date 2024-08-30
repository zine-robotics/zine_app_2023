import 'package:flutter/material.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import './screens/onboarding/splash/splash.dart';
import './app_providers.dart';
import './common/data_store.dart';
import './providers/dictionary.dart';
import './providers/user_info.dart';
import './common/navigator.dart';

final Language _language = Language();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _language.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FlutterNotificationChannel.registerNotificationChannel(
      description: 'For Showing Message Notification',
      id: 'chats',
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: 'Chats');
  // log('\nNotification Channel Result: $result');
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
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
