import 'package:flutter/material.dart';
import 'package:zineapp2023/screens/chat/chats_list.dart';
import 'package:zineapp2023/theme/color.dart';

class ChatHome extends StatelessWidget {
  const ChatHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundGrey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Icon(
            Icons.arrow_back,
            size: 20,
            color: greyText,
          ),
          title: TabBar(
            labelColor: Color.fromRGBO(12, 114, 176, 0.949375),
            labelStyle: TextStyle(
              fontSize: 20,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 20,
            ),
            unselectedLabelColor: greyText,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 4,
                  color: Color.fromRGBO(12, 114, 176, 0.949375),
                ),
              ),
            ),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Color.fromRGBO(12, 114, 176, 0.949375),
            tabs: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Chats",
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Tasks",
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ChatsList(),
            SingleChildScrollView(),
          ],
        ),
      ),
    );
  }
}
