
class EmpData {
  int employeeID;
  String employeeIDNo;
  String fullName;
  String tel;
  String positionName;
  String sectionName;
  String depName;

  EmpData(
      {this.employeeID,
      this.employeeIDNo,
      this.fullName,
      this.tel,
      this.positionName,
      this.sectionName,
      this.depName});

  EmpData.fromJson(Map<String, dynamic> json) {
    employeeID = json['employeeID'];
    employeeIDNo = json['employeeIDNo'];
    fullName = json['fullName'];
    tel = json['tel'];
    positionName = json['positionName'];
    sectionName = json['sectionName'];
    depName = json['depName'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeID'] = this.employeeID;
    data['employeeIDNo'] = this.employeeIDNo;
    data['fullName'] = this.fullName;
    data['tel'] = this.tel;
    data['positionName'] = this.positionName;
    data['sectionName'] = this.sectionName;
    data['depName'] = this.depName;
    return data;
  }
}