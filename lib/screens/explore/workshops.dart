import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';
import 'package:zineapp2023/providers/dictionary.dart';
import 'package:zineapp2023/providers/user_info.dart';

import '../../../theme/color.dart';
import '../../components/gradient.dart';
import '../../models/user.dart';

class WorkshopScreen extends StatelessWidget {
  const WorkshopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<Language, UserProv>(builder: (context, dict, userProv, _) {
      UserModel currUser = userProv.getUserInfo();
      return Scaffold(
          bottomNavigationBar: (currUser.registered != null &&
                  currUser.registered as bool)
              ? null
              : Container(
                  color: backgroundGrey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(20.0)),
                        backgroundColor: MaterialStateProperty.all(textColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
          backgroundColor: backgroundGrey,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            toolbarHeight: MediaQuery.of(context).size.height * 0.08,
            title: const Text(
              "Workshop",
              style: TextStyle(
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
          body: Timeline.tileBuilder(
            shrinkWrap: true,
            builder: TimelineTileBuilder.connected(
              contentsAlign: ContentsAlign.alternating,
              oppositeContentsBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: index % 2 == 0
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dict.achievementScreen.achievement![index].title!,
                      textAlign:
                          index % 2 == 0 ? TextAlign.right : TextAlign.left,
                      style: const TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      dict.achievementScreen.achievement![index].date!
                          .toUpperCase(),
                      textAlign:
                          index % 2 == 0 ? TextAlign.right : TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13.0),
                    ),
                  ],
                ),
              ),
              contentsBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 25.0, horizontal: 12.0),
                child: Text(
                  dict.achievementScreen.achievement![index].description!,
                  textAlign: index % 2 != 0 ? TextAlign.right : TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 14.0),
                ),
              ),
              connectorBuilder: (context, index, ConnectorType c) =>
                  const SolidLineConnector(
                color: Color(0xffAAAAAA),
              ),
              indicatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: iconTile,
                  radius: 25.0,
                  child: ImageIcon(
                    AssetImage(
                        "assets/images/achievements/${dict.achievementScreen.achievement![index].type}.png"),
                    color: Colors.black,
                  ),
                ),
              ),
              itemCount: dict.achievementScreen.achievement!.length,
            ),
          ));
    });
  }
}
