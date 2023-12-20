import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';
import 'package:zineapp2023/theme/color.dart';
import '../../../components/gradient.dart';
import 'chat_view.dart';

class ChatRoom extends StatelessWidget {
  final roomName;

  ChatRoom({Key? key, required this.roomName}) : super(key: key);

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer3<ChatRoomViewModel, DashboardVm, UserProv>(
      builder: (context, chatVm, dashVm, userProv, _) {
        chatVm.getRoomData(roomName);
        var listOfUsers = chatVm.listOfUsers;

        var data = chatVm.getData(roomName);
        UserModel currUser = userProv.getUserInfo();
        // chatVm.addRouteListener(
        //     context, roomName, userProv.currUser.email.toString(), userProv);

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
                  // Navigator.of(context)
                  //     .push(CupertinoPageRoute(builder: (BuildContext context) {
                  //   return ChatDescription(
                  //     roomName: roomName,
                  //     data: listOfUsers
                  //   );
                  // }));
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
                // border: Border.all(color: greyText, width: 2.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    chatV(data, currUser, dashVm, chatVm.replyText,
                        chatVm.updateMessage, context),
                    currUser.type == 'user' && roomName == "Announcements"
                        ? Container()
                        : Column(
                            children: [
                              //TODO: Add a reply to Widget after the release.
                              // Text("there s somethi"),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                                        width:10.0,
                                      ),
                                      Expanded(
                                        child: TextField(
                                          keyboardType: TextInputType.multiline,
                                          // focusNode: chatVm.replyfocus,
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
