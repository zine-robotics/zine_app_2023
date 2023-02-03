import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/models/message.dart';
import 'package:zineapp2023/screens/chat/repo/chat_repo.dart';
import 'package:zineapp2023/screens/chat/view_model/chat_room_view_model.dart';
import 'package:zineapp2023/theme/color.dart';

import '../../components/gradient.dart';

class ChatRoom extends StatelessWidget {
  // required String this.roomId, required String this.name

  ChatRoom({Key? key}) : super(key: key);

  final TextEditingController messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Widget ChatV(var data, BuildContext context) {
    // print(data);
    return StreamBuilder<QuerySnapshot>(
      stream: data,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> chats = snapshot.data!.docs
              .map((doc) => MessageModel.store(doc))
              .toList();

          return Flexible(
            // Flexible prevents overflow error when keyboard is opened
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: ListView.builder(
                reverse: true,
                // physics: NeverScrollableScrollPhysics(),
                dragStartBehavior: DragStartBehavior.down,
                shrinkWrap: true,
                key: UniqueKey(),
                itemCount: chats.length,
                itemBuilder: (BuildContext context, int index) {
                  return chats[chats.length - index - 1].message!.isEmpty
                      ? Container()
                      : Wrap(
                          direction: Axis.horizontal,
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0x112F80ED),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child:
                                    Image.asset("assets/images/zine_logo.png"),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xff0C72B0),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                ),
                                // border: Border.all(color: greyText, width: 2.0),
                              ),
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(4),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  chats[chats.length - index - 1]
                                      .message
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                },
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('$snapshot.error'));
        } else {
          return const SizedBox();
        }

        // print(chats);
        // print(MessageModel.store());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatRoomViewModel>(builder: (context, chatVm, _) {
      messageController.text = chatVm.text;
      chatVm.getData();
      return Scaffold(
        backgroundColor: backgroundGrey,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          title: Text(
            chatVm.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: mainGrad //need to replace with made component
                ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15.0),
            ),
            // border: Border.all(color: greyText, width: 2.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChatV(chatVm.data, context),
                (chatVm.name == 'Zine Channel' && chatVm.userType == 'user')
                    ? Container()
                    : Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0)),
                            border: Border.all(color: greyText, width: 2.0),
                          ),
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: TextField(
                                  onChanged: (value) => chatVm.setText(value),
                                  decoration: const InputDecoration(
                                      hintText: "Type Your Message",
                                      hintStyle:
                                          TextStyle(color: Colors.black54),
                                      border: InputBorder.none),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              IconButton(
                                splashRadius: 30.0,
                                visualDensity: const VisualDensity(
                                    horizontal: 4.0, vertical: 1.0),
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  chatVm.send();
                                },
                                iconSize: 20.0,
                                icon: const ImageIcon(
                                  AssetImage("assets/images/send.png"),
                                  color: greyText,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
