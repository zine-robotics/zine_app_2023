import "package:flutter/material.dart";
import 'package:zineapp2023/components/gradient.dart';
import 'package:zineapp2023/components/tab_tiles.dart';
import 'package:zineapp2023/screens/explore/about/mentor_info.dart';
import 'package:zineapp2023/screens/explore/about/zine_info.dart';
import '../../../components/widgets.dart';
import '../../../theme/color.dart';

class AboutScreen extends StatelessWidget {
   const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundGrey,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: mainGrad,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15.0),
              ),
            ),
          ),
          centerTitle: true,
          title:appbarTitle("About"),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.0),
            ),
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
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            indicatorColor: Colors.white,
            tabs: [
              WhiteTabTile(label: "Zine"),
              WhiteTabTile(label: "Mentor"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ZineInfo(),
            MentorInfo(),
          ],
        ),
      ),
    );
  }
}
