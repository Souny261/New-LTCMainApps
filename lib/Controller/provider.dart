import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:ltcmainapp/Leave/Controllers/leaveService.dart';


class Counter with ChangeNotifier, DiagnosticableTreeMixin {
  String _count = "0";
  String get count => _count;
  void increment(String val) {
    _count = val;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('count', count));
  }
}

class TodoModel extends ChangeNotifier {
  List<ResultLeaveWaiting> leaveWaitList = []; //contians all the task
  addTaskInList(list) {
    ResultLeaveWaiting taskModel = ResultLeaveWaiting(detail: list);
    print("df,df,odlf" + list.toString());
    leaveWaitList.add(taskModel);
    notifyListeners();
    //code to do
  }
}

class WorkingTimeStart with ChangeNotifier, DiagnosticableTreeMixin {
  String time = "00:00";
  String get mytime => time;
  void increment(String val) {
    time = val;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('time', mytime));
  }
}

class WorkingTimeEnd with ChangeNotifier, DiagnosticableTreeMixin {
  String time = "00:00";
  String get mytime => time;
  void increment(String val) {
    time = val;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('time', mytime));
  }
}