import "package:flutter/material.dart";

import '../repo/chat_repo.dart';

class ChatRoomViewModel extends ChangeNotifier {
  final chatP = ChatRepo();

  dynamic allData;

  final roomId = "Hn9GSQnvi5zh9wabLGuT";
  final name = "Zine Channel";

  var _data;

  get data => _data;

  String _text = "";

  get text => _text;

  void setText(String value) {
    _text = value;
  }

  void getChats() async {
    allData = await chatP.getChatStream(roomId);
    print(allData.length);
    print("current messages");
  }

  void getData() {
    _data = chatP.getChatStream(roomId);
  }

  final from = "Rupesh Yadav";
  final userType = 'admin';

  void send() {
    // getChats();
    _text.isEmpty ? null : chatP.sendMessage(from, roomId, _text);
    _text = "";
    notifyListeners();
    print(_text);
  }
}
