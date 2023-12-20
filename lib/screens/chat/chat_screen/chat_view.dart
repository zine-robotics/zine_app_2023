import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:zineapp2023/utilities/string_formatters.dart';

import '../../../models/message.dart';
import '../../../theme/color.dart';
import '../../../utilities/date_time.dart';

Widget chatV(var data, var currUser, var dashVm, dynamic reply,
    dynamic updateMessage, BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: data,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasData) {
        List<MessageModel> chats = snapshot.data!.docs.map((doc) {
          MessageModel message = MessageModel.store(doc);
          if (message.replyTo == null) {
            // Assuming you have access to the document reference
            updateMessage(doc.reference);
          }
          return message;
        }).toList();
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      chats[chats.length - index - 1].replyTo != null
                          ? Padding(
                        padding: const EdgeInsets.fromLTRB(
                            0, 10, 0, 5),
                        child: Padding(
                          padding: currUser.name !=
                              chats[chats.length - index - 1]
                                  .from
                              ? EdgeInsets.symmetric(
                              horizontal: 35.0)
                              : EdgeInsets.all(0),
                          child: Text(
                            "${currUser.name == chats[chats.length - index - 1].from ? "You" : chats[chats.length - index - 1].from.toString().firstName()} replied to ${chats[chats.length - index - 1].replyTo["from"].toString().firstName()} ",
                            textAlign: currUser.name ==
                                chats[chats.length -
                                    index -
                                    1]
                                    .from
                                ? TextAlign.right
                                : TextAlign.left,
                            style: TextStyle(
                                color: greyText, fontSize: 11),
                          ),
                        ),
                      )
                          : Container(),
                      chats[chats.length - index - 1].replyTo != null
                          ? Row(
                        // direction: Axis.horizontal,
                        mainAxisAlignment: currUser.name ==
                            chats[chats.length - index - 1]
                                .from
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: currUser.name ==
                            chats[chats.length - index - 1]
                                .from
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          currUser.name ==
                              chats[chats.length - index - 1]
                                  .from
                              ? Container()
                              : CircleAvatar(
                            backgroundColor:
                            Colors.transparent,
                            child: Padding(
                              padding:
                              const EdgeInsets.all(3.0),
                              // child: Image.asset(
                              //     "assets/images/zine_logo.png"),
                            ),
                          ),
                          currUser.name ==
                              chats[chats.length - index - 1]
                                  .from
                              ? IntrinsicHeight(
                            child: Column(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: backgroundGrey,
                                    borderRadius:
                                    BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      topLeft: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets
                                        .all(12.0),
                                    child: Text(

                                      chats[chats.length -
                                          index -
                                          1]
                                          .replyTo !=
                                          null
                                          ? chats[chats
                                          .length -
                                          index -
                                          1]
                                          .replyTo[
                                      'message']
                                          .toString()
                                          : " ",
                                      // softWrap: true,
                                      textAlign:
                                      TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 13),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                              : IntrinsicHeight(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets
                                      .symmetric(
                                      horizontal: 4),
                                  child: Container(
                                    color:
                                    const Color(0xff68a5ca),
                                    width: 4,
                                    child: const Padding(
                                      padding:
                                      EdgeInsets
                                          .symmetric(
                                          vertical:
                                          12.0),
                                      child: Text(
                                        "       ",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          currUser.name ==
                              chats[chats.length - index - 1]
                                  .from
                              ? IntrinsicHeight(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets
                                      .symmetric(
                                      horizontal: 4),
                                  child: Container(
                                    color:
                                    const Color(0xff0C72B0),
                                    width: 4,
                                    child: const Padding(
                                      padding:
                                      EdgeInsets
                                          .symmetric(
                                          vertical:
                                          12.0),
                                      child: Text(
                                        "       ",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                              : IntrinsicHeight(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: backgroundGrey,
                                      borderRadius: currUser
                                          .name !=
                                          chats[chats.length - index - 1]
                                              .from
                                          ? const BorderRadius.only(
                                          topRight:
                                          Radius.circular(
                                              15.0),
                                          topLeft: Radius.circular(
                                              5.0),
                                          bottomLeft:
                                          Radius.circular(
                                              5.0),
                                          bottomRight:
                                          Radius.circular(
                                              15.0))
                                          : const BorderRadius.only(
                                          topRight:
                                          Radius.circular(5.0),
                                          topLeft: Radius.circular(15.0),
                                          bottomLeft: Radius.circular(15.0),
                                          bottomRight: Radius.circular(5.0))),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets
                                        .all(12.0),
                                    child: Text(
                                      chats[chats.length -
                                          index -
                                          1]
                                          .replyTo !=
                                          null
                                          ? chats[chats
                                          .length -
                                          index -
                                          1]
                                          .replyTo[
                                      'message']
                                          .toString().substring(0,30) +" . . ."
                                          : " ",
                                      textAlign:
                                      TextAlign.right,
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 13),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                          : Container(),
                      if (showDate)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            DateFormat.yMMMMd()
                                .format(chats[chats.length - index - 1]
                                .timeStamp!
                                .toDate())
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: greyText),
                          ),
                        ),
                      Container(
                        alignment: currUser.name ==
                            chats[chats.length - index - 1].from
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: SwipeTo(
                          onRightSwipe:
                          reply(chats[chats.length - index - 1]),
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
                                padding:
                                const EdgeInsets.all(3.0),
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
                                  "${chats[chats.length - index - 1].from}     ${getTime(chats[chats.length - index - 1].timeStamp!)}",
                                  style: const TextStyle(
                                    fontWeight:
                                    FontWeight.w400,
                                    fontSize: 10.0,
                                    color: Color.fromARGB(
                                        255, 92, 20, 20),
                                  ),
                                ),
                              ),
                            ),
                            title: Wrap(
                              crossAxisAlignment:
                              WrapCrossAlignment.end,
                              alignment: currUser.name ==
                                  chats[chats.length - index - 1]
                                      .from
                                  ? WrapAlignment.end
                                  : WrapAlignment.start,
                              direction: Axis.horizontal,
                              children: [
                                // Text("Something"),
                                Container(
                                  decoration: BoxDecoration(
                                    color: currUser.name ==
                                        chats[chats.length -
                                            index -
                                            1]
                                            .from
                                        ? const Color(0xff68a5ca)
                                        : const Color(0xff0C72B0),
                                    borderRadius: BorderRadius.only(
                                        topLeft:
                                        const Radius.circular(15.0),
                                        topRight:
                                        const Radius.circular(15.0),
                                        bottomRight: currUser.name ==
                                            chats[chats.length -
                                                index -
                                                1]
                                                .from
                                            ? const Radius.circular(0.0)
                                            : const Radius.circular(
                                            15.0),
                                        bottomLeft: currUser.name ==
                                            chats[chats.length -
                                                index -
                                                1]
                                                .from
                                            ? const Radius.circular(
                                            15.0)
                                            : const Radius.circular(0.0)),
                                    // border: Border.all(color: greyText, width: 2.0),
                                  ),
                                  // margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.all(4),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SelectableLinkify(
                                      text: chats[
                                      chats.length - index - 1]
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
                      ),
                    ]);
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