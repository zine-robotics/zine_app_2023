import "package:flutter/material.dart";
import 'package:zineapp2023/components/gradient.dart';
import 'package:zineapp2023/components/tab_tiles.dart';
import 'package:zineapp2023/screens/explore/team_tile.dart';

import '../../theme/color.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({Key? key}) : super(key: key);

  static const json = [
    {"name": "Divyansh Garg", "email": "2021"},
    {"name": "Rupesh Yadav", "email": "2021"},
    {"name": "Priyansh", "email": "2021"},
    {"name": "Meet", "email": "2021"},
    {"name": "Yug", "email": "2021"},
    {"name": "Granth", "email": "2021"}
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: backgroundGrey,
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            flexibleSpace: Container(
              decoration: const BoxDecoration(gradient: mainGrad),
            ),
            centerTitle: true,
            title: const Text(
              "Team",
              style: TextStyle(
                  fontFamily: 'Poppins-Black',
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.8,
                  fontSize: 25.0),
            ),
            bottom: const TabBar(
              labelColor: Colors.white,
              labelStyle: TextStyle(
                fontSize: 20,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 20,
              ),
              unselectedLabelColor: Colors.white,
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 4,
                    color: Colors.white,
                  ),
                ),
              ),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.white,
              tabs: [
                WhiteTabTile(label: "2nd Year"),
                WhiteTabTile(label: "3rd Year"),
                WhiteTabTile(label: "4th Year"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: json.length,
                  itemBuilder: (context, index) {
                    return TeamTile(
                        photo: "photo",
                        name: json[index]["name"]!,
                        id: json[index]["email"]!);
                  }),
              Container(),
              Container()
            ],
          ),
        ));
  }
}
