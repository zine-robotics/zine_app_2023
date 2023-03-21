import "package:flutter/material.dart";
import 'package:zineapp2023/models/events.dart';
import 'package:zineapp2023/screens/events/repo/events_repo.dart';

class EventsVm extends ChangeNotifier {
  final eventRepo = EventsRepo();
  EventsVm();
  List<Events> _events = [];

  get events => _events;

  void getAllEvents() async {
    _events = await eventRepo.getEvents();
    notifyListeners();
  }
}
