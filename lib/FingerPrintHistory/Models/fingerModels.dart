import 'package:intl/intl.dart';

import 'package:ltcmainapp/FingerPrintHistory/DB/database_provider.dart';

class FingerListMonth {
  final String month;
  const FingerListMonth({this.month});
  factory FingerListMonth.fromJson(Map<String, dynamic> json) {
    return FingerListMonth(month: json['month']);
  }
}

class FingerTotalMonth {
  String SystemTotalTime;
  String CountDay;
  String TotalInMonth;
  String TotalLeave;
  String TotalPerLeave;
  String TotalCutLeave;
  String GetTotalThisMonth;
  String TextDetail;
  String UseTimeForEmployee;

  FingerTotalMonth(
      {this.SystemTotalTime,
      this.CountDay,
      this.TotalInMonth,
      this.TotalLeave,
      this.TotalPerLeave,
      this.TotalCutLeave,
      this.GetTotalThisMonth,
      this.TextDetail,
      this.UseTimeForEmployee});

  FingerTotalMonth.fromJson(Map<String, dynamic> json) {
    SystemTotalTime = json['SystemTotalTime'];
    CountDay = json['CountDay'];
    TotalInMonth = json['TotalInMonth'];
    TotalLeave = json['TotalLeave'];
    TotalPerLeave = json['TotalPerLeave'];
    TotalCutLeave = json['TotalCutLeave'];
    GetTotalThisMonth = json['GetTotalThisMonth'];
    TextDetail = json['TextDetail'];
    UseTimeForEmployee = json['UseTimeForEmployee'];
  }
}

class FingerList {
  String This;
  String Finger;
  String LeaveNormal;
  String LeaveCut;
  String Person;
  String OnDay;
  String inTime, outTime;

  FingerList(
      {this.This,
      this.Finger,
      this.LeaveNormal,
      this.LeaveCut,
      this.Person,
      this.OnDay,
      this.inTime,
      this.outTime});

  factory FingerList.fromJson(Map<String, dynamic> json) {
    return FingerList(
        This: DateFormat("dd-MM-yyyy").format(DateTime.parse(json['This'])),
        Finger: json['Finger'],
        LeaveNormal: json['LeaveNormal'],
        LeaveCut: json['LeaveCut'],
        Person: json['Person'],
        OnDay: json['OnDay'],
        inTime: json['inTime'],
        outTime: json['outTime']);
  }
}

class TotalMonthFinger {
  String SystemTotalTime;
  String CountDay;
  String TotalInMonth;
  String TotalLeave;
  String TotalPerLeave;
  String TotalCutLeave;
  String GetTotalThisMonth;
  String TextDetail;
  String UseTimeForEmployee;

  TotalMonthFinger(
      {this.SystemTotalTime,
      this.CountDay,
      this.TotalInMonth,
      this.TotalLeave,
      this.TotalPerLeave,
      this.TotalCutLeave,
      this.GetTotalThisMonth,
      this.TextDetail,
      this.UseTimeForEmployee});

  TotalMonthFinger.fromJson(Map<String, dynamic> json) {
    SystemTotalTime = json['SystemTotalTime'];
    CountDay = json['CountDay'];
    TotalInMonth = json['TotalInMonth'];
    TotalLeave = json['TotalLeave'];
    TotalPerLeave = json['TotalPerLeave'];
    TotalCutLeave = json['TotalCutLeave'];
    GetTotalThisMonth = json['GetTotalThisMonth'];
    TextDetail = json['TextDetail'];
    UseTimeForEmployee = json['UseTimeForEmployee'];
  }
}

class SumFingerModels {
  String Finger;
  String dateTime;
  String inTime;
  String outTime;
  String leaveCut;
  String leaveNormal;
  String leavePerson;
  String OnDay;

  SumFingerModels(
      {this.Finger,
      this.dateTime,
      this.inTime,
      this.outTime,
      this.leaveCut,
      this.leaveNormal,
      this.leavePerson,
      this.OnDay});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.Finger: Finger,
      DatabaseProvider.dateTime: dateTime,
      DatabaseProvider.inTime: inTime,
      DatabaseProvider.outTime: outTime,
      DatabaseProvider.leaveCut: leaveCut,
      DatabaseProvider.leaveNormal: leaveNormal,
      DatabaseProvider.leavePerson: leavePerson,
      DatabaseProvider.OnDay: OnDay,
    };
    return map;
  }

  SumFingerModels.fromMap(Map<String, dynamic> map) {
    Finger = map[DatabaseProvider.Finger];
    dateTime = map[DatabaseProvider.dateTime];
    inTime = map[DatabaseProvider.inTime];
    outTime = map[DatabaseProvider.outTime];
    leaveCut = map[DatabaseProvider.leaveCut];
    leaveNormal = map[DatabaseProvider.leaveNormal];
    leavePerson = map[DatabaseProvider.leavePerson];
    OnDay = map[DatabaseProvider.OnDay];
  }
}
