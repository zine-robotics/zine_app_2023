import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:zineapp2023/models/events.dart';
import 'package:zineapp2023/screens/events/repo/events_repo.dart';

class EventsVm extends ChangeNotifier {
  final eventRepo = EventsRepo();

  List<Events> _events = [];
  dynamic prev = 0;
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  get events => _events;

  void getAllEvents() async {
    _events = await eventRepo.getEvents();
    int index = _events.indexWhere(
        (element) => element.timeDate!.compareTo(Timestamp.now()) > 0);
    print(index);
    if (index != -1) {
      List<Events> secondPart =
          _events.sublist(index + 1, _events.length).reversed.toList();
      List<Events> firstPart = _events.sublist(0, index + 1);

      _events = [...firstPart, ...secondPart];
    }

    if (_events.length != prev) {
      notifyListeners();
      prev = _events.length;
    }
  }
}
