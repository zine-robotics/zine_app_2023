import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zineapp2023/models/userTask.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';

import 'package:zineapp2023/screens/tasks/view_models/task_vm.dart';
import 'package:zineapp2023/theme/color.dart';

import '../../utilities/date_time.dart';

class TaskDesc extends StatefulWidget {
  TaskDesc({super.key});

  @override
  State<TaskDesc> createState() => _TaskDescState();
}

final messageC = TextEditingController();
final headingC = TextEditingController();
final linkC = TextEditingController();
bool LinkValidate = false;
bool CheckpointValidate = false;

class _TaskDescState extends State<TaskDesc> {
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = GlobalKey();

  List<bool> arr = [true, false, false];
  List<String> tempMessage = [];
  List<String> tempLink = [];
  List<String> tempHeader = [];

  Widget descripWidget(BuildContext context) {
    return Consumer<TaskVm>(
      builder: (context, taskvm, _) {
        UserTask curr = taskvm.getCurr();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: Container(
            decoration: BoxDecoration(
                color: arr[0] ? Colors.white : Color(0xfffafafa),
                borderRadius: BorderRadius.circular(20.0)),
            // color: Colors.white,
            child: Column(
              children: [
                Card(
                  // margin: EdgeInsets.all(0),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  color: const Color(0xFF268CCB),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(27.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          curr != null ? curr.template!.title.toString() : "",
                          style: const TextStyle(
                            fontFamily: "Poppins-ExtraBold",
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        const InkWell(
                          // onTap: () => const ProblemStantement(
                          //   blogName: Text("Mechanical Engineering"),
                          // ),
                          child: Text("Problem Statement",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              color: Colors.white,
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 38.0, vertical: 12.0),
                                child: Text(
                                  curr != null
                                      ? curr.status.toString().toUpperCase()
                                      : "",
                                  // 'In progress',
                                  style: const TextStyle(
                                    color: Color(0xFF268CCB),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              curr != null
                                  ? "${getDate(curr.template!.dueDate!)}\n${DateFormat.y().format(curr.template!.dueDate!.toDate())}"
                                  : "",
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                height: 1.4,
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ExpansionTileCard(
                  initiallyExpanded: true,
                  onExpansionChanged: (boolea) {
                    if (boolea) {
                      cardB.currentState?.collapse();
                      cardC.currentState?.collapse();
                      setState(() {
                        arr[0] = true;
                        arr[1] = false;
                        arr[2] = false;
                      });
                    } else {
                      setState(() {
                        arr[0] = false;
                        arr[1] = false;
                        arr[2] = false;
                      });
                    }
                  },
                  elevation: 0,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  key: cardA,
                  title: Text(
                    'DESCRIPTION',
                    style: TextStyle(
                        color: textColor, fontWeight: FontWeight.bold),
                  ),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          curr.template!.description!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget checkPointWidget(BuildContext context, dynamic cheklist) {
    //print("chekpoint element are:${cheklist.toString()}");
    final taskVm = Provider.of<TaskVm>(context, listen: false);

    final dashVm = Provider.of<DashboardVm>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: SingleChildScrollView(
        child: ExpansionTileCard(
          onExpansionChanged: (boolea) {
            if (boolea) {
              cardA.currentState?.collapse();
              cardC.currentState?.collapse();

              setState(() {
                arr[0] = false;
                arr[1] = true;
                arr[2] = false;
              });
            } else {
              setState(() {
                arr[0] = false;
                arr[1] = false;
                arr[2] = false;
              });
            }
          },
          elevation: 0,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          // trailing: ,
          key: cardB,
          title: const Text(
            'CHECKPOINT',
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 1.0,
                vertical: 10.0,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 260,
                //color: Colors.red,
                //color: Colors.red,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (cheklist != null)
                        for (int i = 0; i < cheklist.length; i++)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                '${cheklist[i]['user']}@${getTime(cheklist[i]['timeDate'] as Timestamp)} :${getDMY(cheklist[i]['timeDate'] as Timestamp).toString()}',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 9),
                                textAlign:
                                    dashVm.userProv.currUser.name.toString() ==
                                            cheklist[i]['user'].toString()
                                        ? TextAlign.left
                                        : TextAlign.right,
                              ),
                              Text(
                                '${cheklist[i]['message']}\n',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 12),
                                textAlign:
                                    dashVm.userProv.currUser.name.toString() ==
                                            cheklist[i]['user'].toString()
                                        ? TextAlign.left
                                        : TextAlign.right,
                              ),
                            ],
                          ),
                      if (tempMessage != null)
                        for (int i = 0; i < tempMessage!.length; i++)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${dashVm.userProv.currUser.name.toString()}@${DateTime.now().hour},${DateTime.now().minute} :${DateTime.now().day},${DateTime.now().month},${DateTime.now().year}',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 9),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                '${tempMessage?[i]}\n',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 12),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 70, left: 15, bottom: 10),
                    child: TextField(
                      minLines: 1,
                      //maxLines: 2,
                      controller: messageC,
                      decoration: InputDecoration(
                        hoverColor: Colors.blue,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                topLeft: Radius.circular(20.0)),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: backgroundGrey,
                        hintText: '   Enter Checkpoints',
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.69,
                      height: 65,
                    ),
                    Transform.scale(
                        scale: 1.5,
                        child: IconButton(
                          splashRadius: 30.0,
                          visualDensity: const VisualDensity(
                              horizontal: 4.0, vertical: 1.0),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (messageC.text.isNotEmpty) {
                              setState(() {
                                tempMessage?.add(messageC.text.toString());
                              });
                              // print(
                              //     "adding value in tempmessage is:${tempMessage[0]}  while messageC having data:${messageC}");

                              taskVm.addCheckpoints(messageC.text.toString());

                              messageC.clear();

                              // print("on pressed initiated");
                            }
                          },
                          iconSize: 20.0,
                          icon: Stack(children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              margin: EdgeInsets.only(right: 5.0),
                              height: 38,
                              decoration: BoxDecoration(
                                  color: backgroundGrey,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0))),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.11,
                              child: const ImageIcon(
                                AssetImage("assets/images/send2.png"),
                                color: Colors.blue,
                              ),
                            ),
                          ]),
                        )),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget linksWidget(BuildContext context, dynamic links, dynamic latestLink) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: SingleChildScrollView(
        child: ExpansionTileCard(
          onExpansionChanged: (boolea) {
            if (boolea) {
              cardA.currentState?.collapse();
              cardB.currentState?.collapse();
              setState(() {
                arr[0] = false;
                arr[1] = false;
                arr[2] = true;
              });
            } else {
              setState(() {
                arr[0] = false;
                arr[1] = false;
                arr[2] = false;
              });
            }
          },
          elevation: 0,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          key: cardC,
          title: const Text(
            'LINKS',
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Column(
                  children: [
                    if (links != null)
                      for (int i = 0; i < links.length; i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text('${links[i]["heading"].toString()}',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                ),
                                Text(
                                    '${links[i]['user']}@${getTime(links[i]['timeDate'] as Timestamp)} :${getDMY(links[i]['timeDate'] as Timestamp).toString()}',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 9)),
                              ],
                            ),
                            InkWell(
                                child: new Text(
                                  "${links[i]['link']}\n",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.blue),
                                ),
                                onTap: () => launch('${links[i]['link']}')),
                          ],
                        ),
                    if (tempLink != null)
                      for (int i = 0; i < tempLink.length; i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text('${tempHeader[i]}',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                ),
                                Text(
                                    '${links[0]['user']}@${DateTime.now().hour},${DateTime.now().minute} :${DateTime.now().day},${DateTime.now().month},${DateTime.now().year}',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 9)),
                              ],
                            ),
                            InkWell(
                                child: new Text(
                                  "${tempLink[i]}\n",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.blue),
                                ),
                                onTap: () => launch('${tempLink[i]}')),
                          ],
                        ),
                  ],
                ),
              ),
            ),
            //TaskDescRepo()

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Container(
                    width: 350,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0)),
                      color: backgroundGrey,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 70, top: 2, left: 2),
                        child: TextField(
                          controller: headingC,
                          decoration: InputDecoration(
                            hoverColor: Colors.blue,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0)),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '  Heading',
                          ),
                        ),
                      ),
                      Form(
                        child: TextFormField(
                          controller: linkC,
                          decoration: InputDecoration(
                            hoverColor: Colors.blue,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: backgroundGrey,
                            hintText: '   Enter Link',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a link';
                            }
                            return null; // Validation passes
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: 120,
                      ),
                      Transform.scale(
                          scale: 1.5,
                          child: IconButton(
                            splashRadius: 30.0,
                            visualDensity: const VisualDensity(
                                horizontal: 4.0, vertical: 1.0),
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if (linkC.text.isNotEmpty) {
                                setState(() {
                                  tempLink.add(linkC.text.toString());
                                  tempHeader.add(headingC.text.toString());
                                });
                                final taskVm =
                                    Provider.of<TaskVm>(context, listen: false);
                                taskVm.addLink(headingC.text.toString(),
                                    linkC.text.toString());

                                headingC.clear();
                                linkC.clear();
                              }
                            },
                            iconSize: 20.0,
                            icon: const ImageIcon(
                              AssetImage("assets/images/send2.png"),
                              color: Colors.blue,
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TaskVm, DashboardVm>(
      builder: (context, taskVm, dashVm, _) {
        UserTask curr = taskVm.getCurr();
        print("taskDesc is rebuilt");
        UserTask? latest = taskVm.findLatest();
        var latestLink = latest?.template?.link;
        print("checking messageC data:${messageC.text.toString()}");
        return Scaffold(
          backgroundColor: backgroundGrey,
          extendBody: true,
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40.0),
              ),
            ),
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () => {Navigator.pop(context)},
              child: Image.asset(
                "assets/images/back2.png",
                height: 30,
              ),
            ),
            title: const Text(
              "Task",
              style: TextStyle(
                height: 0.9,
                letterSpacing: 0.3,
                fontSize: 30.0,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  arr[0]
                      ? Expanded(child: descripWidget(context))
                      : descripWidget(context),
                  arr[1]
                      ? Expanded(
                          child: checkPointWidget(context, curr.checkpoints))
                      : checkPointWidget(context, curr.checkpoints),
                  arr[2]
                      ? Expanded(
                          child: linksWidget(context, curr.links, latestLink))
                      : linksWidget(context, curr.links, latestLink),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
