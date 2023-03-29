import 'package:flutter/cupertino.dart';
import 'package:zineapp2023/models/events.dart';
import 'package:zineapp2023/screens/dashboard/repo/dash_repo.dart';
import 'package:zineapp2023/screens/events/repo/events_repo.dart';

class TimelineVm extends ChangeNotifier {
  final EventsRepo eventRepo = EventsRepo();
  List<dynamic> listEvents = [];
  var prev=0;
  void getStagesEvents() async {
    print("called");
    List<dynamic> list = await eventRepo.getEvents();
    listEvents=[];
    for (int i = 1; i <= 6; i++) {

      List<dynamic>? subList = list.where((element) => element.stage == i)
          .toList();
      if (subList != null) {
        listEvents.add(subList);
        // if(listEvents[i].length>0)
        // {
        //   print(listEvents[i][0].name);
        // }
      }
      else {
        listEvents.add([]);
      }
    }
    print(listEvents);
    if(prev!=listEvents.length) {
      prev=listEvents.length;
      notifyListeners();
    }
      }


}



