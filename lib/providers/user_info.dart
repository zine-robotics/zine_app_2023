import 'package:flutter/material.dart';
import '../utilities/string_formatters.dart';

import '../common/data_store.dart';

class User extends ChangeNotifier {
  final DataStore _dataStore;
  bool _isLoggedIn = false;

  String name = "null";
  String email = "null";
  String uid = "null";
  String type = "null";

  User(this._dataStore);

  bool get isLoggedIn => _isLoggedIn;

  void updateUserInfo(
      String name,
      String email,
      String type,
      ) async {
    _isLoggedIn = true;
    name = name.toTitleCase();
    this.email = email;
    await _dataStore.setString("name", name);

    notifyListeners();
  }

  dynamic getUserInfo() {
    return {"name": name, "email": email};
  }
}
