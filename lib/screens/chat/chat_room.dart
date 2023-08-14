import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zineapp2023/common/loaderScreen.dart';
import 'package:zineapp2023/models/message.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/screens/chat/chat_descp.dart';
import 'package:zineapp2023/screens/chat/view_model/chat_room_view_model.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';
import 'package:zineapp2023/theme/color.dart';
import '../../utilities/DateTime.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/gradient.dart';

class ChatRoom extends StatelessWidget {
  final roomName;

  ChatRoom({required this.roomName, Key? key}) : super(key: key);

  final TextEditingController messageController = TextEditingController();

  Widget chatV(var data, var currUser, var dashVm, BuildContext context) {
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
                padding: const EdgeInsets.all(8.0),
                reverse: true,
                // physics: NeverScrollableScrollPhysics(),
                dragStartBehavior: DragStartBehavior.down,
                shrinkWrap: true,
                key: UniqueKey(),
                itemCount: chats.length,
                itemBuilder: (BuildContext context, int index) {
                  var showDate = index == chats.length - 1 ||
                      (chats.length - index >= 2 &&
                          getDate(chats[chats.length - index - 1].timeStamp!) !=
                              getDate(
                                  chats[chats.length - index - 2].timeStamp!));

                  bool group = index > 0 &&
                      chats[chats.length - index - 1].from.toString() ==
                          chats[chats.length - index].from.toString() &&
                      getDate(chats[chats.length - index - 1].timeStamp!) ==
                          getDate(chats[chats.length - index].timeStamp!);

                  return chats[chats.length - index - 1].message!.isEmpty
                      ? Container()
                      : Column(
                    children: [
                      if (showDate)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            DateFormat.yMMMMd()
                                .format(chats[chats.length - index - 1]
                                .timeStamp!
                                .toDate())
                                .toString(),
                            style: const TextStyle(color: greyText),
                          ),
                        ),
                      Container(
                        alignment: currUser.name ==
                            chats[chats.length - index - 1].from
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: ListTile(
                          horizontalTitleGap: 6,
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          leading: currUser.name ==
                              chats[chats.length - index - 1].from
                              ? null
                              : CircleAvatar(
                            backgroundColor:
                            const Color(0x0f2F80ED),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Image.asset(
                                  "assets/images/zine_logo.png"),
                            ),
                          ),

                          // * Because Priyansh Said So :) *

                          // trailing: currUser.name !=
                          //         chats[chats.length - index - 1].from
                          //     ? null
                          //     : group
                          //         ? const CircleAvatar(
                          //             backgroundColor: Colors.transparent,
                          //           )
                          //         : CircleAvatar(
                          //             backgroundColor:
                          //                 const Color(0x0f2F80ED),
                          //             child: Padding(
                          //               padding: const EdgeInsets.all(3.0),
                          //               child: Image.asset(
                          //                   "assets/images/zine_logo.png"),
                          //             ),
                          //           ),
                          subtitle: group
                              ? null
                              : Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Align(
                              alignment: currUser.name !=
                                  chats[chats.length -
                                      index -
                                      1]
                                      .from
                                  ? Alignment.bottomLeft
                                  : Alignment.bottomRight,
                              child: group
                                  ? const Text("")
                                  : Text(
                                "${chats[chats.length - index - 1]
                                    .from}     ${getTime(
                                    chats[chats.length - index - 1]
                                        .timeStamp!)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.0,
                                  color: Color.fromARGB(
                                      255, 92, 20, 20),
                                ),
                              ),
                            ),
                          ),
                          title: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.end,
                            alignment: currUser.name ==
                                chats[chats.length - index - 1].from
                                ? WrapAlignment.end
                                : WrapAlignment.start,
                            direction: Axis.horizontal,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: currUser.name ==
                                      chats[chats.length - index - 1]
                                          .from
                                      ? const Color(0xff68a5ca)
                                      : const Color(0xff0C72B0),
                                  borderRadius: BorderRadius.only(
                                      topLeft:
                                      const Radius.circular(20.0),
                                      topRight:
                                      const Radius.circular(20.0),
                                      bottomRight: currUser.name ==
                                          chats[chats.length -
                                              index -
                                              1]
                                              .from
                                          ? const Radius.circular(0.0)
                                          : const Radius.circular(20.0),
                                      bottomLeft: currUser.name ==
                                          chats[chats.length -
                                              index -
                                              1]
                                              .from
                                          ? const Radius.circular(20.0)
                                          : const Radius.circular(0.0)),
                                  // border: Border.all(color: greyText, width: 2.0),
                                ),
                                // margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.all(4),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SelectableLinkify(
                                    text: chats[chats.length - index - 1]
                                        .message
                                        .toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                    onOpen: (link) =>
                                        dashVm.launchUrl(link.url),
                                    linkStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.0,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              )
                            ],
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
          return const Expanded(child: Loader());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<ChatRoomViewModel, DashboardVm, UserProv>(
      builder: (context, chatVm, dashVm, userProv, _) {
        var data = chatVm.getData(roomName);
        UserModel currUser = userProv.getUserInfo();
        chatVm.addRouteListener(
            context, roomName, userProv.currUser.email.toString(), userProv);

        return Scaffold(
          backgroundColor: backgroundGrey,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            toolbarHeight: MediaQuery
                .of(context)
                .size
                .height * 0.1,
            title: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    CupertinoPageRoute(builder: (BuildContext context) {
                      return  ChatDescription(roomName: roomName,);
                    }));
              },
              child: Text(
                roomName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
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
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  chatV(data, currUser, dashVm, context),
                  currUser.type == 'user' && roomName == "Announcements"
                      ? Container()
                      : Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(15.0)),
                        border: Border.all(color: greyText, width: 2.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          // IconButton(
                          //     onPressed: () =>
                          //         {chatVm.pickImage(ImageSource.gallery)},
                          //     icon: Icon(Icons.image)),
                          const SizedBox(
                            width: 2.0,
                          ),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              minLines: 1,
                              controller: messageController,
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
                              messageController.text = "";
                              chatVm.send(
                                  from: userProv.currUser.name,
                                  roomId: roomName);
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
      },
    );
  }
}
