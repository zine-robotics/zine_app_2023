import 'package:flutter/material.dart';
import 'package:zineapp2023/models/user.dart';

import '../common/data_store.dart';

class UserProv extends ChangeNotifier {
  final DataStore dataStore;
  bool _isLoggedIn = false;
  UserModel currUser = UserModel();

  UserProv({required this.dataStore});

  bool get isLoggedIn => _isLoggedIn;

  void updateUserInfo(UserModel userModel) async {
    _isLoggedIn = true;
    currUser = userModel;
    await dataStore.setString("loggedIn", 'true');
    await dataStore.setString('uid', currUser.uid.toString());

    notifyListeners();
  }

  dynamic getUserInfo() {
    return currUser;
  }
}
