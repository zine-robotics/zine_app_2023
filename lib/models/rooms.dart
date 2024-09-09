class Rooms {
  int? id;
  String? name;
  String? description;
  String? type;
  String? dpUrl;
  int? timestamp;
  int? lastMessageTimestamp;
  int? unreadMessages;
  int? userLastSeen;

  Rooms({
    this.id,
    this.name,
    this.description,
    this.type,
    this.dpUrl,
    this.timestamp,
    this.lastMessageTimestamp,
    this.unreadMessages,
    this.userLastSeen,
  });

  Rooms.fromJson(Map<String, dynamic> json) {
    id = json['room']['id'];
    name = json['room']['name'];
    description = json['room']['description'];
    type = json['room']['type'];
    dpUrl = json['room']['dpUrl'];
    timestamp = json['room']['timestamp'];
    lastMessageTimestamp = json['lastMessageTimestamp'];
    unreadMessages = json['unreadMessages'];
    userLastSeen = json['userLastSeen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['room'] = {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'dpUrl': dpUrl,
      'timestamp': timestamp,
    };

    data['lastMessageTimestamp'] = lastMessageTimestamp;
    data['unreadMessages'] = unreadMessages;
    data['userLastSeen'] = userLastSeen;

    return data;
  }

  // If storing from Firestore snapshot
  Rooms.store(snapshot)
      : id = snapshot.data()['id'],
        name = snapshot.data()['name'],
        description = snapshot.data()['description'],
        type = snapshot.data()['type'],
        dpUrl = snapshot.data()['dpUrl'],
        timestamp = snapshot.data()['timestamp'],
        lastMessageTimestamp = snapshot.data()['lastMessageTimestamp'],
        unreadMessages = snapshot.data()['unreadMessages'],
        userLastSeen = snapshot.data()['userLastSeen'];
}

// class Announcement {
//   AnnouncementRoom? announcementRoom;
//
//   Announcement({this.announcementRoom});
//
//   Announcement.fromJson(Map<String, dynamic> json) {
//     announcementRoom = json['announcementRoom'] != null
//         ? new AnnouncementRoom.fromJson(json['announcementRoom'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.announcementRoom != null) {
//       data['announcementRoom'] = this.announcementRoom!.toJson();
//     }
//     return data;
//   }
// }
// //------------------------------------------announcement-----------------------------------//
// class AnnouncementRoom {
//   Room? room;
//   int? lastMessageTimestamp;
//   int? unreadMessages;
//   int? userLastSeen;
//
//   AnnouncementRoom(
//       {this.room,
//         this.lastMessageTimestamp,
//         this.unreadMessages,
//         this.userLastSeen});
//
//   AnnouncementRoom.fromJson(Map<String, dynamic> json) {
//     room = json['room'] != null ? new Room.fromJson(json['room']) : null;
//     lastMessageTimestamp = json['lastMessageTimestamp'];
//     unreadMessages = json['unreadMessages'];
//     userLastSeen = json['userLastSeen'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.room != null) {
//       data['room'] = this.room!.toJson();
//     }
//     data['lastMessageTimestamp'] = this.lastMessageTimestamp;
//     data['unreadMessages'] = this.unreadMessages;
//     data['userLastSeen'] = this.userLastSeen;
//     return data;
//   }
// }
//
// class Room {
//   int? id;
//   String? name;
//   Null? description;
//   String? type;
//   Null? dpUrl;
//   int? timestamp;
//
//   Room(
//       {this.id,
//         this.name,
//         this.description,
//         this.type,
//         this.dpUrl,
//         this.timestamp});
//
//   Room.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//     type = json['type'];
//     dpUrl = json['dpUrl'];
//     timestamp = json['timestamp'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['type'] = this.type;
//     data['dpUrl'] = this.dpUrl;
//     data['timestamp'] = this.timestamp;
//     return data;
//   }
// }