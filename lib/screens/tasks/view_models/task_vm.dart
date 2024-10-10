import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart';
import 'package:requests/requests.dart';
import 'package:zineapp2023/models/newTask.dart';
import 'package:zineapp2023/models/task_instance.dart';
import 'package:zineapp2023/models/tasks.dart';
import 'package:zineapp2023/models/userTask.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/screens/tasks/repo/task_repo.dart';
import 'package:zineapp2023/utilities/date_time.dart';
import 'package:http/http.dart' as http;

import '../../../backend_properties.dart';
import '../../../models/userTask.dart';

class TaskVm extends ChangeNotifier {
  final TaskRepo taskRepo;
  final UserProv userProv;
  TaskVm({required this.taskRepo, required this.userProv});

  List<UserTask>? tasks = [];
  List<UserTaskInstance> taskInstances = []; //[UserTask.fromJson(json)];
  List<UserTask>? _checkpoint;
  List<dynamic> newTask = [];

  bool _isLoading = false;
  get isLoading => _isLoading;

  bool _isError = false;
  get isError => _isError;
  int curr = 0;
  int prevLen = 0;

  // get tasks => _tasks;

  void getTasks() async {
    print("CAlled GetTAsks in TaskVM");
    _isLoading = true;
    String _uid = userProv.getUserInfo.uid!;
    //TODO: ADD ERROR HANDLING
    Response res = await http.get(BackendProperties.taskByIdUri,
        headers: {'Authorization': 'Bearer $_uid'});
    print("Called get Tasks");
    print(res.body);

    Map<String, dynamic> resBody = jsonDecode(res.body);
    var instances = resBody['instances'] as List;
    if (res.statusCode == 200 && res.body.isNotEmpty) {
      taskInstances = instances
          .map((instance) => UserTaskInstance(
              instanceId: instance['id'],
              title: instance['name'],
              roomId: 0,
              task: UserNewTask.fromJson(
                instance['task'],
              )))
          .toList();
      print("Final TaskInstance = $taskInstances");
    } else {
      _isError = true;
    }
    _isLoading = false;
    notifyListeners();
  }
  //   String? uid = await getCurrentUserUid();
  //   print("uid from function :$uid");
  //   if (uid != null) {
  //     _tasks = await taskRepo.getTasks(uid);
  //     print("check for _tasks:$_tasks");
  //     if (_tasks!.length != prevLen) {
  //       print("notifier triggered");
  //       notifyListeners();
  //       prevLen = _tasks!.length;
  //     }
  //   }

  UserTask getCurr() {
    return tasks![curr];
  }

  UserTaskInstance? findLatest() {
    if (taskInstances.isNotEmpty) {
      taskInstances
          .sort((a, b) => a.task!.dateCreated!.compareTo(b.task!.dateCreated!));
      return taskInstances.first;
    }
    return null;
  }

  // UserTask? findLatest() {
  //   UserTask? ans;
  //   if (tasks!.isNotEmpty) ans = tasks![0];
  //   for (UserTask userTask in tasks!) {
  //     var one = getDMY(userTask.template!.dueDate!),
  //         two = getDMY(ans!.template!.dueDate!);
  //     if (one[2] < two[2]) {
  //       ans = userTask;
  //     } else if (one[2] == two[2]) {
  //       if (one[1] < two[1]) {
  //         ans = userTask;
  //       } else if (one[1] == two[1]) {
  //         if (one[0] < two[0]) {
  //           ans = userTask;
  //         }
  //       }
  //     }
  //   }

  //   // print("findLatest() -> latest task is: $ans");
  //   return ans;
  // }

  void addCheckpoints(String message) async {
    await taskRepo.addCheckpoints(message, tasks![curr].docId.toString(), curr);

    notifyListeners();
  }

  void addLink(heading, link) async {
    await taskRepo.addLinks(heading, link, tasks![curr].docId.toString(), curr);
    notifyListeners();
  }
}
