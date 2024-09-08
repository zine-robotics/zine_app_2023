import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/models/temp_rooms.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';
import '../../../../models/user.dart';
import '../../../../providers/user_info.dart';
import '../chat_room.dart';
import 'chat_group_tile.dart';

class ChatGroups extends StatelessWidget {
  final List<TempRooms>? roomDetails;
  const ChatGroups({super.key,this.roomDetails});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChatRoomViewModel, UserProv>(
      builder: (context, chatVm, userProv, _) {
        // var currUser = userProv.currUser;
        UserModel currUser = userProv.getUserInfo;

        // var listOfuser = currUser.roomIDs;
        // var roomDetails = currUser.roomDetails;
        // var listOfRoomID = roomDetails["group"].keys.toList();
        // List<TempRooms>? roomDetails=chatVm.user_rooms;
        // List listOfRoomDetails = roomDetails["group"].values.toList();

        // chatVm.getLastMessages(roomName!);

        // String? roomName = listOfRoomName[index];

        // Map<dynamic,dynamic> lastChatList = {};
        // for(var item in listOfRoomID){
        //   String? roomName = roomDetails["group"][item];
        //   var lastChat = chatVm.lastChatRoom(roomName);
        //   bool unSeen = chatVm.unread(roomName!, userProv.currUser);
        //   chatVm.listenChanges(roomName);
        //   lastChatList[item] = [lastChat,unSeen];
        // }

        // print(lastChatList);
        // var name = chatVm.getData(roomName);

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.19,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: roomDetails?.length ??0,
            itemBuilder: (BuildContext context, int index) {
              if (roomDetails == null) return SizedBox.shrink();
              TempRooms item = roomDetails![index];
              // print("Room Details: $roomDetails");
              // print("Item: ${roomDetails?[index]}");
              return GestureDetector(
                onTap: () {
                  // chatVm.setRoomId(roomId);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatRoom(
                              roomName: item.name,
                              roomId:item.id.toString(),
                              email: currUser.email,
                              )));
                },
                child: ChatGroupTile(
                  // roomId: listOfRoomID?[index],
                  name: roomDetails![index].name.toString() ?? " unknown ",
                  chatVm: chatVm,
                  userProv: userProv,
                  groupId: roomDetails![index].id.toString(),
                  roomDetails: roomDetails![index] ,
                  //lastSeen: lastChatList[listOfRoomName[index]][0],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
