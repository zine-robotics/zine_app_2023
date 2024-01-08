import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/screens/onboarding/repo/auth_repo.dart';

import '../common/data_store.dart';

class UserProv extends ChangeNotifier {
  final DataStore dataStore;

  bool _isLoggedIn = false;
  UserModel currUser = UserModel();

  UserProv({required this.dataStore});

  bool get isLoggedIn => _isLoggedIn;

  FirebaseMessaging fMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();


    await fMessaging.getToken().then((t) {
      if (t != null && currUser != null) {
        currUser.pushToken = t;
        print('Push Token: $t');
        updatePushToken();
        fMessaging.subscribeToTopic("Announcements");
        for (var rooms in currUser.rooms!) {
          fMessaging.subscribeToTopic(rooms);
        }
      }
    });

    // for handling foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print(
            'Message also contained a notification: ${message.notification?.title}');
      }
    });
  }

  Future<void> updatePushToken() async {
    await _firebaseFirestore
        .collection('users')
        .doc(currUser.uid)
        .update({'pushToken': currUser.pushToken});
  }

  void updateUserInfo(UserModel userModel) async {
    _isLoggedIn = true;

    currUser = userModel;
    print(currUser.type);
    await dataStore.setString("loggedIn", 'true');
    await dataStore.setString('uid', currUser.uid.toString());
    await getFirebaseMessagingToken();

    notifyListeners();
  }

  dynamic getUserInfo() {
    return currUser;
  }

  void updateLast(String name) {
    currUser.lastSeen[name] = Timestamp.fromDate(DateTime.now());
  }
}
