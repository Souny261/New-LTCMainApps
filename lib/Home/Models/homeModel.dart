import 'package:intl/intl.dart';
import 'package:ltcmainapp/LtcEvent/Controller/EventModel.dart';

class ChVersion {
  String version;
  String url;
  String name;
  ChVersion({this.version, this.url, this.name});
  ChVersion.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    url = json['url'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    data['url'] = this.url;
    data['name'] = this.name;
    return data;
  }
}

class CheckIn {
  String res;
  String result;
  String content;
  String url;
  CheckIn({this.res, this.result, this.content, this.url});
  CheckIn.fromJson(Map<String, dynamic> json) {
    res = json['res'];
    result = json['result'];
    content = json['text'];
    url = json['url'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['res'] = this.res;
    data['result'] = this.result;
    data['text'] = this.content;
    data['url'] = this.url;
    return data;
  }
}

class LeaveProfileData {
  var profileStatus = '...';
  var leaveType = '...';
  var cntDays = '...';
  var leaveTypeID = '...';
  List<LeaveDetail> leaveDetail;
  LeaveProfileData(
      {this.profileStatus,
      this.leaveType,
      this.cntDays,
      this.leaveTypeID,
      this.leaveDetail});
  factory LeaveProfileData.fromJson(Map<String, dynamic> json) {
    return LeaveProfileData(
        profileStatus: json['profileStatus'],
        leaveType: json['leaveType'],
        cntDays: json['cntDays'],
        leaveTypeID: json['leaveTypeID'].toString(),
        leaveDetail: json['leaveDetail']
            .map<LeaveDetail>((json) => LeaveDetail.fromJson(json))
            .toList());
  }
}

class WorkingTime {
  String OnDayToday;
  String inTime, outTime;
  String This;

  WorkingTime({this.OnDayToday, this.inTime, this.outTime, this.This});
  WorkingTime.fromJson(Map<String, dynamic> json) {
    OnDayToday = json['OnDay'];
    inTime = json['inTime'];
    outTime = json['outTime'];
    This = DateFormat("dd-MM-yyyy").format(DateTime.parse(json['This']));
  }
}

class LeaveDetail {
  int requestID;
  String startDate;
  String endDate;
  String leaveTypeName;
  String detail;
  String typeLeave;

  LeaveDetail(
      {this.requestID,
      this.startDate,
      this.endDate,
      this.leaveTypeName,
      this.detail,
      this.typeLeave});

  LeaveDetail.fromJson(Map<String, dynamic> json) {
    requestID = json['requestID'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    leaveTypeName = json['leaveTypeName'];
    detail = json['detail'];
    typeLeave = json['TypeLeave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestID'] = this.requestID;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['leaveTypeName'] = this.leaveTypeName;
    data['detail'] = this.detail;
    data['TypeLeave'] = this.typeLeave;
    return data;
  }
}

class HomeData {
  List<WorkingTime> workingTime;
  List<LeaveProfileData> leaveProfileData;
  List<EventModel> eventModel;
  HomeData({this.workingTime, this.leaveProfileData, this.eventModel});
  HomeData.fromJson(Map<String, dynamic> json) {
    eventModel = json['eventData']
        .map<EventModel>((json) => EventModel.fromJson(json))
        .toList();
    workingTime = json['data']
        .map<WorkingTime>((json) => WorkingTime.fromJson(json))
        .toList();
    if (json['leaveData'] == null) {
      leaveProfileData = [];
    } else {
      leaveProfileData = json['leaveData']
          .map<LeaveProfileData>((json) => LeaveProfileData.fromJson(json))
          .toList();
    }
  }
  // leaveProfileData = json['leaveData']
  //     .map<LeaveProfileData>((json) => LeaveProfileData.fromJson(json))
  //     .toList();
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['approved'] =  this.leaveProfileData;
    data['data'] = this.workingTime;
    data['eventData'] = this.eventModel;
    return data;
  }
}
