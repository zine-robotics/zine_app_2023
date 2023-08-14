import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/common/routing.dart';
import 'package:zineapp2023/models/userTask.dart';
import 'package:zineapp2023/screens/tasks/view_models/task_vm.dart';
import 'package:zineapp2023/utilities/DateTime.dart';

// import '/screens/tasks/problem_statement.dart';
import '../../theme/color.dart';

class TaskCard extends StatelessWidget {
  final UserTask curr;
  final int index;
  const TaskCard({Key? key, required this.curr, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskVm>(builder: (context, taskVm, _) {
      return GestureDetector(
        onTap: () => {
          taskVm.curr = index,
          Navigator.of(context).push(Routes.taskDesc())
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 5,
          ),
          child: InkWell(
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              // color: iconTile,
              elevation: 0,
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
                          curr.template != null
                              ? curr!.template!.title.toString()
                              : "",
                          style: const TextStyle(
                            color: Color(0xEE0C72B0),
                            fontSize: 25.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const InkWell(
                          child: Text("Problem Statement",
                              style: TextStyle(
                                  color: Color(0xFF268CCB),
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w700)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(Checkbox.width),
                                  ),
                                ),
                                color: iconTile,
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    curr.status != null
                                        ? curr.status.toString()
                                        : "",
                                    // 'In progress',
                                    style: const TextStyle(
                                        color: blurBlue,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Text(
                                curr.template != null
                                    ? getDate(curr.template!.dueDate
                                            as Timestamp) +
                                        " \n" +
                                        DateFormat.y().format((curr
                                                .template!.dueDate as Timestamp)
                                            .toDate())
                                    : "",
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: blurBlue,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
