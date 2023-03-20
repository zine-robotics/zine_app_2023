import "package:flutter/material.dart";
import 'package:zineapp2023/models/events.dart';
import 'package:zineapp2023/screens/dashboard/repo/dash_repo.dart';

import '../../../common/data_store.dart';
import '../../../providers/user_info.dart';

class DashboardVm extends ChangeNotifier {
  final DataStore store;
  final UserProv userProv;
  final dashRepo = DashRepo();
  DashboardVm({required this.store, required this.userProv});
  List<Events> _events = [];

  get events => _events;

  String getData(String param) {
    String? data = store.getString(param);
    return data.toString();
  }

  void getRecentEvent() async {
    _events = await dashRepo.getEvents();
    notifyListeners();
  }

  void launchUrl(url) {
    dashRepo.launchUrlStart(url: url);
  }
}
