class UserDetail {
  String empIDNo;
  String fullNameLa;
  String fullNameEn;
  int age;
  String genderName;
  String empTypeName;
  String dateStart;
  String dateEnd;
  String dateTrain;
  String dateTrainEnd;
  String dateWork;
  String dateOutWork;
  String dateBirth;
  String dateExpire;
  String tel;
  String email;
  String fileName;
  String zoneName;
  String depName;
  String sectionName;
  String unitName;
  String positionName;
  String positionTypeName;
  int positionID;
  UserDetail(
      {this.empIDNo,
      this.fullNameLa,
      this.fullNameEn,
      this.age,
      this.genderName,
      this.empTypeName,
      this.dateStart,
      this.dateEnd,
      this.dateTrain,
      this.dateTrainEnd,
      this.dateWork,
      this.dateOutWork,
      this.dateBirth,
      this.dateExpire,
      this.tel,
      this.email,
      this.fileName,
      this.zoneName,
      this.depName,
      this.sectionName,
      this.unitName,
      this.positionName,
      this.positionTypeName,
      this.positionID});
  UserDetail.fromJson(Map<String, dynamic> json) {
    empIDNo = json['empIDNo'];
    fullNameLa = json['fullNameLa'];
    fullNameEn = json['fullNameEn'];
    age = json['Age'];
    genderName = json['genderName'];
    empTypeName = json['empTypeName'];
    dateStart = json['dateStart'];
    dateEnd = json['dateEnd'];
    dateTrain = json['dateTrain'];
    dateTrainEnd = json['dateTrainEnd'];
    dateWork = json['dateWork'];
    dateOutWork = json['dateOutWork'];
    dateBirth = json['dateBirth'];
    dateExpire = json['dateExpire'];
    tel = json['tel'];
    email = json['email'];
    fileName = json['fileName'];
    zoneName = json['zoneName'];
    depName = json['depName'];
    sectionName = json['sectionName'];
    unitName = json['unitName'];
    positionName = json['positionName'];
    positionTypeName = json['positionTypeName'];
    positionID = json['positionID'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empIDNo'] = this.empIDNo;
    data['fullNameLa'] = this.fullNameLa;
    data['fullNameEn'] = this.fullNameEn;
    data['Age'] = this.age;
    data['genderName'] = this.genderName;
    data['empTypeName'] = this.empTypeName;
    data['dateStart'] = this.dateStart;
    data['dateEnd'] = this.dateEnd;
    data['dateTrain'] = this.dateTrain;
    data['dateTrainEnd'] = this.dateTrainEnd;
    data['dateWork'] = this.dateWork;
    data['dateOutWork'] = this.dateOutWork;
    data['dateBirth'] = this.dateBirth;
    data['dateExpire'] = this.dateExpire;
    data['tel'] = this.tel;
    data['email'] = this.email;
    data['fileName'] = this.fileName;
    data['zoneName'] = this.zoneName;
    data['depName'] = this.depName;
    data['sectionName'] = this.sectionName;
    data['unitName'] = this.unitName;
    data['positionName'] = this.positionName;
    data['positionTypeName'] = this.positionTypeName;
    data['positionID'] = this.positionID;
    return data;
  }
}

class SpecailGroup {
  String dateOrg;
  String orgName;
  String gorName;
  String uorName;

  SpecailGroup({this.dateOrg, this.orgName, this.gorName, this.uorName});

  SpecailGroup.fromJson(Map<String, dynamic> json) {
    dateOrg = json['dateOrg'];
    orgName = json['orgName'];
    gorName = json['gorName'];
    uorName = json['uorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateOrg'] = this.dateOrg;
    data['orgName'] = this.orgName;
    data['gorName'] = this.gorName;
    data['uorName'] = this.uorName;
    return data;
  }
}

class UserEducation1 {
  int startStudy;
  int endStudy;
  String degreeName;
  String facultyName;
  String schoolName;
  String countyName;
  String educationName;

  UserEducation1(
      {this.startStudy,
      this.endStudy,
      this.degreeName,
      this.facultyName,
      this.schoolName,
      this.countyName,
      this.educationName});

  UserEducation1.fromJson(Map<String, dynamic> json) {
    startStudy = json['startStudy'];
    endStudy = json['endStudy'];
    degreeName = json['degreeName'];
    facultyName = json['facultyName'];
    schoolName = json['schoolName'];
    countyName = json['countyName'];
    educationName = json['educationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startStudy'] = this.startStudy;
    data['endStudy'] = this.endStudy;
    data['degreeName'] = this.degreeName;
    data['facultyName'] = this.facultyName;
    data['schoolName'] = this.schoolName;
    data['countyName'] = this.countyName;
    data['educationName'] = this.educationName;
    return data;
  }
}

class Family {
  String dadyStatus;
  String dadyName;
  String dadyBirth;
  String dadyOccupation;
  String mumyStatus;
  String mumyName;
  String mumyBirth;
  String mumyOccupation;
  String spouseStatus;
  String spouseName;
  String spouseBirth;
  String spouseOccupation;

  Family(
      {this.dadyStatus,
      this.dadyName,
      this.dadyBirth,
      this.dadyOccupation,
      this.mumyStatus,
      this.mumyName,
      this.mumyBirth,
      this.mumyOccupation,
      this.spouseStatus,
      this.spouseName,
      this.spouseBirth,
      this.spouseOccupation});

  Family.fromJson(Map<String, dynamic> json) {
    dadyStatus = json['dadyStatus'];
    dadyName = json['dadyName'];
    dadyBirth = json['dadyBirth'];
    dadyOccupation = json['dadyOccupation'];
    mumyStatus = json['mumyStatus'];
    mumyName = json['mumyName'];
    mumyBirth = json['mumyBirth'];
    mumyOccupation = json['mumyOccupation'];
    spouseStatus = json['spouseStatus'];
    spouseName = json['spouseName'];
    spouseBirth = json['spouseBirth'];
    spouseOccupation = json['spouseOccupation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dadyStatus'] = this.dadyStatus;
    data['dadyName'] = this.dadyName;
    data['dadyBirth'] = this.dadyBirth;
    data['dadyOccupation'] = this.dadyOccupation;
    data['mumyStatus'] = this.mumyStatus;
    data['mumyName'] = this.mumyName;
    data['mumyBirth'] = this.mumyBirth;
    data['mumyOccupation'] = this.mumyOccupation;
    data['spouseStatus'] = this.spouseStatus;
    data['spouseName'] = this.spouseName;
    data['spouseBirth'] = this.spouseBirth;
    data['spouseOccupation'] = this.spouseOccupation;
    return data;
  }
}

class ChildModel {
  String genderName;
  String childName;
  String childTypeName;
  String hisChildBirth;
  String hisChildAddress;

  ChildModel(
      {this.genderName,
      this.childName,
      this.childTypeName,
      this.hisChildBirth,
      this.hisChildAddress});

  ChildModel.fromJson(Map<String, dynamic> json) {
    genderName = json['genderName'];
    childName = json['childName'];
    childTypeName = json['childTypeName'];
    hisChildBirth = json['hisChildBirth'];
    hisChildAddress = json['hisChildAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['genderName'] = this.genderName;
    data['childName'] = this.childName;
    data['childTypeName'] = this.childTypeName;
    data['hisChildBirth'] = this.hisChildBirth;
    data['hisChildAddress'] = this.hisChildAddress;
    return data;
  }
}

class Working {
  String hisWorkTitle;
  String hisWorkDate;
  String hisDepartment;
  String hisSectionName;
  String hisUnitName;
  String hisPositionName;

  Working(
      {this.hisWorkTitle,
      this.hisWorkDate,
      this.hisDepartment,
      this.hisSectionName,
      this.hisUnitName,
      this.hisPositionName});

  Working.fromJson(Map<String, dynamic> json) {
    hisWorkTitle = json['hisWorkTitle'];
    hisWorkDate = json['hisWorkDate'];
    hisDepartment = json['hisDepartment'];
    hisSectionName = json['hisSectionName'];
    hisUnitName = json['hisUnitName'];
    hisPositionName = json['hisPositionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hisWorkTitle'] = this.hisWorkTitle;
    data['hisWorkDate'] = this.hisWorkDate;
    data['hisDepartment'] = this.hisDepartment;
    data['hisSectionName'] = this.hisSectionName;
    data['hisUnitName'] = this.hisUnitName;
    data['hisPositionName'] = this.hisPositionName;
    return data;
  }
}

class Training {
  String courseName;
  String trainingTypeName;
  String trainCourseDateStart;
  String trainCourseDateEnd;
  String trainBranchName;
  String trainCourseLocation;
  String trainCourseHoteBy;
  String degreeTrainName;
  String statusTrainingName;

  Training(
      {this.courseName,
      this.trainingTypeName,
      this.trainCourseDateStart,
      this.trainCourseDateEnd,
      this.trainBranchName,
      this.trainCourseLocation,
      this.trainCourseHoteBy,
      this.degreeTrainName,
      this.statusTrainingName});

  Training.fromJson(Map<String, dynamic> json) {
    courseName = json['courseName'];
    trainingTypeName = json['trainingTypeName'];
    trainCourseDateStart = json['trainCourseDateStart'];
    trainCourseDateEnd = json['trainCourseDateEnd'];
    trainBranchName = json['trainBranchName'];
    trainCourseLocation = json['trainCourseLocation'];
    trainCourseHoteBy = json['trainCourseHoteBy'];
    degreeTrainName = json['degreeTrainName'];
    statusTrainingName = json['statusTrainingName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseName'] = this.courseName;
    data['trainingTypeName'] = this.trainingTypeName;
    data['trainCourseDateStart'] = this.trainCourseDateStart;
    data['trainCourseDateEnd'] = this.trainCourseDateEnd;
    data['trainBranchName'] = this.trainBranchName;
    data['trainCourseLocation'] = this.trainCourseLocation;
    data['trainCourseHoteBy'] = this.trainCourseHoteBy;
    data['degreeTrainName'] = this.degreeTrainName;
    data['statusTrainingName'] = this.statusTrainingName;
    return data;
  }
}

class Certificate {
  String praiseTypeName;
  String hisPraiseTitle;
  String hisPraiseDetail;
  String praiseLevelName;
  String hisPraiseRemark;
  String hisPraiseDate;
  Certificate(
      {this.praiseTypeName,
      this.hisPraiseTitle,
      this.hisPraiseDetail,
      this.praiseLevelName,
      this.hisPraiseRemark,
      this.hisPraiseDate});
  Certificate.fromJson(Map<String, dynamic> json) {
    praiseTypeName = json['praiseTypeName'];
    hisPraiseTitle = json['hisPraiseTitle'];
    hisPraiseDetail = json['hisPraiseDetail'];
    praiseLevelName = json['praiseLevelName'];
    hisPraiseRemark = json['hisPraiseRemark'];
    hisPraiseDate = json['hisPraiseDate'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['praiseTypeName'] = this.praiseTypeName;
    data['hisPraiseTitle'] = this.hisPraiseTitle;
    data['hisPraiseDetail'] = this.hisPraiseDetail;
    data['praiseLevelName'] = this.praiseLevelName;
    data['hisPraiseRemark'] = this.hisPraiseRemark;
    data['hisPraiseDate'] = this.hisPraiseDate;
    return data;
  }
}
