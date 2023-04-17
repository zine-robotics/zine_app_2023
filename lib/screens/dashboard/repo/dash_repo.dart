import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zineapp2023/api.dart';
import 'package:zineapp2023/providers/user_info.dart';
import '../../../models/events.dart';
import 'package:intl/intl.dart';

class DashRepo {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Events>> getLatestEvents() async {
    DateTime currentDate = DateTime.now();
    Timestamp formattedDate = Timestamp.fromDate(currentDate);
    print('get events called');
    var querySnapshot = await _firebaseFirestore
        .collection("events")
        .where('timeDate', isGreaterThanOrEqualTo: formattedDate)
        .get();
    final _docData = querySnapshot.docs.map((doc) => Events.store(doc));
    return _docData.toList();
  }

  Future<void> launchUrlStart({required String url}) async {
    if (url.length == 0) return;
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
