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
    return Consumer<TaskVm>(
      builder: (context, taskVm, _) {
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
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              // color: iconTile,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      curr.template != null
                          ? curr.template!.title.toString()
                          : "",
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 7,),
                    Text(
                      "Problem Statement",
                      style: TextStyle(
                          color:textColor,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          color: iconTile.withOpacity(0.4),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 38.0,vertical: 10.0),
                            child: Text(
                              curr.status != null
                                  ? curr.status.toString().toUpperCase()
                                  : "",
                              // 'In progress',
                              style:  TextStyle(
                                  color: textColor.withOpacity(0.9),
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        Text(
                          curr.template != null
                              ? "${getDate(curr.template!.dueDate as Timestamp)} \n${DateFormat.y().format((curr.template!.dueDate as Timestamp).toDate())}"
                              : "",
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            height: 1.3,
                            color: blurBlue,
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
          ),
        );
      },
    );
  }
}
