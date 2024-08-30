// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:zineapp2023/models/user.dart';
import '../common/data_store.dart';

class UserProv extends ChangeNotifier {
  final DataStore dataStore;

  bool _isLoggedIn = false;
  UserModel _currUser = UserModel();

  UserProv({required this.dataStore});

  bool get isLoggedIn => _isLoggedIn;

  // FirebaseMessaging fMessaging = FirebaseMessaging.instance;
  // final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Future<void> getFirebaseMessagingToken() async {
  //   await fMessaging.requestPermission();

  //   await fMessaging.getToken().then((t) {
  //     if (t != null) {
  //       _currUser.pushToken = t;
  //       // print('Push Token: $t');
  //       updatePushToken();
  //       fMessaging.subscribeToTopic("Announcements");
  //       for (var rooms in _currUser.rooms!) {
  //         fMessaging.subscribeToTopic(rooms);
  //       }
  //     }
  //   });

  // TODO- Create a Handler for ForeGround Messages
  // for handling foreground messages
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     // print('Got a message whilst in the foreground!');
  //     // print('Message data: ${message.data}');

  //     if (message.notification != null) {
  //       //   print(
  //       //       'Message also contained a notification: ${message.notification?.title}');
  //       // }
  //     }
  //   });
  // }

  // Future<void> updatePushToken() async {
  //   await _firebaseFirestore
  //       .collection('users')
  //       .doc(_currUser.uid)
  //       .update({'pushToken': _currUser.pushToken});
  // }

  void updateUserInfo(UserModel userModel) async {
    _isLoggedIn = true;

    _currUser = userModel;
    print(_currUser.type);
    await dataStore.setString("loggedIn", 'true');
    await dataStore.setString('uid', _currUser.uid.toString());
    // await getFirebaseMessagingToken();

    notifyListeners();
  }

  UserModel get getUserInfo => _currUser;

  void updateLast(String name) {
    _currUser.lastSeen[name] =  DateTime.now();
  }

  void logOut() {
    _isLoggedIn = false;
    // _currUser = UserModel();
    // notifyListeners();
  }

  // void updateLast(String name) {
  //   _currUser.lastSeen[name] = Timestamp.fromDate(DateTime.now());
  // }
}
