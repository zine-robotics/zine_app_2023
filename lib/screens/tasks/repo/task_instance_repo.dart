import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:zineapp2023/backend_properties.dart';
import 'package:http/http.dart' as http;
import 'package:zineapp2023/models/newTask.dart';
import 'package:zineapp2023/models/task_instance.dart';
import 'package:zineapp2023/providers/user_info.dart';

class TaskInstanceRepo {
  final UserProv userProv;
  String _uid = "";
  TaskInstanceRepo({required this.userProv}) {
    _uid = userProv.getUserInfo.uid!;
  }

  Future<List<UserTaskInstance>> getTaskInstances() async {
    List<UserTaskInstance> taskInstances = [];

    Response res = await http.get(BackendProperties.taskInstanceByIdUri,
        headers: {'Authorization': 'Bearer $_uid'});
    print("Called get Tasks");
    print(res.body);

    if (res.statusCode == 200 && res.body.isNotEmpty) {
      Map<String, dynamic> resBody = jsonDecode(res.body);
      var instances = resBody['instances'] as List;
      taskInstances = instances
          .map((instance) => UserTaskInstance(
              instanceId: instance['id'],
              title: instance['name'],
              roomId: 0,
              task: UserNewTask.fromJson(
                instance['task'],
              )))
          .toList();

      return taskInstances;
    }

    return [];
  }

  Future<List<Checkpoint>> getCheckpoints(int instanceId) async {
    Response res = await http.get(
        BackendProperties.instanceCheckpointUri(instanceId),
        headers: {'Authorization': 'Bearer $_uid'});

    if (res.statusCode == 200 && res.body.isNotEmpty) {
      Map<String, dynamic> resBody = jsonDecode(res.body);
      var checkPointJson = resBody['checkpoints'] as List;
      return checkPointJson
          .map((checkpoint) => Checkpoint.fromJson(checkpoint))
          .toList();
    }

    return [];
  }

  Future<void> addCheckpoints(String message, int instanceId) async {
    try {
      Response res = await http.post(
          BackendProperties.addCheckpointUri(instanceId),
          body: jsonEncode({"content": message, "remark": "false"}),
          headers: {
            'Authorization': 'Bearer $_uid',
            'Content-Type': 'application/json',
          });

      if (res.statusCode == 200) {
        if (kDebugMode) print(res.body);
      } else {
        if (kDebugMode) print("Add checkpoint reponse error ${res.body}");
      }
    } catch (e) {
      if (kDebugMode) print("Add checkpoint error");
    }
  }
}
