import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/events.dart';

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
}
