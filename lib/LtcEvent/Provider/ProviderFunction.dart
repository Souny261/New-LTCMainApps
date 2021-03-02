import 'package:flutter/material.dart';
import 'package:ltcmainapp/LtcEvent/Controller/EventModel.dart';
import 'package:ltcmainapp/LtcEvent/Provider/ProviderModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkProcessProvider extends ChangeNotifier {
  List<WorkProcessModel> commentList = [];
  addTaskInList(
      {String comment,
      String time,
      String id,
      int leght,
      List<Attract> listAttr}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (leght == 1) {
      if (pref.getString("commentProvider") == null) {
        WorkProcessModel taskModel = WorkProcessModel(
            comment: comment, commentTime: time, id: id, listAttr: listAttr);
        commentList.add(taskModel);
        notifyListeners();
      } else {
        print("object");
      }
    } else {
      WorkProcessModel taskModel = WorkProcessModel(
          comment: comment, commentTime: time, id: id, listAttr: listAttr);
      commentList.add(taskModel);
      notifyListeners();
    }
  }
}

class TodoModel1 extends ChangeNotifier {
  List<TaskModel> taskList = []; //contians all the task
  addTaskInList(String title, String detail) {
    TaskModel taskModel = TaskModel(" $title ${taskList.length}",
        "this is the task no $detail ${taskList.length}");
    taskList.add(taskModel);
    notifyListeners();
    //code to do
  }
}
