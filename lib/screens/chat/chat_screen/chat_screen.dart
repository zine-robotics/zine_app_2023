import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';

import '../../../providers/user_info.dart';
import '../../../theme/color.dart';
import 'chat_groups/chats_group.dart';
import 'channel_tile.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  Widget headingText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: greyText,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChatRoomViewModel, UserProv>(
      builder: (context, chatVm, userProv, _) {
        var currUser = userProv.currUser;
        var roomDetails = currUser.roomDetails;
        var projects = roomDetails['project'].values.toList();

        return Container(
          color: backgroundGrey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --------------------Channels-------------------------------
                  headingText("Channels"),
                  const Channel(
                    name: "Announcements",
                  ),

                  //--------------------Groups----------------------------------
                  !roomDetails["group"].isEmpty
                      ? headingText("Groups")
                      : Container(),
                  !roomDetails["group"].isEmpty
                      ? const ChatGroups()
                      : Container(),

                  const SizedBox(
                    height: 10,
                  ),

                  //--------------------Rooms-----------------------------------R
                  !roomDetails["group"].isEmpty
                      ? headingText("Rooms")
                      : Container(),
                  !roomDetails["group"].isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            if (currUser.rooms != null)
                              for (var item in projects)
                                Channel(name: item['name'], data: item)
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
