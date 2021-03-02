import 'package:ltcmainapp/LtcEvent/Controller/EventModel.dart';

class WorkProcessModel {
  String comment;
  String commentTime;
  String id;
  List<Attract> listAttr;
  String get getName => comment;
  String get getTime => commentTime;
  String get getId => id;
  List<Attract> get getListAttr => listAttr;
  WorkProcessModel({this.comment, this.commentTime, this.id, this.listAttr});
}

class TaskModel {
  String title;
  String detail;
  String get getTitle => title;
  String get getDetail => detail;
  TaskModel(this.title, this.detail);
}
