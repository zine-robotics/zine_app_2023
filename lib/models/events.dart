import 'package:cloud_firestore/cloud_firestore.dart';

class Events {
  String? name;
  String? description;
  String? venue;
  String? eventType;
  int? stage;
  Timestamp? timeDate;

  Events({this.name, this.description, this.venue, this.timeDate});

  Events.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    venue = json['venue'];
    timeDate = json['timeDate'];
    eventType = json['eventType'];
    stage=json['stage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['venue'] = venue;
    data['time'] = timeDate;
    data['eventType'] = eventType;
    data['stage']=stage;
    return data;
  }

  Events.store(snapshot)
      : venue = snapshot.data()['venue'],
        description = snapshot.data()['description'],
        timeDate = snapshot.data()['timeDate'],
        name = snapshot.data()['name'],
        stage=snapshot.data()['stage'],
        eventType = snapshot.data()['eventType'];
}
