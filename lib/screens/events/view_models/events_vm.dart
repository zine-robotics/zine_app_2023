import "package:flutter/material.dart";
import 'package:zineapp2023/models/events.dart';
import 'package:zineapp2023/screens/events/repo/events_repo.dart';

class EventsVm extends ChangeNotifier {
  final eventRepo = EventsRepo();
  // EventsVm();
  List<Events> _events = [];
  dynamic prev = 0;
  bool isLoading = false;

  void setLoading(bool value){
    isLoading = value;
    notifyListeners();
  }

  get events => _events;

  void getAllEvents() async {
    _events = await eventRepo.getEvents();
    if (_events.length!=prev){
      notifyListeners();
      prev = _events.length;
    }
  }




}



