import 'package:flutter/cupertino.dart';
import 'package:zineapp2023/models/events.dart';
import 'package:zineapp2023/screens/dashboard/repo/dash_repo.dart';
import 'package:zineapp2023/screens/events/repo/events_repo.dart';

import '../../../common/routing.dart';

class TimelineVm extends ChangeNotifier {
  final EventsRepo eventRepo = EventsRepo();
  List<dynamic> listEvents = [];
  bool isLoading = false;
  var prev = 0;

  Future<dynamic> routeMe(BuildContext context, String route) async {
    switch (route) {
      case RouteName.teamScreen:
        await Navigator.of(context).push(Routes.teamScreen());
        break;
      case RouteName.aboutMe:
        await Navigator.of(context).push(Routes.aboutMe());
        break;
      case RouteName.projectScreen:
        await Navigator.of(context).push(Routes.projectScreen());
        break;
      case RouteName.achievementScreen:
        await Navigator.of(context).push(Routes.achievementScreen());
        break;
      case RouteName.wokrshopTimeline:
        await Navigator.of(context).push(Routes.workshopTimeline());
        break;
    }
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void getStagesEvents() async {
    setLoading(true);
    List<Events> list = await eventRepo.getEvents();

    listEvents = [];

    for (int i = 1; i <= list.length; i++) {
      List<dynamic>? subList = list
          .where((element) => element.stage == i.toString())
          .where((element) => element.recruitment == 'true')
          .toList();

      if (subList != null) {
        listEvents.add(subList);
      } else {
        listEvents.add([]);
      }
    }
    setLoading(false);

    if (prev != listEvents.length) {
      prev = listEvents.length;
      notifyListeners();
    }
  }
}
