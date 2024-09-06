import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zineapp2023/models/temp_events.dart';
import 'package:zineapp2023/screens/events/repo/events_repo.dart';
import 'package:zineapp2023/screens/explore/public_events/repo/public_events_repo.dart';
import 'package:table_calendar/src/shared/utils.dart';
import 'package:zineapp2023/models/events.dart';

class PublicEventsVM extends ChangeNotifier {
  // final PublicEventsRepo peRepo = PublicEventsRepo();
  final EventsRepo eventsRepo = EventsRepo();
  List<TempEvents> _events = [];

  TempEvents _selectedEvent = TempEvents(
      name: 'null',
      startDateTime:
          DateTime.now().millisecondsSinceEpoch); //defualt Selected Event
  int _selectedIndex = -1;
  bool _isLoaded = false;
  bool _isError = false;

  void loadEvents() async {
    if (_isLoaded) return;
    try {
      List<TempEvents> tempEvents = await eventsRepo.fetchEvents();
      _events = tempEvents;
    } catch (e) {
      print("Error $e");
      _isError = true;
    }

    // try {
    //   List<Events> fireEvents = await peRepo.getEvents();
    //   _events = fireEvents;
    // } catch (e) {
    //   print("Error $e");
    //   _isError = true;
    // }
    _isLoaded = true;

    notifyListeners();
  }

  void selectEvent(DateTime selectedDay, DateTime focusedDay) {
    var index = _events.indexWhere((event) => isSameDay(
        DateTime.fromMillisecondsSinceEpoch(event.startDateTime!),
        selectedDay));
    if (index >= 0) {
      _selectedEvent = _events[index];
      _selectedIndex = index;
    }
    notifyListeners();
  }

  void selectEventIndex(int index) {
    _selectedEvent = _events[index];
    _selectedIndex = index;
    notifyListeners();
  }

  TempEvents get selectedEvent => _selectedEvent;
  int get selectedIndex => _selectedIndex;

  bool get isError => _isError;
  bool get isLoaded => _isLoaded;
  List<TempEvents> get events => _events;

  DateTime getLastEventDate() {
    if (_events.isEmpty) return DateTime.now();
    List<TempEvents> evCopy = List.from(_events);
    evCopy.sort((ev1, ev2) => ev1.startDateTime!.compareTo(ev2.startDateTime!));
    return DateTime.fromMillisecondsSinceEpoch(evCopy.last.startDateTime!);
  }

  DateTime getFirstEventDate() {
    if (_events.isEmpty) return DateTime.now();
    List<TempEvents> evCopy = List.from(_events);
    evCopy.sort((ev1, ev2) => ev2.startDateTime!.compareTo(ev1.startDateTime!));
    return DateTime.fromMillisecondsSinceEpoch(evCopy.last.startDateTime!);
  }

  List<TempEvents> getEvents(DateTime day) => _events
      .where((event) => isSameDay(
          DateTime.fromMillisecondsSinceEpoch(event.startDateTime!), day))
      .toList();
}
