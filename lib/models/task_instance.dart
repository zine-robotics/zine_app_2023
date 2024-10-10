/*{
            "taskInstanceId": 52,
            "taskId": {
                "id": 152,
                "createdDate": 1715491800000,
                "title": "update-task-name-second",
                "subtitle": "test-task-subtile",
                "description": "test-task-description",
                "dueDate": 1715491800000,
                "psLink": null,
                "submissionLink": null,
                "type": "Individual",
                "recruitment": null,
                "visible": false
            },
            "roomId": {
                "id": 652,
                "name": "task instance",
                "description": null,
                "type": "project",
                "dpUrl": null,
                "timestamp": null
            },
            "type": "individual",
            "name": null,
            "status": null,
            "completionPercentage": null
        },
*/

import 'package:zineapp2023/models/newTask.dart';
import 'package:zineapp2023/models/userTask.dart';

class UserTaskInstance {
  String? title;
  int? instanceId;
  UserNewTask task;
  int? roomId;

  UserTaskInstance(
      {required this.title,
      required this.instanceId,
      required this.task,
      this.roomId});

  UserTaskInstance.fromJson(Map<String, dynamic> json)
      : task = UserNewTask.fromJson(json['task']) {
    roomId = json['roomId']['id'];
    instanceId = json['id'];
    title = json['name'];
  }
}

enum InstanceType { group, individual }
