import "package:flutter/material.dart";
import 'package:zineapp2023/models/tasks.dart';
import 'package:zineapp2023/screens/tasks/repo/task_repo.dart';
import '../../../common/data_store.dart';
import '../../../providers/user_info.dart';

class TaskVm extends ChangeNotifier {
  final DataStore store;
  final UserProv userProv;
  final taskRepo = TaskRepo();
  TaskVm({required this.store, required this.userProv});
  List<Tasks> _tasks = [];
  String _name = "";
  String _description = "";
  String _type = "";
  String _status = "";
  String _dueDate = "";
  List<String> _members = [];
  String timeStamp = "";
  get name => _name;

  get type => _type;

  get description => _description;

  get status => _status;

  get tasks => _tasks;
  get dueDate => _dueDate;

  setName(String value) {
    _name = value;
  }

  setType(String value) {
    _type = value;
  }

  setStatus(String value) {
    _status = value;
  }

  setDescription(String value) {
    _description = value;
  }

  setMembers(String value) {
    _members.add(value);
  }

  void getRecentEvent() async {
    _tasks = await taskRepo.getEvents();
    notifyListeners();
  }

  void postNewTask() async {
    var data = {
      'name': _name,
      'status': _status,
      'type': _type,
      'description': _description,
      'members': _members,
      'dueDate': _dueDate
    };
    taskRepo.postEvent(data);
  }
}
