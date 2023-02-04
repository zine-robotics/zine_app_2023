import "package:flutter/material.dart";

import '../repo/chat_repo.dart';

class ChatRoomViewModel extends ChangeNotifier {
  final chatP = ChatRepo();

  dynamic allData;

  String _roomId = "Hn9GSQnvi5zh9wabLGuT";
  final name = "Announcement";

  get roomId => _roomId;

  void setRoomId(String value){
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

  void getData() {
    _data = chatP.getChatStream(_roomId);
  }

  final from = "Rupesh Yadav";
  final userType = 'admin';

  void send() {
    // getChats();
    _text.isEmpty ? null : chatP.sendMessage(from, _roomId, _text);
    setText("");
    notifyListeners();
  }
}
