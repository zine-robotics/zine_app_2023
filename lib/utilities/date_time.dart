import 'package:cloud_firestore/cloud_firestore.dart';

String getTime(Timestamp timeStamp) {
  return '${timeStamp.toDate().hour}:${timeStamp.toDate().minute >= 10 ? timeStamp.toDate().minute : '0${timeStamp.toDate().minute}'}';
}

String getDate(Timestamp timeStamp) {
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  return '${timeStamp.toDate().day} ${months[timeStamp.toDate().month - 1]}';
}

List<int> getDMY(Timestamp tmp) {

  return [tmp.toDate().day, tmp.toDate().month, tmp.toDate().year];
}

String getDDMMYY(Timestamp timeStamp) {
  return '${timeStamp.toDate().day}-${timeStamp.toDate().month - 1}-${timeStamp.toDate().year}';
}
