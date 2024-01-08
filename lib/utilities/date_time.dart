import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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

