import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zineapp2023/models/temp_events.dart';
import '../../../models/events.dart';
import 'package:http/http.dart'as http;

class EventsRepo {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  dynamic getEvents() async {
    var querySnapshot = await _firebaseFirestore
        .collection("events")
        .orderBy('timeDate', descending: false)
        .get();
    final docData = querySnapshot.docs.map((doc) => Events.store(doc));
    return docData.toList();
  }
  //==================================================NEWER CODE=======================================//
  Future<List<TempEvents>> fetchEvents() async {
    try {
      String url = "http://ec2-18-116-38-241.us-east-2.compute.amazonaws.com/event";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String,dynamic>  jsonResponse = jsonDecode(response.body);
        List<dynamic> eventJson=jsonResponse['events'];
        List<TempEvents> events = eventJson.map((json) => TempEvents.fromJson(json)).toList();
        // print("inside the chat_repo and message:${messages.toList()}");
        return events;
      } else {
        print("Failed to load messages: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("An error occurred: $e");
      return [];
    }
  }

}
