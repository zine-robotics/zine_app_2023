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
    print(allData.length);
    print("current messages");
  }

  void getData() {
    _data = chatP.getChatStream(_roomId);
  }

  final from = "Rupesh Yadav";
  final userType = 'admin';

  void send() {
    // getChats();
    _text.isEmpty ? null : chatP.sendMessage(from, _roomId, _text);
    setText("");
    print(_text);
    notifyListeners();
  }

  String _lastChatTime = "";

  get lastChatTime => _lastChatTime;

  void setTimeChat(String value) {
    _lastChatTime = value;
  }

  void getLastMessage() {
    chatP.getLastChat(roomId).then((value) {
      setTimeChat(getTime(value.timeStamp!));
      notifyListeners();
    });
  }
}
