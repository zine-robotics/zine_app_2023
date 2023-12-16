

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/chat/view_model/chat_room_view_model.dart';

import '../../providers/user_info.dart';
import '../../theme/color.dart';
import 'chats_group.dart';
import 'chats_list.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChatRoomViewModel, UserProv>(
      builder: (context, chatVm, userProv, _) {
        var currUser = userProv.currUser;
        var roomDetails = currUser.roomDetails;
        // for (var item in roomDetails["project"].values.toList()) print(item);
        // print(roomDetails["group"].isEmpty );
        // print(roomDetails["project"]);



        return Container(
          color: backgroundGrey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Channels",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: greyText,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Channel(
                    name: "Announcements",
                  ),
                  !roomDetails["group"].isEmpty?
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Groups",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: greyText,
                        fontSize: 16,
                      ),
                    ),
                  ):Container(),
                  !roomDetails["group"].isEmpty?ChatGroups():Container(),

                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     if (currUser.rooms != null)
                  //       for (var item in currUser.rooms!) Channel(name: item)
                  //   ],
                  // ),

                  SizedBox(
                    height: 10,
                  ),
                  !roomDetails["group"].isEmpty?const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Rooms",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: greyText,
                        fontSize: 16,
                      ),
                    ),
                  ):Container(),
                  !roomDetails["group"].isEmpty?Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (currUser.rooms != null)
                        for (var item in roomDetails["project"].values.toList())
                          Channel(name: item)
                    ],
                  ):Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
