import "package:flutter/material.dart";
import 'package:zineapp2023/common/data_store.dart';

class DashboardVm extends ChangeNotifier {
  final DataStore store;
  DashboardVm({required this.store});

  String getData(String param) {
    String? data = store.getString(param);
    return data!;
  }

  // get password => _password;

}
