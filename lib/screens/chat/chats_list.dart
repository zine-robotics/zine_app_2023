import 'package:flutter/material.dart';
import 'package:zineapp2023/theme/color.dart';

import 'chat_card.dart';

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
              const Text(
                "Personal",
                style: TextStyle(
                  color: greyText,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: chats.length,
                itemBuilder: ((context, index) {
                  return chats[index]["type"] == "Personal"
                      ? ChatCard(index: index)
                      : Container();
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Groups",
                style: TextStyle(
                  color: greyText,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: chats.length,
                itemBuilder: ((context, index) {
                  return chats[index]["type"] == "Group"
                      ? ChatCard(index: index)
                      : Container();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
