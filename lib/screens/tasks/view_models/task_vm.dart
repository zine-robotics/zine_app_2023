import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:zineapp2023/models/tasks.dart';
import 'package:zineapp2023/models/userTask.dart';
import 'package:zineapp2023/screens/tasks/repo/task_repo.dart';
import 'package:zineapp2023/utilities/date_time.dart';

import '../../../models/userTask.dart';

class TaskVm extends ChangeNotifier {
  final TaskRepo taskRepo;
  TaskVm({required this.taskRepo});

  List<UserTask>? tasks;
  List<dynamic> newTask = [];
  int curr = 0;
  int prevLen = 0;

  // get tasks => _tasks;

  // void getTasks() async {
  //   print("get tasks function in taskVM is called..\n..");
  //
  //     String? uid = await getCurrentUserUid();
  //     print("uid from function :$uid");
  //     if (uid != null) {
  //       _tasks = await taskRepo.getTasks(uid);
  //       print("check for _tasks:$_tasks");
  //       if (_tasks!.length != prevLen) {
  //         print("notifier triggered");
  //         notifyListeners();
  //         prevLen = _tasks!.length;
  //       }
  //     }
  //   }

  UserTask getCurr() {
    return tasks![curr];
  }

  UserTask? findLatest() {
    UserTask? ans;
    if (tasks!.isNotEmpty) ans = tasks![0];
    for (UserTask userTask in tasks!) {
      var one = getDMY(userTask.template!.dueDate!),
          two = getDMY(ans!.template!.dueDate!);
      if (one[2] < two[2]) {
        ans = userTask;
      } else if (one[2] == two[2]) {
        if (one[1] < two[1]) {
          ans = userTask;
        } else if (one[1] == two[1]) {
          if (one[0] < two[0]) {
            ans = userTask;
          }
        }
      }
    }
    // print("findLatest() -> latest task is: $ans");
    return ans;
  }

  void addCheckpoints(String message) async {
    await taskRepo.addCheckpoints(message, tasks![curr].docId.toString(), curr);

    notifyListeners();
  }

  void addLink(heading, link) async {
    await taskRepo.addLinks(heading, link, tasks![curr].docId.toString(), curr);
    notifyListeners();
  }
}
