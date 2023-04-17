import "package:flutter/material.dart";
import 'package:intl/intl.dart';

import 'package:zineapp2023/models/userTask.dart';

import 'package:zineapp2023/screens/tasks/view_models/dashboard_vm.dart';
import 'package:zineapp2023/utilities/DateTime.dart';

class RecentTask extends StatelessWidget {
  TaskVm taskVm;

  RecentTask({super.key, required this.taskVm});

  @override
  Widget build(BuildContext context) {
    UserTask? latest = taskVm.findLatest();

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
                        latest != null ? latest.template!.title.toString() : "",
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
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                                    latest != null
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
                              Text(
                                latest != null
                                    ? getDate(latest.template!.dueDate!) +
                                        "\n" +
                                        DateFormat.y().format(
                                            latest.template!.dueDate!.toDate())
                                    : "",
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ]),
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
