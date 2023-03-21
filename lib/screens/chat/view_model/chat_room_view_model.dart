import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:zineapp2023/models/message.dart';
import 'package:zineapp2023/utilities/DateTime.dart';

import '../repo/chat_repo.dart';

class ChatRoomViewModel extends ChangeNotifier {
  final chatP = ChatRepo();

  dynamic allData;

  String _roomId = "Hn9GSQnvi5zh9wabLGuT";
  final name = "Announcement";

  get roomId => _roomId;

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

  void getRoomId() async {}

  Stream<QuerySnapshot<Object?>> getData(roomName) async* {
    print(roomName);
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

  dynamic getLastMessage(String roomName) {
    print(chatP.getLastChat(roomName));
    if (chatP.getLastChat(roomName) != null) {
      chatP.getLastChat(roomName).then((value) {
        setTimeChat(getTime(value.timeStamp!));
        print(chatP.getLastChat(roomName));
        return getTime(value.timeStamp!);
        // notifyListeners();
      });
    } else {
      setTimeChat("00:00");
      return "--";
      // notifyListeners();
    }

    // return "00";
  }
}
