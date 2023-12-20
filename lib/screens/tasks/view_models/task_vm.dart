import "package:flutter/material.dart";
import 'package:zineapp2023/models/tasks.dart';
import 'package:zineapp2023/models/userTask.dart';
import 'package:zineapp2023/screens/tasks/repo/task_repo.dart';
import 'package:zineapp2023/utilities/date_time.dart';

class TaskVm extends ChangeNotifier {
  final taskRepo = TaskRepo();

  List<UserTask>? tasks;

  List<dynamic> newTask = [];
  int curr = 0;
  int prevLen = 0;

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
    return ans;
  }
}
