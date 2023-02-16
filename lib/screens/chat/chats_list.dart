import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/models/message.dart';
import 'package:zineapp2023/screens/chat/chat_room.dart';
import 'package:zineapp2023/screens/chat/repo/chat_repo.dart';
import 'package:zineapp2023/screens/chat/view_model/chat_room_view_model.dart';
import 'package:zineapp2023/theme/color.dart';
import 'package:zineapp2023/utilities/DateTime.dart';

import 'chat_card.dart';

const announceChannelId = 'Hn9GSQnvi5zh9wabLGuT';
const announceChannelName = 'Zine Channel';

class Channel extends StatelessWidget {
  final name;
  final roomId;
  const Channel({super.key, required this.name, this.roomId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatRoomViewModel>(builder: (context, chatVm, _) {
      chatVm.getLastMessage();
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: () {
            // chatVm.setRoomId(roomId);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatRoom(
                          roomName: name,
                        )));
          },
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
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
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Image.asset("assets/images/zine_logo.png"),
                        ),
                        radius: 20,
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
                          // Container(
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(10),
                          //     color: const Color.fromRGBO(47, 128, 237, 1),
                          //   ),
                          //   height: 20,
                          //   width: 20,
                          //   child: const Center(
                          //     child: Text(
                          //       '',
                          //       // chats[index]["newMsg"].toString(),
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 12,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      Text(
                        chatVm.lastChatTime,
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

class ChatsList extends StatelessWidget {
  const ChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundGrey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "Channels",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: greyText,
                    fontSize: 16,
                  ),
                ),
              ),
              Channel(
                name: "Announcements",
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: chats.length,
              //   itemBuilder: ((context, index) {
              //     return chats[index]["type"] == "Personal"
              //         ? ChatCard(index: index)
              //         : Container();
              //   }),
              // ),
              // const Text(
              //   "Personal",
              //   style: TextStyle(
              //     color: greyText,
              //     fontSize: 16,
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: chats.length,
              //   itemBuilder: ((context, index) {
              //     return chats[index]["type"] == "Personal"
              //         ? ChatCard(index: index)
              //         : Container();
              //   }),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // const Text(
              //   "Groups",
              //   style: TextStyle(
              //     color: greyText,
              //     fontSize: 16,
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: chats.length,
              //   itemBuilder: ((context, index) {
              //     return chats[index]["type"] == "Group"
              //         ? ChatCard(index: index)
              //         : Container();
              //   }),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
