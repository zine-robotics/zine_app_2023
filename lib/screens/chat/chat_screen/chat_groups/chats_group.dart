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
        UserModel currUser = userProv.getUserInfo;

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.19,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: roomDetails?.length ??0,
            itemBuilder: (BuildContext context, int index) {
              if (roomDetails == null) return SizedBox.shrink();
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatRoom(
                              email: currUser.email,
                              roomDetail:roomDetails![index]
                              )));
                },
                child: ChatGroupTile(
                  name: roomDetails![index].name.toString() ?? " unknown ",
                  chatVm: chatVm,
                  userProv: userProv,
                  groupId: roomDetails![index].id.toString(),
                  roomDetails: roomDetails![index] ,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
