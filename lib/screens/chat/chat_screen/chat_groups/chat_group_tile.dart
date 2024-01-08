import 'package:flutter/material.dart';

import '../../../../theme/color.dart';

class ChatGroupTile extends StatelessWidget {
  ChatGroupTile(
      {required this.name,
        required this.chatVm,
        required this.userProv,
        super.key});

  final String name;
  final dynamic chatVm;
  final dynamic userProv;

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