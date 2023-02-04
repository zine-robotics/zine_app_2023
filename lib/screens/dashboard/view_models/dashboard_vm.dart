import "package:flutter/material.dart";

import '../../../common/data_store.dart';
import '../../../providers/user_info.dart';

class DashboardVm extends ChangeNotifier {
  final DataStore store;
  final UserProv userProv;
  DashboardVm({required this.store, required this.userProv});

  String getData(String param) {
    String? data = store.getString(param);
    return data.toString();
  }

}
