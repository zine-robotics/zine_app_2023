import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/chat/view_model/chat_room_view_model.dart';
import 'package:zineapp2023/theme/color.dart';

import '../../providers/user_info.dart';
import 'chat_room.dart';

class ChatGroupTile extends StatelessWidget {
  ChatGroupTile(
      {
        required this.name,
        required this.chatVm,
        required this.userProv,

      super.key});


  String name;
  dynamic chatVm;
  dynamic userProv;



  @override
  Widget build(BuildContext context) {
    chatVm.getLastMessages(name);
    var lastChat = chatVm.lastChatRoom(name);
    bool unSeen = chatVm.unread(name, userProv.currUser);
    chatVm.listenChanges(name);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20), // Set the border radius here
            ),
            color: const Color.fromRGBO(170, 170, 170, 0.1),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.white,
                      padding: const EdgeInsets.all(17.0),
                      child: Image.asset(
                        "assets/images/timeline/${name.toLowerCase()}.png",
                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                        color: textColor.withOpacity(0.9),
                      ),
                    ),
                  ),
                ),
                // Spacer(),
                Text(
                  lastChat,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: greyText.withOpacity(0.6)),
                ),

                // Spacer()
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          // mp[map[index]]!,
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.6)),
        )
      ],
    );
  }
}

class ChatGroups extends StatelessWidget {
  const ChatGroups({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChatRoomViewModel, UserProv>(
      builder: (context, chatVm, userProv, _) {
        var currUser = userProv.currUser;
        // var listOfuser = currUser.roomIDs;
        var roomDetails = currUser.roomDetails;
        var listOfRoomID = roomDetails["group"].keys.toList();
        var listOfRoomName = roomDetails["group"].values.toList();
        // chatVm.getLastMessages(roomName!);
        // print(aList[0]);

        // String? roomName = listOfRoomName[index];
        //
        // Map<dynamic,dynamic> lastChatList = {};
        // for(var item in listOfRoomID){
        //   String? roomName = roomDetails["group"][item];
        //   var lastChat = chatVm.lastChatRoom(roomName);
        //   bool unSeen = chatVm.unread(roomName!, userProv.currUser);
        //   chatVm.listenChanges(roomName);
        //   lastChatList[item] = [lastChat,unSeen];
        // }
        //
        // print(lastChatList);
        // var name = chatVm.getData(roomName);

        return Column(
          children: [

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: roomDetails["group"].length,
                itemBuilder: (BuildContext context, int index) {


                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChatRoom(roomName: listOfRoomName[index])));
                      },
                      child: ChatGroupTile(
                        // roomId: listOfRoomID?[index],
                        name: listOfRoomName[index],
                        chatVm: chatVm,
                        userProv: userProv,
                        // lastSeen: lastChatList[listOfRoomName[index]][0],
                      ));
                },
              ),
            ),
            SizedBox(height: 10,)
          ],
        );
      },
    );
  }
}
