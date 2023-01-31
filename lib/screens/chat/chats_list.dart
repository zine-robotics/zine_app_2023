import 'package:flutter/material.dart';
import 'package:zineapp2023/theme/color.dart';

const chats = [
  {
    "name": "Rupesh",
    "lastTime": "18:31",
    "newMsg": 0,
    "type": "Personal",
  },
  {
    "name": "Priyansh",
    "lastTime": "18:02",
    "newMsg": 3,
    "type": "Personal",
  },
  {
    "name": "BME",
    "lastTime": "18:31",
    "newMsg": 0,
    "type": "Group",
  },
  {
    "name": "BEE",
    "lastTime": "18:31",
    "newMsg": 2,
    "type": "Group",
  },
  {
    "name": "Areomodelling",
    "lastTime": "18:31",
    "newMsg": 4,
    "type": "Group",
  },
];

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, this.index});

  final index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
          color: chats[index]["newMsg"] == 0
              ? const Color.fromRGBO(170, 170, 170, 0.1)
              : const Color.fromRGBO(47, 128, 237, 0.1),
        ),
        width: MediaQuery.of(context).size.width - 50,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    chats[index]["name"].toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  chats[index]["newMsg"] != 0
                      ? Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(47, 128, 237, 1),
                              ),
                              height: 20,
                              width: 20,
                              child: Center(
                                child: Text(
                                  chats[index]["newMsg"].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        )
                      : Container(),
                  Text(
                    chats[index]["lastTime"].toString(),
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
    );
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
