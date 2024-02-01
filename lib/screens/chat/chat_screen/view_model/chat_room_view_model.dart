import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:zineapp2023/models/message.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/utilities/date_time.dart';

import '../../../../models/rooms.dart';
import '../repo/chat_repo.dart';

class ChatRoomViewModel extends ChangeNotifier {
  final UserProv userProv;
  ChatRoomViewModel({required this.userProv});
  final chatP = ChatRepo();

  dynamic allData;
  dynamic replyTo;
  FocusNode replyfocus = FocusNode();
  String _roomId = "Hn9GSQnvi5zh9wabLGuT";
  final name = "Announcement";
  Map<String, dynamic> chatSubscription = {};
  final picker = ImagePicker();
  dynamic selectedReplyMessage;

  get roomId => _roomId;
  Map<String, Timestamp> lastChats = {};
  final CollectionReference _rooms =
      FirebaseFirestore.instance.collection('rooms');

  void setRoomId(String value) {
    _roomId = value;
  }

  var _data;
  var _docData;

  get data => _data;

  String _text = "";

  get text => _text;

  void setText(String value) {
    _text = value;
  }

  void getChats() async {
    allData = await chatP.getChatStream(_roomId);
  }

  void replyText(dynamic message) {
    print("object");
    print(message);

    selectedReplyMessage = message;
    replyTo = message.id;
    print(replyTo);

    replyfocus.requestFocus();

    notifyListeners();
  }

  void cancelReply() {
    replyTo = null;
    print("repy to cancel");
    print(replyTo);
    notifyListeners();
  }

  dynamic getMessageById(List<MessageModel> chats, String replyTo) {
    Iterable<MessageModel> msg =
        chats.where((element) => element.id == replyTo);
    if (msg.isNotEmpty) {
      return msg.first;
    }
    return null;
  }

  List<dynamic> listOfUsers = [];

  void listenChanges(String name) {
    var id = null;
    // print(chatSubscription[name]);
    if (chatSubscription[name] == null) {
      _rooms
          .where("name", isEqualTo: name)
          .limit(1)
          .get()
          .then((value) => id = value.docs[0].id)
          .catchError((e) => {print(e)})
          .whenComplete(
            () => {
              if (id != null)
                {
                  chatSubscription[name] =
                      _rooms.doc(id).collection("messages").snapshots().listen(
                    (QuerySnapshot snapshot) {
                      for (var change in snapshot.docChanges) {
                        if (change.type == DocumentChangeType.added) {
                          // print("added");
                          notifyListeners();
                        } else if (change.type == DocumentChangeType.modified) {
                          // print("modified");
                          notifyListeners();
                        } else if (change.type == DocumentChangeType.removed) {
                          notifyListeners();
                        }
                      }
                    },
                  )
                }
            },
          );
    }
  }

  Stream<QuerySnapshot<Object?>> getData(roomName) async* {
    // print(roomName);
    allData = await chatP.getChatStream(roomName);
    yield* allData;
  }

  void send({from, roomId}) {
    // getChats();
    print("sending");
    print(replyTo);
    _text.isEmpty
        ? null
        : chatP.sendMessage(
            from, roomId, _text, replyTo, userProv!.currUser.uid.toString());
    replyTo = null;
    setText("");

    notifyListeners();
  }

  void updateMessage(DocumentReference docRef) async {
    await docRef.update({'replyTo': null});
  }

  void replyListner() {
    if (!replyfocus.hasFocus) replyTo = null;
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
    print("function Called");
    dynamic timeStamp = await chatP.getLastChat(roomName);
    dynamic prev = lastChats;
    print(lastChats);
    print(roomName);
    if (timeStamp != null) {
      lastChats[roomName] = timeStamp;
    }

    if (!mapEquals(lastChats, prev)) notifyListeners();
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
      DateTime t = (lastChats[name] as Timestamp).toDate();
      DateTime now = DateTime.now();
      var lastChat;
      if ((now.day == t.day && t.month == now.month && t.year == now.year))
        lastChat = getTime(lastChats[name] as Timestamp);
      else
        lastChat =
            t.day.toString() + " " + getDate(lastChats[name] as Timestamp);
      return lastChat;
    }
    return "";
  }

  void roomLeft(var room, var user, UserProv userProv) {
    chatP.updateLastSeen(user, room);
    userProv.updateLast(room);
    notifyListeners();
    print('left $room');
  }

  void addRouteListener(
      BuildContext context, var room, var user, UserProv userProv) {
    ModalRoute.of(context)?.addScopedWillPopCallback(() {
      roomLeft(room, user, userProv);
      return Future.value(true);
    });
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    dynamic imageFile;

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);

      await chatP.uploadImageToFirebase(imageFile);
    }
  }
}
