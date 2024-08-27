import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/screens/chat/chat_description/chat_descp.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';
import 'package:zineapp2023/theme/color.dart';
import '../../../components/gradient.dart';
import 'chat_view.dart';

class ChatRoom extends StatefulWidget {
  final dynamic roomName;

  final String? roomId;

  ChatRoom({Key? key, required this.roomName,this.roomId})
      : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var chatRoomView=Provider.of<ChatRoomViewModel>(context, listen: false);
      // chatRoomView.setRoomId(widget.roomId!);
      widget.roomId!=null? chatRoomView.fetchMessages(widget.roomId!): "";
      // chatRoomView.subscribeToRoom(widget.roomId!);

      // chatRoomView.fetchMessages();
      if (widget.roomId != null) {

        chatRoomView.subscribeToRoom(widget.roomId!);
      }
    });
  }
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer3<ChatRoomViewModel, DashboardVm, UserProv>(
      builder: (context, chatVm, dashVm, userProv, _) {
        var listOfUsers = [];
        var image = null;
        // print("room detila");
        // print(roomDetails);
        // if (roomDetails != null && roomDetails['members'] != null) {
        //   listOfUsers = roomDetails['members'];
        //   image = roomDetails['image'];
        // }
        // chatVm.replyfocus.addListener(chatVm.replyListner);

        // var data = chatVm.getData(roomName);//earlier data from firebas


        UserModel currUser = userProv.getUserInfo();
        chatVm.addRouteListener(
            context, widget.roomName, userProv.currUser.email.toString(), userProv);

        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              toolbarHeight: MediaQuery.of(context).size.height * 0.1,
              title: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (BuildContext context) {
                        // return Text("chatDesctiption remove");
                    return ChatDescription(
                        roomName: widget.roomName, image: image, data: listOfUsers);
                  }));
                },
                child: Text(
                  widget.roomName,
                  // "hello again",
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
                // border: Border.all(color: greyText, width: 2.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // chatV(data, currUser, dashVm, chatVm.replyText,
                    //     chatVm.updateMessage, context),
                     chatV(context,chatVm.messageStream,dashVm,chatVm.userReplyText),
                    currUser.type == 'user' && widget.roomName == "Announcements"
                        ? Container()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              chatVm.replyfocus.hasFocus &&
                                      chatVm.replyTo != null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 1, 0, 2),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 3),
                                            child: Text(
                                              "Reply To " +
                                                  chatVm.selectedReplyMessage
                                                      .from,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: greyText,
                                                  fontSize: 11),
                                            ),
                                          ),
                                        ),
                                        Stack(children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                              color: backgroundGrey,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.0),
                                                topRight: Radius.circular(20.0),
                                                bottomRight:
                                                    Radius.circular(20.0),
                                                bottomLeft:
                                                    Radius.circular(10.0),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                chatVm.selectedReplyMessage
                                                    .message,

                                                // softWrap: true,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: -7,
                                            right: 0,
                                            child: IconButton(
                                              iconSize: 20,
                                              onPressed: chatVm.cancelReply,
                                              icon: Icon(Icons.cancel_outlined),
                                            ),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: 5,
                                        )
                                      ],
                                    )
                                  : Container(),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15.0)),
                                    border:
                                        Border.all(color: greyText, width: 2.0),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      // IconButton(
                                      //     onPressed: () =>
                                      //         {chatVm.pickImage(ImageSource.gallery)},
                                      //     icon: Icon(Icons.image)),
                                      const SizedBox(
                                        width: 10.0,
                                      ),

                                      Expanded(
                                        flex: 1,
                                        child: TextField(
                                          keyboardType: TextInputType.multiline,
                                          focusNode: chatVm.replyfocus,
                                          maxLines: 3,
                                          minLines: 1,
                                          controller: messageController,
                                          onChanged: (value) =>
                                              chatVm.setText(value),
                                          decoration: const InputDecoration(
                                              hintText: "Type Your Message",
                                              hintStyle: TextStyle(
                                                  color: Colors.black54),
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
                                          chatVm.sendMessage(messageController.text,widget.roomName);
                                          messageController.text = "";

                                          // chatVm.send(
                                          //     from: userProv.currUser.name,
                                          //     roomId: roomName);
                                          //
                                          // chatVm.replyTo = null;
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
