class EventModel {
  String sectionName;
  String codeActive;
  int formInviteID;
  int eventID;
  int fmID;
  int empID;
  String inDate;
  String startTime;
  String endTime;
  String eventTypeCheckIn;
  int eventTypeCheckInID;
  String evGroupName;
  String fmTitle;
  String fmDetail;
  String fmAddress;
  String fmCreateBy;
  String fullName;
  String depName;
  String positionName;
  String tel;
  String eventBG;
  String createDate;
  List<Documents> documents;
  List<Users> users;
  List<WorkProcess> listFormChoice;

  EventModel(
      {this.codeActive,
      this.formInviteID,
      this.eventID,
      this.fmID,
      this.empID,
      this.inDate,
      this.startTime,
      this.endTime,
      this.eventTypeCheckIn,
      this.eventTypeCheckInID,
      this.evGroupName,
      this.fmTitle,
      this.fmDetail,
      this.fmAddress,
      this.fmCreateBy,
      this.fullName,
      this.depName,
      this.positionName,
      this.tel,
      this.eventBG,
      this.createDate,
      this.documents,
      this.users,
      this.listFormChoice,
      this.sectionName});

  EventModel.fromJson(Map<String, dynamic> json) {
    sectionName = json['sectionName'];
    codeActive = json['codeActive'];
    formInviteID = json['formInviteID'];
    eventID = json['eventID'];
    fmID = json['fmID'];
    empID = json['empID'];
    inDate = json['inDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    eventTypeCheckIn = json['eventTypeCheckIn'];
    eventTypeCheckInID = json['eventTypeCheckInID'];
    evGroupName = json['evGroupName'];
    fmTitle = json['fmTitle'];
    fmDetail = json['fmDetail'];
    fmAddress = json['fmAddress'];
    fmCreateBy = json['fmCreateBy'];
    fullName = json['fullName'];
    depName = json['depName'];
    positionName = json['positionName'];
    tel = json['tel'];
    eventBG = json['eventBG'];
    createDate = json['createDate'];

    documents = json['Documents']
        .map<Documents>((json) => Documents.fromJson(json))
        .toList();
    users =
        json['ListUsers'].map<Users>((json) => Users.fromJson(json)).toList();
    listFormChoice = json['ListFormChoice']
        .map<WorkProcess>((json) => WorkProcess.fromJson(json))
        .toList();
    // if (json['Documents'] != null) {
    //   documents = new List<Null>();
    //   json['Documents'].forEach((v) {
    //     documents.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sectionName'] = this.sectionName;
    data['codeActive'] = this.codeActive;
    data['formInviteID'] = this.formInviteID;
    data['eventID'] = this.eventID;
    data['fmID'] = this.fmID;
    data['empID'] = this.empID;
    data['inDate'] = this.inDate;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['eventTypeCheckIn'] = this.eventTypeCheckIn;
    data['eventTypeCheckInID'] = this.eventTypeCheckInID;
    data['evGroupName'] = this.evGroupName;
    data['fmTitle'] = this.fmTitle;
    data['fmDetail'] = this.fmDetail;
    data['fmAddress'] = this.fmAddress;
    data['fmCreateBy'] = this.fmCreateBy;
    data['fullName'] = this.fullName;
    data['depName'] = this.depName;
    data['positionName'] = this.positionName;
    data['tel'] = this.tel;
    data['eventBG'] = this.eventBG;
    data['createDate'] = this.createDate;
    data['Documents'] = this.documents;
    data['ListUsers'] = this.users;
    data['ListFormChoice'] = this.listFormChoice;

    // if (this.documents != null) {
    //   data['Documents'] = this.documents.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Documents {
  String url;
  String fileName;
  String fileType;

  Documents({this.url, this.fileName, this.fileType});

  Documents.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    fileName = json['fileName'];
    fileType = json['fileType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['fileName'] = this.fileName;
    data['fileType'] = this.fileType;
    return data;
  }
}

class Users {
  String image;
  int empID;
  String inDate;
  String startTime;
  String endTime;
  String fullName;
  String depNam;
  String positionName;
  String tel;

  Users(
      {this.image,
      this.empID,
      this.inDate,
      this.startTime,
      this.endTime,
      this.fullName,
      this.depNam,
      this.positionName,
      this.tel});

  Users.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    empID = json['empID'];
    inDate = json['inDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    fullName = json['fullName'];
    depNam = json['depName'];
    positionName = json['positionName'];
    tel = json['tel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['empID'] = this.empID;
    data['inDate'] = this.inDate;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['fullName'] = this.fullName;
    data['depName'] = this.depNam;
    data['positionName'] = this.positionName;
    data['tel'] = this.tel;
    return data;
  }
}

class WorkProcess {
  int choiceID;
  int eventID;
  String choiceName;
  List<ListChoice> empAnswers;

  WorkProcess({this.choiceID, this.eventID, this.choiceName, this.empAnswers});
  WorkProcess.fromJson(Map<String, dynamic> json) {
    choiceID = json['choiceID'];
    eventID = json['eventID'];
    choiceName = json['choiceName'];
    empAnswers = json['empAnswers']
        .map<ListChoice>((json) => ListChoice.fromJson(json))
        .toList();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['choiceID'] = this.choiceID;
    data['eventID'] = this.eventID;
    data['choiceName'] = this.choiceName;
    data['empAnswers'] = this.empAnswers;
    return data;
  }
}

class ListChoice {
  int choiceID;
  String comment;
  String commentTime;
  List<Attract> listAttr;

  ListChoice({this.choiceID, this.comment, this.commentTime, this.listAttr});
  ListChoice.fromJson(Map<String, dynamic> json) {
    choiceID = json['choiceID'];
    comment = json['comment'];
    commentTime = json['commentTime'];
    listAttr = json['listAttr']
        .map<Attract>((json) => Attract.fromJson(json))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['choiceID'] = this.choiceID;
    data['comment'] = this.comment;
    data['commentTime'] = this.commentTime;
    data['listAttr'] = this.listAttr;
    return data;
  }
}

class Attract {
  String url;
  String createTime;
  Attract({this.url, this.createTime});
  Attract.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    createTime = json['createTime'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['createTime'] = this.createTime;
    return data;
  }
}

class AddCommentModel {
  String cmID;
  String choiceID;
  String comment;
  String commentTime;
  List<Attract> listAttr;

  AddCommentModel(
      {this.cmID,
      this.choiceID,
      this.comment,
      this.commentTime,
      this.listAttr});

  AddCommentModel.fromJson(Map<String, dynamic> json) {
    cmID = json['cmID'];
    choiceID = json['choiceID'].toString();
    comment = json['comment'];
    commentTime = json['commentTime'];
    listAttr = json['listAttr']
        .map<Attract>((json) => Attract.fromJson(json))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cmID'] = this.cmID;
    data['choiceID'] = this.choiceID;
    data['comment'] = this.comment;
    data['commentTime'] = this.commentTime;
    data['listAttr'] = this.listAttr;
    return data;
  }
}
