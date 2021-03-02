class LeaveDataModels {
  int requestID;
  String startDateTime;
  String endDateTime;
  int typeLeaveID;
  String typeName;
  String leaveType;
  String detail;
  String statusType;
  int statusVal;
  LeaveDataModels(
      {this.requestID,
      this.startDateTime,
      this.endDateTime,
      this.typeLeaveID,
      this.typeName,
      this.leaveType,
      this.detail,
      this.statusType,
      this.statusVal});
  LeaveDataModels.fromJson(Map<String, dynamic> json) {
    requestID = json['requestID'];
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    typeLeaveID = json['typeLeaveID'];
    typeName = json['typeName'];
    leaveType = json['leaveType'];
    detail = json['detail'];
    statusType = json['statusType'];
    statusVal = json['statusVal'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestID'] = this.requestID;
    data['startDateTime'] = this.startDateTime;
    data['endDateTime'] = this.endDateTime;
    data['typeLeaveID'] = this.typeLeaveID;
    data['typeName'] = this.typeName;
    data['leaveType'] = this.leaveType;
    data['detail'] = this.detail;
    data['statusType'] = this.statusType;
    data['statusVal'] = this.statusVal;
    return data;
  }
}

class ModelLeaveDetail {
  String requestID;
  String startDateTime;
  String endDateTime;
  String typeName;
  String leaveType;
  String detail;
  String statusType;
  String resStatus;
  String empID;
  String empName;
  String empPosition;
  List<WaitDetail> waitDetail;

  ModelLeaveDetail(
      {this.requestID,
      this.startDateTime,
      this.endDateTime,
      this.typeName,
      this.leaveType,
      this.detail,
      this.statusType,
      this.resStatus,
      this.empID,
      this.empName,
      this.empPosition,
      this.waitDetail});

  ModelLeaveDetail.fromJson(Map<String, dynamic> json) {
    requestID = json['requestID'];
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    typeName = json['typeName'];
    leaveType = json['leaveType'];
    detail = json['detail'];
    statusType = json['statusType'];
    resStatus = json['resStatus'];
    empID = json['empID'];
    empName = json['empName'];
    empPosition = json['empPosition'];
    if (json['waitDetail'] != null) {
      waitDetail = new List<WaitDetail>();
      json['waitDetail'].forEach((v) {
        waitDetail.add(new WaitDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestID'] = this.requestID;
    data['startDateTime'] = this.startDateTime;
    data['endDateTime'] = this.endDateTime;
    data['typeName'] = this.typeName;
    data['leaveType'] = this.leaveType;
    data['detail'] = this.detail;
    data['statusType'] = this.statusType;
    data['resStatus'] = this.resStatus;
    data['empID'] = this.empID;
    data['empName'] = this.empName;
    data['empPosition'] = this.empPosition;
    if (this.waitDetail != null) {
      data['waitDetail'] = this.waitDetail.map((v) => v.toJson()).toList();
    } else {
      data['waitDetail'] = null;
    }
    return data;
  }
}

class WaitDetail {
  String sendDate;
  String statusApprove;
  String bfullName;
  String bposition;
  String btel;
  String detail;
  String reason;
  String BempID;
  String statusText;
  int status;

  WaitDetail({
    this.sendDate,
    this.statusApprove,
    this.bfullName,
    this.bposition,
    this.btel,
    this.detail,
    this.reason,
    this.BempID,
    this.statusText,
    this.status,
  });

  WaitDetail.fromJson(Map<String, dynamic> json) {
    sendDate = json['SendDate'];
    statusApprove = json['StatusApprove'];
    bfullName = json['BfullName'];
    bposition = json['Bposition'];
    btel = json['Btel'];
    detail = json['detail'];
    reason = json['reason'];
    BempID = json['BempID'];
    status = json['status'];
    statusText = json['statusText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SendDate'] = this.sendDate;
    data['StatusApprove'] = this.statusApprove;
    data['BfullName'] = this.bfullName;
    data['Bposition'] = this.bposition;
    data['Btel'] = this.btel;
    data['detail'] = this.detail;
    data['reason'] = this.reason;
    data['BempID'] = this.BempID;
    data['status'] = this.status;
    data['statusText'] = this.statusText;
    return data;
  }
}

//===========================================
class ModelImage {
  String Image;
  ModelImage({this.Image});
  ModelImage.fromJson(Map<String, dynamic> json) {
    Image = json['data'];
  }
}

class LeaveApproved {
  var requestID;
  var startDateTime;
  var endDateTime;
  var typeLeaveID;
  var typeName;
  var leaveType;
  var detail;

  LeaveApproved(
      {this.requestID,
      this.startDateTime,
      this.endDateTime,
      this.typeLeaveID,
      this.typeName,
      this.leaveType,
      this.detail});

  factory LeaveApproved.fromJson(Map<String, dynamic> json) {
    return LeaveApproved(
        requestID: json['requestID'],
        startDateTime: json['startDateTime'],
        endDateTime: json['endDateTime'],
        typeLeaveID: json['typeLeaveID'],
        typeName: json['typeName'],
        leaveType: json['leaveType'],
        detail: json['detail']);
  }
}

class GetApprovePerson {
  int employeeID;
  String fullName;
  String employeeIDNo;

  GetApprovePerson({this.employeeID, this.fullName, this.employeeIDNo});
  GetApprovePerson.fromJson(Map<String, dynamic> json) {
    employeeID = json['employeeID'];
    fullName = json['fullName'];
    employeeIDNo = json['employeeIDNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeID'] = this.employeeID;
    data['fullName'] = this.fullName;
    data['employeeIDNo'] = this.employeeIDNo;
    return data;
  }
}

class FormGetLeave {
  List<EmpApproveLeave> approved;
  List<LeaveForm> leaveForm;
  bool waitDetail;
  FormGetLeave({this.approved, this.leaveForm});
  FormGetLeave.fromJson(Map<String, dynamic> json) {
    approved = json['approved']
        .map<EmpApproveLeave>((json) => EmpApproveLeave.fromJson(json))
        .toList();
    leaveForm = json['data']
        .map<LeaveForm>((json) => LeaveForm.fromJson(json))
        .toList();
    waitDetail = json['waitDetail'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['approved'] = this.approved;
    data['data'] = this.leaveForm;
    data['waitDetail'] = this.waitDetail;
    return data;
  }
}

class LeaveForm {
  String typeLeave;
  int leaveID;
  String leaveName;
  String dateSelect;
  String useIN;
  int statusCut;
  String leaveTimeDetail;
  int timeLimit;
  int leaveTime;
  int canLeaveTime;
  int val;
  bool action;

  LeaveForm(
      {this.typeLeave,
      this.leaveID,
      this.leaveName,
      this.dateSelect,
      this.useIN,
      this.statusCut,
      this.leaveTimeDetail,
      this.timeLimit,
      this.leaveTime,
      this.canLeaveTime,
      this.val,
      this.action});

  LeaveForm.fromJson(Map<String, dynamic> json) {
    typeLeave = json['typeLeave'];
    leaveID = json['leaveID'];
    leaveName = json['leaveName'];
    dateSelect = json['dateSelect'];
    useIN = json['useIN'];
    statusCut = json['statusCut'];
    leaveTimeDetail = json['leaveTimeDetail'];
    timeLimit = json['timeLimit'];
    leaveTime = json['leaveTime'];
    canLeaveTime = json['canLeaveTime'];
    val = json['val'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeLeave'] = this.typeLeave;
    data['leaveID'] = this.leaveID;
    data['leaveName'] = this.leaveName;
    data['dateSelect'] = this.dateSelect;
    data['useIN'] = this.useIN;
    data['statusCut'] = this.statusCut;
    data['leaveTimeDetail'] = this.leaveTimeDetail;
    data['timeLimit'] = this.timeLimit;
    data['leaveTime'] = this.leaveTime;
    data['canLeaveTime'] = this.canLeaveTime;
    data['val'] = this.val;
    data['action'] = this.action;
    return data;
  }
}

class EmpApproveLeave {
  int employeeID;
  String employeeIDNo;
  String fullName;
  String tel;
  int unitID;
  int sectionID;
  int depID;
  String depName;
  int positionID;
  String positionName;
  bool next;
  Null attoney;

  EmpApproveLeave(
      {this.employeeID,
      this.employeeIDNo,
      this.fullName,
      this.tel,
      this.unitID,
      this.sectionID,
      this.depID,
      this.depName,
      this.positionID,
      this.positionName,
      this.next,
      this.attoney});

  EmpApproveLeave.fromJson(Map<String, dynamic> json) {
    employeeID = json['employeeID'];
    employeeIDNo = json['employeeIDNo'];
    fullName = json['fullName'];
    tel = json['tel'];
    unitID = json['unitID'];
    sectionID = json['sectionID'];
    depID = json['depID'];
    depName = json['depName'];
    positionID = json['positionID'];
    positionName = json['positionName'];
    next = json['next'];
    attoney = json['attoney'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeID'] = this.employeeID;
    data['employeeIDNo'] = this.employeeIDNo;
    data['fullName'] = this.fullName;
    data['tel'] = this.tel;
    data['unitID'] = this.unitID;
    data['sectionID'] = this.sectionID;
    data['depID'] = this.depID;
    data['depName'] = this.depName;
    data['positionID'] = this.positionID;
    data['positionName'] = this.positionName;
    data['next'] = this.next;
    data['attoney'] = this.attoney;
    return data;
  }
}
