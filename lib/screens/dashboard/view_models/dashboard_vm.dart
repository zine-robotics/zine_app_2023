import "package:flutter/material.dart";
import 'package:table_calendar/table_calendar.dart';
import 'package:zineapp2023/models/events.dart';
import 'package:zineapp2023/screens/dashboard/repo/dash_repo.dart';

import '../../../common/data_store.dart';
import '../../../providers/user_info.dart';

class DashboardVm extends ChangeNotifier {
  final DataStore store;
  final UserProv userProv;
  List<Map<String, dynamic>> _eventsDate = [];
  final dashRepo = DashRepo();

  DashboardVm({required this.store, required this.userProv});
  List<Events> _events = [];

  dynamic prev=0;

  get events => _events;
  List<DateTime> highlightedDates = [];
  void getRecentEvent() async {
    _events = await dashRepo.getLatestEvents();
    if (_events.length!=prev){
      notifyListeners();
      prev = _events.length;
    }
  }

  List<Map<String, dynamic>> get eventsDate=>_eventsDate;
  //List<DateTime> get highlightDate=>highlightedDates;
  void getEventDate() async {
    _eventsDate=await dashRepo.getEventsDate();

    var eventDatess=eventsDate.map((event) => event['date']).toList();

    for (var eventDateString in eventDatess) {

      var dateParts = eventDateString.split(',');
      int year = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int day = int.parse(dateParts[2]);


      DateTime eventDate = DateTime.utc(year, month, day);
      highlightedDates.add(eventDate);

  }
    print(highlightedDates);


  }

 // Now contains DateTime objects from database
  bool isHighlightedDay(DateTime day) {
  return highlightedDates.any((date) => isSameDay(day, date));
  }

  void launchUrl(url) {
    dashRepo.launchUrlStart(url: url);
  }
}
