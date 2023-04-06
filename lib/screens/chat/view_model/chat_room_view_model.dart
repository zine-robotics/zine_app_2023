import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:zineapp2023/models/message.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/utilities/DateTime.dart';

import '../repo/chat_repo.dart';

class ChatRoomViewModel extends ChangeNotifier {
  final chatP = ChatRepo();

  dynamic allData;

  String _roomId = "Hn9GSQnvi5zh9wabLGuT";
  final name = "Announcement";
  Map<String, dynamic> chatSubscription = {};

  get roomId => _roomId;
  Map<String, Timestamp> lastChats = {};
  final CollectionReference _rooms =
      FirebaseFirestore.instance.collection('rooms');

  void setRoomId(String value) {
    _roomId = value;
  }

  var _data;

  get data => _data;

  String _text = "";

  get text => _text;

  void setText(String value) {
    _text = value;
  }

  void getChats() async {
    allData = await chatP.getChatStream(_roomId);
  }

  void listenChanges(String name) {
    var id = null;
    print(chatSubscription[name]);
    if (chatSubscription[name] == null) {
      _rooms
          .where("name", isEqualTo: name)
          .limit(1)
          .get()
          .then((value) => id = value.docs[0].id)
          .catchError((e) => {print(e)})
          .whenComplete(() => {
                if (id != null)
                  {
                    chatSubscription[name] = _rooms
                        .doc(id)
                        .collection("messages")
                        .snapshots()
                        .listen((QuerySnapshot snapshot) {
                      snapshot.docChanges.forEach((DocumentChange change) {
                        if (change.type == DocumentChangeType.added) {
                          print("added");
                          notifyListeners();
                        } else if (change.type == DocumentChangeType.modified) {
                          print("modified");
                          notifyListeners();
                        } else if (change.type == DocumentChangeType.removed) {
                          notifyListeners();
                        }
                      });
                    })
                  }
              });
    }
  }

  Stream<QuerySnapshot<Object?>> getData(roomName) async* {
    // print(roomName);
    allData = await chatP.getChatStream(roomName);
    yield* allData;
  }

  void send({from, roomId}) {
    // getChats();
    _text.isEmpty ? null : chatP.sendMessage(from, roomId, _text);
    setText("");
    notifyListeners();
  }

  String _lastChatTime = "";

  get lastChatTime => _lastChatTime;

  void setTimeChat(String value) {
    _lastChatTime = value;
  }

  bool rederDate(var index) {
    return false;
  }

  dynamic getLastMessages(String roomName) async {
    dynamic timeStamp = await chatP.getLastChat(roomName);
    if (Timestamp != null) {
      dynamic prev = lastChats;
      lastChats[roomName] = timeStamp;
      if (!mapEquals(lastChats, prev)) notifyListeners();
    } else {
      print("object");
      return null;
    }
  }

  bool unread(String name, UserModel user) {
    if (lastChats[name] != null) {
      if (user.lastSeen != null && user.lastSeen[name] != null) {
        return lastChats[name]!.compareTo(user.lastSeen[name]) > 0;
      }
    }
    return false;
  }

  String lastChatRoom(var name) {
    if (lastChats[name] != null) {
      var lastChat = getTime(lastChats[name] as Timestamp);
      return lastChat;
    }
    return "";
  }

  void roomLeft(var room, var user, UserProv userProv) {
    chatP.updateLastSeen(user, room);
    userProv.updateLast(room);
    notifyListeners();
    print('left ${room}');
  }

  void addRouteListener(
      BuildContext context, var room, var user, UserProv userProv) {
    ModalRoute.of(context)?.addScopedWillPopCallback(() {
      roomLeft(room, user, userProv);
      return Future.value(true);
    });
  }
}
