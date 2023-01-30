import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:zineapp2023/components/gradient.dart';
import 'package:zineapp2023/components/tab_tiles.dart';
import 'package:zineapp2023/screens/explore/team/team_tile.dart';

import '../../../providers/dictionary.dart';
import '../../../theme/color.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Language>(builder: (context, dict, _) {
      return DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: backgroundGrey,
            appBar: AppBar(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(35.0))),
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
                    fontSize: 30.0),
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
                    itemCount: dict.teamScreen.team![0].length,
                    itemBuilder: (context, index) {
                      return TeamTile(
                        image: dict.teamScreen.team![0][index].image!,
                        name: dict.teamScreen.team![0][index].name!,
                        id: dict.teamScreen.team![0][index].email!,
                      );
                    }),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: dict.teamScreen.team![1].length,
                    itemBuilder: (context, index) {
                      return TeamTile(
                        image: dict.teamScreen.team![1][index].image!,
                        name: dict.teamScreen.team![1][index].name!,
                        id: dict.teamScreen.team![1][index].email!,
                      );
                    }),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: dict.teamScreen.team![2].length,
                    itemBuilder: (context, index) {
                      return TeamTile(
                        image: dict.teamScreen.team![2][index].image!,
                        name: dict.teamScreen.team![2][index].name!,
                        id: dict.teamScreen.team![2][index].email!,
                      );
                    })
              ],
            ),
          ));
    });
  }
}
