import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:zineapp2023/models/temp_message.dart';

import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';

Widget chatV(BuildContext context,Stream<List<TempMessageModel>>messageStream) {

      return Flexible(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: StreamBuilder<List<TempMessageModel>>(
            stream: messageStream,
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting)
                {
                  return Center(child: CircularProgressIndicator(),);
                }
              else if(snapshot.hasError)
                {
                  return Center(child: Text('Error:${snapshot.error}'),);
                }
              else if(!snapshot.hasData || snapshot.data!.isEmpty)
                {
                  return Center(child: Text('No messages'),);
                }

              List<TempMessageModel> messages=snapshot.data!;
              return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context,index){

                  final message=messages[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft, // Adjust this based on the sender
                        child: ListTile(
                          horizontalTitleGap: 6,
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.end,
                            alignment: WrapAlignment.start,
                            direction: Axis.horizontal,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue, // Adjust color as needed
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(0.0),
                                  ),
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child: SelectableLinkify(
                                  text: message.content!, // Assuming `content` holds the message text
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                  onOpen: (link) async {
                                    // Implement your link opening logic
                                  },
                                  linkStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.0,
                                    color: Colors.white70,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
              });


            },
          ),
        ),
      );


}
