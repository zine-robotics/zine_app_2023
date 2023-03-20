import 'package:cloud_firestore/cloud_firestore.dart';

String getTime(Timestamp timeStamp) {
  return '${timeStamp.toDate().hour}:${timeStamp.toDate().minute >= 10 ? timeStamp.toDate().minute : '0' + timeStamp.toDate().minute.toString()}';
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
  return '${timeStamp.toDate().day} ${months[timeStamp.toDate().month]}';
}
