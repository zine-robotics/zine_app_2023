import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zineapp2023/models/message.dart';
import 'package:zineapp2023/screens/chat/repo/chat_repo.dart';
import 'package:zineapp2023/theme/color.dart';

class ChatRoom extends StatelessWidget {
  final roomId;
  final name;

  ChatRoom({Key? key, required String this.roomId, required String this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();
    const from = "Rupesh Yadav";
    const userType = 'admin';

    dynamic allData;
    final chatP = ChatRepo();
    void getChats() async {
      allData = await chatP.getChatStream(roomId);
      print(allData.length);
      print("current messages");
    }

    @override
    Widget ChatV(BuildContext context) {
      var data = chatP.getChatStream(roomId);
      print(data);
      return StreamBuilder<QuerySnapshot>(
        stream: data,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('$snapshot.error'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          List<MessageModel> chats = snapshot.data!.docs
              .map((doc) => MessageModel.store(doc))
              .toList();
          print(chats);
          // print(MessageModel.store());

          return Flexible(
            // Flexible prevents overflow error when keyboard is opened
            child: GestureDetector(
                // Close the keyboard if anything else is tapped
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: ListView.builder(
                    shrinkWrap: true,
                    key: UniqueKey(),
                    itemCount: chats.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 100,
                        child: Container(
                          child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(4),
                              child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                      chats != null
                                          ? chats[index].message.toString()
                                          : '',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black)))),
                        ),
                      );
                    })),
          );
        },
      );
    }

    void send() {
      // getChats();
      chatP.sendMessage(from, roomId, messageController.text.toString());
      print(messageController.text.toString());
    }

    return Scaffold(
        backgroundColor: backgroundGrey,
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  // ListView.builder(itemBuilder: listMessage),
                  Text('hello'),
                  ChatV(context),

                  (name == 'Zine Channel' && userType == 'user')
                      ? Container()
                      : TextFormField(
                          controller: messageController,
                          style: const TextStyle(
                            color: Colors.black,
                            letterSpacing: 1.5,
                          ),
                          // onChanged: (value) => authVm.setName(value),

                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          cursorColor: textColor,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            label: Text(
                              "Type a message",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 249, 38, 38)),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  (name == 'Zine Channel' && userType == 'user')
                      ? Container()
                      : ElevatedButton(
                          onPressed: send,
                          child: Text(
                            'Send',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(20.0)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28.0),
                              ),
                            ),
                          ),
                        )
                ])));
  }
}
