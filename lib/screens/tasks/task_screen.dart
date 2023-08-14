import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/screens/tasks/taskCard.dart';
import 'package:zineapp2023/screens/tasks/view_models/task_vm.dart';
import 'package:zineapp2023/common/routing.dart';
import 'dart:math' as math;
import 'recent_task.dart';
import '../../theme/color.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProv, TaskVm>(builder: (context, userProv, taskVm, _) {
      taskVm.getTasks(userProv.currUser.uid);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Recent Tasks",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xff8D989F),
              fontSize: 18.0,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(Routes.taskDesc());
            },
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Stack(
                children: [
                  if (taskVm.tasks.length == 0)
                    Transform.rotate(
                      angle: math.pi / 50,
                      child: const Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          color: Color(0x69D9D9D9),
                          elevation: 0,
                          child: SizedBox(
                            height: 220.0,
                            child: Center(
                              child: Text(""),
                            ),
                          )),
                    ),
                  Transform.rotate(
                    angle: math.pi / 50,
                    child: const Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        color: Color(0x66268CCB),
                        elevation: 0,
                        child: SizedBox(
                          height: 220.0,
                          child: Center(
                            child: Text(""),
                          ),
                        )),
                  ),
                  if (taskVm.tasks.length == 0)
                  const Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    color: iconTile,
                    elevation: 0,
                    child: SizedBox(
                      height: 220.0,
                      child: Center(
                        child: Text(
                          "No tasks to show",
                          style: TextStyle(
                              color: backgroundGrey,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  RecentTask(taskVm: taskVm),
                ],
              ),
            ),
          ),
           DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  TabBar(
                      padding: EdgeInsets.all(8.0),
                      indicatorWeight: 0.1,
                      labelColor: blurBlue,
                      labelStyle: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.w800),
                      unselectedLabelColor: greyText,
                      unselectedLabelStyle: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w700),
                      indicatorColor: Colors.transparent,
                      tabs: [
                        Text("Completed"),
                        Text("All Tasks"),
                        Text("Incomplete"),
                      ]),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              if (taskVm.tasks.length == 0)
                              Column(
                                children: [
                                  SizedBox(
                                    height: 130.0,
                                  ),
                                  Text(
                                    "No Tasks Assigned",
                                    style: TextStyle(
                                        color: iconTile,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              for (int i = 0; i < taskVm.tasks.length; i++)
                                TaskCard(
                                  curr: taskVm.tasks[i],
                                  index: i,
                                ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 130.0,
                            ),
                            Text(
                              "No Tasks Assigned",
                              style: TextStyle(
                                  color: iconTile,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 130.0,
                            ),
                            Text(
                              "No Tasks Assigned",
                              style: TextStyle(
                                  color: iconTile,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
