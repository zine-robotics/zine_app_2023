import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';
import 'package:zineapp2023/theme/color.dart';

import 'chat_room.dart';



import 'chat_room.dart';


const announceChannelId = 'Hn9GSQnvi5zh9wabLGuT';
const announceChannelName = 'Zine Channel';

class Channel extends StatelessWidget {
  final name;

  const Channel({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChatRoomViewModel, UserProv>(
        builder: (context, chatVm, userProv, _) {
      chatVm.getLastMessages(name);
      var lastChat = chatVm.lastChatRoom(name);
      bool unSeen = chatVm.unread(name, userProv.currUser);
      chatVm.listenChanges(name);
      //Rooms? roomData=chatVm.getRoomData2(name);
      //print("roomData image is :${roomData}");
      //print("room data as ${chatVm.}");

      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: () {
            // chatVm.setRoomId(roomId);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatRoom(roomName: name)));
          },
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              color: Color.fromRGBO(170, 170, 170, 0.1),
              // : const Color.fromRGBO(47, 128, 237, 0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Image.asset("assets/images/zine_logo.png"),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          unSeen
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        const Color.fromRGBO(47, 128, 237, 1),
                                  ),
                                  height: 20,
                                  width: 20,
                                  // child: const Center(
                                  //   child: Text(
                                  //     '',
                                  //     // chats[index]["newMsg"].toString(),
                                  //     style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontSize: 12,
                                  //     ),
                                  //   ),
                                  // ),
                                )
                              : const SizedBox(),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      Text(
                        lastChat,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(51, 51, 51, 0.5),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

