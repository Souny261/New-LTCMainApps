class AllCheckIn {
  String info;
  String type;
  AllCheckIn({this.info, this.type});
  AllCheckIn.fromJson(Map<String, dynamic> json) {
    info = json['info'];
    type = json['type'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['info'] = this.info;
    data['type'] = this.type;
    return data;
  }
}

class DataInvite {
  final String aiID;
  final String inviteID;
  final String title;
  final String detail;
  final String room;
  final String inviteBy;
  final String inviteCode;
  final String createDate;
  final bool opening;
  final String cntOpen;
  final String openDate;
  final String activeCheckIn;
  final List acListFile;
  final List acListCheckedTime;

  const DataInvite(
      {this.aiID,
      this.inviteID,
      this.title,
      this.detail,
      this.room,
      this.inviteBy,
      this.inviteCode,
      this.createDate,
      this.opening,
      this.cntOpen,
      this.openDate,
      this.activeCheckIn,
      this.acListFile,
      this.acListCheckedTime});

  factory DataInvite.fromJson(Map<String, dynamic> json) {
    return DataInvite(
      aiID: json['aiID'],
      inviteID: json['inviteID'],
      title: json['title'],
      detail: json['detail'],
      room: json['room'],
      inviteBy: json['inviteBy'],
      inviteCode: json['inviteCode'],
      createDate: json['createDate'],
      opening: json['opening'],
      cntOpen: json['cntOpen'],
      openDate: json['openDate'],
      activeCheckIn: json['activeCheckIn'],
      acListFile: json['acListFile'],
      acListCheckedTime: json['acListCheckedTime'] as List,
    );
  }
}

class DataEventActive {
  final int atID;
  final String title;
  final String room;
  final String invite_by;
  final String sdate;
  final String edate;
  final int emp_join;
  final int emp_checkin;
  final String type;
  final int cntCheck;

  const DataEventActive(
      {this.atID,
      this.title,
      this.room,
      this.invite_by,
      this.sdate,
      this.edate,
      this.emp_join,
      this.emp_checkin,
      this.type,
      this.cntCheck});

  factory DataEventActive.fromJson(Map<String, dynamic> json) {
    return DataEventActive(
        atID: json['atID'],
        title: json['title'],
        room: json['room'],
        invite_by: json['invite_by'],
        sdate: json['sdate'],
        edate: json['edate'],
        emp_join: json['emp_join'],
        emp_checkin: json['emp_checkin'],
        type: json['type'],
        cntCheck: json['cnt']);
  }
}
