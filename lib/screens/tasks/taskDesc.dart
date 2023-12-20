import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/models/userTask.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';
import 'package:zineapp2023/screens/tasks/view_models/task_vm.dart';
import 'package:zineapp2023/theme/color.dart';

import '../../utilities/DateTime.dart';

class TaskDesc extends StatefulWidget {
  TaskDesc({super.key});

  @override
  State<TaskDesc> createState() => _TaskDescState();
}

class _TaskDescState extends State<TaskDesc> {
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = GlobalKey();

  List<bool> arr = [true, false, false];

  Widget descripWidget(BuildContext context) {
    return Consumer<TaskVm>(
      builder: (context, taskvm, _) {
        UserTask curr = taskvm.getCurr();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: Container(
            decoration: BoxDecoration(
              color: arr[0]?Colors.white:Color(0xfffafafa),
              borderRadius: BorderRadius.circular(20.0)
            ),
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
                        SizedBox(height: 15,),
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
                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
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
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                children: [
                  if (cheklist != null)
                    for (var item in cheklist)
                      Text(
                        '${item['message']} : ${item['user']}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 16),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget linksWidget(BuildContext context, dynamic links) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
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
                    for (var item in links.values.toList())
                      Text(
                        '${item} : ${links[item]}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 16),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TaskVm, DashboardVm>(
      builder: (context, taskVm, dashVm, _) {
        UserTask curr = taskVm.getCurr();
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
                "assets/images/backbtn.png",
                height: 30,
                color: greyText,
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
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 15,
                ),
                arr[0]
                    ? Expanded(child: descripWidget(context))
                    : descripWidget(context),
                arr[1]
                    ? Expanded(
                        child: checkPointWidget(context, curr.checkpoints))
                    : checkPointWidget(context, curr.checkpoints),
                arr[2]
                    ? Expanded(child: linksWidget(context, curr.links))
                    : linksWidget(context, curr.links),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
