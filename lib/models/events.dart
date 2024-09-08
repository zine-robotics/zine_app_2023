import 'package:cloud_firestore/cloud_firestore.dart';

class Events {
  String? name;
  String? description;
  String? venue;
  String? eventType;
  String? stage;
  String? isHeading;
  Timestamp? timeDate;
  String? image;
  String? recruitment;

  Events({this.name, this.description, this.venue, this.timeDate,this.isHeading,this.image,this.recruitment});

  Events.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    venue = json['venue'];
    timeDate = json['timeDate'];
    eventType = json['eventType'];
    stage = json['stage'];
    isHeading=json['isHeading'];
    image=json['image'];
    recruitment=json['recruitment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['venue'] = venue;
    data['time'] = timeDate;
    data['eventType'] = eventType;
    data['stage'] = stage;
    data['isHeading']=isHeading;
    data['image']=image;
    data['recruitment']=recruitment;
    return data;
  }

  Events.store(snapshot)
      : venue = snapshot.data()['venue'],
        description = snapshot.data()['description'],
        timeDate = snapshot.data()['timeDate'],
        name = snapshot.data()['name'],
        stage = snapshot.data()['stage'].toString() ,
        isHeading=snapshot.data()['isHeading'].toString(),
        image=snapshot.data()['image'].toString(),
        recruitment=snapshot.data()['recruitment'].toString(),
        eventType = snapshot.data()['eventType'];
}


//----------------------------------------lastSeen Api--------------------------------------//
class LastSeen {
  int? lastMessageTimestamp;
  int? unreadMessages;
  int? userLastSeen;

  LastSeen({this.lastMessageTimestamp, this.unreadMessages, this.userLastSeen});

  LastSeen.fromJson(Map<String, dynamic> json) {
    lastMessageTimestamp = json['lastMessageTimestamp'];
    unreadMessages = json['unreadMessages'];
    userLastSeen = json['userLastSeen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastMessageTimestamp'] = this.lastMessageTimestamp;
    data['unreadMessages'] = this.unreadMessages;
    data['userLastSeen'] = this.userLastSeen;
    return data;
  }
}
