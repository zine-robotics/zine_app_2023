import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/events.dart';

class DashRepo {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Events>> getLatestEvents() async {
    DateTime currentDate = DateTime.now();
    Timestamp formattedDate = Timestamp.fromDate(currentDate);
    // print('get events called');
    var querySnapshot = await _firebaseFirestore
        .collection("events")
        .where('timeDate', isGreaterThanOrEqualTo: formattedDate)
        .get();
    final docData = querySnapshot.docs.map((doc) => Events.store(doc));
    return docData.toList();
  }

  Future<void> launchUrlStart({required String url}) async {
    if (url.isEmpty) return;
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
