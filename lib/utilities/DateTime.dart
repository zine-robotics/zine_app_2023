import 'package:cloud_firestore/cloud_firestore.dart';

String getTime(Timestamp timeStamp) {
  return '${timeStamp.toDate().hour}:${timeStamp.toDate().minute}';
}
