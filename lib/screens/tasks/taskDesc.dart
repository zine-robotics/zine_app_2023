import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/models/userTask.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';
import 'package:zineapp2023/screens/tasks/view_models/dashboard_vm.dart';
import 'package:zineapp2023/theme/color.dart';
import 'package:zineapp2023/utilities/DateTime.dart';

class TaskDesc extends StatelessWidget {
  TaskDesc({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<TaskVm, DashboardVm>(builder: (
      context,
      taskVm,
      dashVm,
      _,
    ) {
      UserTask curr = taskVm.getCurr();
      return Scaffold(
        extendBody: true,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          elevation: 0,
          centerTitle: true,
          backgroundColor: backgroundGrey,
          leading: GestureDetector(
            onTap: () => {Navigator.pop(context)},
            child: Image.asset(
              "assets/images/backbtn.png",
              height: 30,
              color: Colors.black,
            ),
          ),
          title: const Text(
            "Task",
            style: TextStyle(
              height: 0.9,
              letterSpacing: 0.3,
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(225, 34, 33, 33),
            ),
          ),
        ),
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
              color: backgroundGrey,
            ),
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      color: blurBlue,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              curr.template != null
                                  ? curr!.template!.title.toString()
                                  : "",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            InkWell(
                              onTap: () => {
                                dashVm.launchUrl(curr.template!.link.toString())
                              },
                              child: const Text(
                                "Problem Statement",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "DUE DATE : ${curr.template != null ? getDate(curr.template!.dueDate as Timestamp) : ""}",
                            style: TextStyle(
                              color: greyText,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(curr.template!.description.toString()),
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      color: iconTile,
                      elevation: 0,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            curr.status.toString(),
                            style: TextStyle(
                              color: blurBlue,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => {
                        if (curr.template != null)
                          dashVm.launchUrl(
                              curr.template!.submissionLink.toString())
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        color: iconTile,
                        elevation: 0,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                color: blurBlue,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
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
