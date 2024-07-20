import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zineapp2023/models/events.dart';

class PublicEventsRepo {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Events>> getEvents() async {
    var querySnapshot = await _firebaseFirestore
        .collection("publicEvents")
        .orderBy('timeDate', descending: false)
        .get();
    final docData = querySnapshot.docs.map((doc) => Events.store(doc));
    print("DocData $docData");
    return docData.toList();
  }
}
