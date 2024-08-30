import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

//===============================Newer CODE=========================================//
DateTime convertTimestamp(int timestamp) {
  if (timestamp > 1000000000) {
    // Convert from milliseconds
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  } else {
    // Convert from seconds
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }
}


String getChatTime(int timeStamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  return '${dateTime.hour}:${dateTime.minute >= 10 ? dateTime.minute : '0${dateTime.minute}'}';
}
String getChatDate(int timeStamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  List<String> months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUNE',
    'JULY',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ];
  return '${months[dateTime.month - 1]}';
}



//================================Older CODE========================================//





String getTime(Timestamp timeStamp) {
  return '${timeStamp.toDate().hour}:${timeStamp.toDate().minute >= 10 ? timeStamp.toDate().minute : '0${timeStamp.toDate().minute}'}';
}

String getDate(Timestamp timeStamp) {
  List<String> months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUNE',
    'JULY',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ];
  return '${months[timeStamp.toDate().month - 1]}';
}



String getDay(Timestamp timeStamp) {

  return '${timeStamp.toDate().day} ';
}


String getYear(Timestamp timeStamp) {

  return '${timeStamp.toDate().year} ';
}

List<int> getDMY(Timestamp tmp) {

  return [tmp.toDate().day, tmp.toDate().month, tmp.toDate().year];
}

String getDDMMYY(Timestamp timeStamp) {
  return '${timeStamp.toDate().year},${timeStamp.toDate().month - 1},${timeStamp.toDate().day}';
}

String getDDMMYY2(Timestamp timeStamp) {
  return '${timeStamp.toDate().year},${timeStamp.toDate().month},${timeStamp.toDate().day}';
}
String getDDate(DateTime dt)
{
  return '${new DateFormat("yyyy-MM-dd").format(dt)}';
}
