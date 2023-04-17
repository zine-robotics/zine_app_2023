import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:zineapp2023/models/userTask.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/screens/tasks/taskCard.dart';
import 'package:zineapp2023/screens/tasks/view_models/dashboard_vm.dart';
import 'package:zineapp2023/utilities/DateTime.dart';
import 'dart:math' as math;
import '../../utilities/DateTime.dart';
import 'recent_task.dart';
import '../../theme/color.dart';

class RecentTask extends StatelessWidget {
  TaskVm taskVm;

  RecentTask({super.key, required this.taskVm});
  
  UserTask? findLatest() {
    UserTask? ans;
    if (taskVm.tasks.length != 0) ans = taskVm.tasks[0];
    for (UserTask userTask in taskVm.tasks) {
      var one = getDMY(userTask.template!.dueDate!),
          two = getDMY(ans!.template!.dueDate!);
      if (one[2] < two[2]) {
        ans = userTask;
      } else if (one[2] == two[2]) {
        if (one[1] < two[1]) {
          ans = userTask;
        } else if(one[1]==two[1]){
          if(one[0]<two[0]){
            ans = userTask;
          }
        }
      }
    }
    return ans ;
  }

  @override
  Widget build(BuildContext context) {
    // String latest = taskVm.tasks[0].template.title;
    // print('Hello');
    UserTask? latest = findLatest();

    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      color: const Color(0xFF268CCB),
      elevation: 0,
      child: Row(
        children: [
          const SizedBox(
            height: 220.0,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 35,
                top: 20,
                right: 10,
                bottom: 10,
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        latest!= null
                            ? latest.template!.title.toString()
                            : "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const InkWell(
                        // onTap: () => const ProblemStantement(
                        //   blogName: Text("Mechanical Engineering"),
                        // ),
                        child: Text("Problem Statement",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.w700)),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(Checkbox.width),
                          ),
                        ),
                        color: Colors.white,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            latest!= null
                                ? latest.status.toString()
                                : "",
                            // 'In progress',
                            style: const TextStyle(
                                color: Color(0xFF268CCB),
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        latest!= null
                            ? getDate(latest.template!.createdDate!)
                            : "",
                        style: const TextStyle(
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
        ],
      ),
    );
  }
}
