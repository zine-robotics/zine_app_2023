import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/chat/view_model/chat_room_view_model.dart';
import 'package:zineapp2023/theme/color.dart';

import '../../providers/user_info.dart';
import 'chat_room.dart';

class ChatGroupTile extends StatelessWidget {
  ChatGroupTile(
      {required this.roomId,
      required this.name,
      required this.lastSeen,
      super.key});

  String roomId;
  String name;
  String lastSeen;

  @override
  Widget build(BuildContext context) {
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
                  lastSeen,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: greyText.withOpacity(0.6)),
                ),
                const SizedBox(
                  height: 10,
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
        var listOfuser = currUser.roomIDs;
        var roomDetails = currUser.roomDetails;

        // var name = chatVm.getData(roomName);

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.18,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: roomDetails["group"].length,
            itemBuilder: (BuildContext context, int index) {
              // chatVm.getLastMessages(roomId);
              // var lastChat = chatVm.lastChatRoom(roomId);
              String roomName = roomDetails["group"][listOfuser?[index]];
              chatVm.getLastMessages(roomName);
              var lastChat = chatVm.lastChatRoom(roomName);
              bool unSeen = chatVm.unread(roomName, userProv.currUser);
              chatVm.listenChanges(roomName);

              return GestureDetector(
                  onTap: () {
                    // chatVm.setRoomId(roomId);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChatRoom(roomName: roomName)));
                  },
                  child: ChatGroupTile(
                    roomId: listOfuser?[index],
                    name: roomName,
                    lastSeen: lastChat,
                  ));
            },
          ),
        );
      },
    );
  }
}
