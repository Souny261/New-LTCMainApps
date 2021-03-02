import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:intl/intl.dart';
import 'package:ltcmainapp/Authentication/Controller/Auth_Services.dart';
import 'package:ltcmainapp/Leave/Models/leaveModels.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LeaveService extends Services {
  DioCacheManager _dioCacheManager;
  final String UrlAPI = 'https://mainapi.laotel.com/';
  static String urlApi = "https://mainapi.laotel.com/";
  Dio dio = Dio();
  String empID, apiToken;
  Future<List<LeaveDataModels>> getleaveDataHistory(
      String years, bool statusLoad) async {
    String year;
    if (years.isEmpty) {
      DateTime _dateTime = DateTime.now();
      year = DateFormat("yyyy").format(_dateTime);
    } else {
      ///'DateTime _dateTime = DateTime.now();
      year = years;
    }
    //if(statusLoad)
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      empID = pref.getString("empID");
      apiToken = pref.getString("apiToken");
      this.getNewToken(apiToken);
      String NewApiToken = pref.getString("apiToken");
      try {
        dio.options.contentType =
            ContentType.parse("application/x-www-form-urlencoded").toString();
        dio.options.headers.addAll({"authorization": "Bearer " + NewApiToken});
        var reload = true;
        if (statusLoad == false) {
          reload = false;
        }
        _dioCacheManager = DioCacheManager(CacheConfig());
        Options _cacheOptions =
            buildCacheOptions(Duration(hours: 1), forceRefresh: reload);
        dio.interceptors.add(_dioCacheManager.interceptor);

        var response = await dio.post<Map>(
          urlApi + "LeaveGetDataEmployee",
          // options: _cacheOptions,
          data: {
            "empID": empID,
            "viewYear": year,
          },
        );
        if (response.statusCode == 200) {
          var data = response.data['requestLeave'];

          ///print(empID);
          return data
              .map<LeaveDataModels>((json) => LeaveDataModels.fromJson(json))
              .toList();
        } else {
          throw Exception('Request Error: ${response.statusCode}');
        }
      } on Exception {
        rethrow;
      }
    } catch (e) {
      var errorsData = [
        {
          "startDateTime": "2020-09-11 08:00:00",
          "endDateTime": "2020-09-11 17:00:00",
          "typeName": "ພັກປະຈຳປີ",
          'leaveType': "L",
          "detail": "ບໍ່ມີການລາພັກ",
          "statusType": "A",
        }
      ];
      return errorsData
          .map<LeaveDataModels>((json) => LeaveDataModels.fromJson(json))
          .toList();
    }
  }

  Future<ModelLeaveDetail> LeaveDetail(
      String requestID, String typeLeave, bool statusLoad) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    apiToken = pref.getString("apiToken");
    this.getNewToken(apiToken);
    String NewApiToken = pref.getString("apiToken");
    try {
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      dio.options.headers.addAll({"authorization": "Bearer " + NewApiToken});
      var reload = true;
      if (statusLoad == false) {
        reload = false;
      }

      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions =
          buildCacheOptions(Duration(days: 1), forceRefresh: reload);
      dio.interceptors.add(_dioCacheManager.interceptor);

      var response = await dio.post<Map>(UrlAPI + "leaveDetail",
          data: {
            "requestID": requestID,
            "typeLeave": typeLeave,
          },
          options: _cacheOptions);
      if (response.statusCode == 200) {
        var data = json.encode(response.data);
        var result = json.decode(data)['data'];
        return ModelLeaveDetail.fromJson(result);
      } else {
        throw Exception('Request Error: ${response.statusCode}');
      }
    } on Exception {
      rethrow;
    }
  }
  //----------------------------------------------------------
  Future<GetImageEmp> getImageEmp(String empID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    apiToken = pref.getString("apiToken");
    try {
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(Duration(days: 1));
      dio.interceptors.add(_dioCacheManager.interceptor);
      dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      var response = await dio.post<Map>(
        UrlAPI + "loadFileData",
        options: _cacheOptions,
        data: {"fileID": empID, "type": "e"},
      );
      if (response.statusCode == 200) {
        return GetImageEmp.fromJson(response.data);
      } else {
        print("object");
      }
    } catch (e) {
      print(e.toString());
    }
  }
  Future<ModelImage> getEmployeeImage(String empID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    apiToken = pref.getString("apiToken");
    this.getNewToken(apiToken);
    String NewApiToken = pref.getString("apiToken");
    var img = pref.get("imageUser" + empID);
    if (img == null) {
      try {
        dio.options.contentType =
            ContentType.parse("application/x-www-form-urlencoded").toString();
        dio.options.headers.addAll({"authorization": "Bearer " + NewApiToken});
        var response = await dio.post<Map>(
          urlApi + "getImageEmployee",
          data: {
            "empID": empID,
          },
        );
        if (response.statusCode == 200) {
          String imageString = json.encode(response.data);
          pref.setString("imageUser" + empID, imageString);
          var data = response.data;
          ModelImage image = ModelImage.fromJson(data);
          return image;
        } else {
          throw Exception('Request Error: ${response.statusCode}');
        }
      } on Exception {
        rethrow;
      }
    } else {
      var data = json.decode(pref.get("imageUser" + empID));
      print("Catch");
      ModelImage image = ModelImage.fromJson(data);
      return image;
    }
  }

  showImage(String response, double h, double w) {
    //String Token
    Uint8List _bytesImage;
    _bytesImage = Base64Decoder().convert(response);
    return _bytesImage ?? false;
  }

  Future<List<ResultLeaveWaiting>> leaveWaitApproved(
      String empID, bool reload) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var empID1 = pref.getString("empID");
    apiToken = pref.getString("apiToken");
    this.getNewToken(apiToken);
    String NewApiToken = pref.getString("apiToken");

    try {
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      dio.options.headers.addAll({"authorization": "Bearer " + NewApiToken});
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions =
          buildCacheOptions(Duration(seconds: 100), forceRefresh: reload);
      dio.interceptors.add(_dioCacheManager.interceptor);
      _dioCacheManager.deleteByPrimaryKey(urlApi, requestMethod: "POST");
      var response = await dio.post<Map>(
        urlApi + "leaveWaitApproved",
        options: _cacheOptions,
        data: {
          "empID": empID1,
        },
      );
      if (response.statusCode == 200) {
        var data = response.data['resultLeaveWaiting'];
        return data
            .map<ResultLeaveWaiting>(
                (json) => ResultLeaveWaiting.fromJson(json))
            .toList();
      } else {}
    } catch (e) {
      var data = [
        {
          "requestID": 176960,
          "startDate": "2020-12-21 08:00:00",
          "endDate": "2020-12-21 17:00:00",
          "resTime": "08:00-17:00 21/12/2020",
          "leaveTypeID": 4,
          "leaveTypeName": "Null",
          "detail": "Null",
          "TypeLeave": "L",
          "empID": 1960,
          "grantEmpID": 107,
          "nextApprove": false,
          "grantID": 11946
        }
      ];
      return data
          .map<ResultLeaveWaiting>((json) => ResultLeaveWaiting.fromJson(json))
          .toList();
    }
  }

  Future<List<ModelEmployeeApproved>> getEmployeeApproved(
      String empID, String reqestEmpID, String flowNo) async {
    print("$empID $reqestEmpID $flowNo");
    SharedPreferences pref = await SharedPreferences.getInstance();
    apiToken = pref.getString("apiToken");
    this.getNewToken(apiToken);
    String NewApiToken = pref.getString("apiToken");
    try {
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      dio.options.headers.addAll({"authorization": "Bearer " + NewApiToken});

      ///_dioCacheManager = DioCacheManager(CacheConfig());
      ///Options _cacheOptions =
      ///buildCacheOptions(Duration(seconds: 10),forceRefresh: reload == null ? false : reload);
      ///dio.interceptors.add(_dioCacheManager.interceptor);
      ///_dioCacheManager.deleteByPrimaryKey(urlApi,requestMethod: "POST");
      var response = await dio.post<Map>(
        urlApi + "getEmployeeApproved",
        data: {
          "empID": empID

          ///(flowNo == null ? 2 : flowNo)
        },
      );
      if (response.statusCode == 200) {
        ///var data = ModelEmployeeApproved.fromJson(response.data);
        var data = response.data['data'];
        return data
            .map<ModelEmployeeApproved>(
                (json) => ModelEmployeeApproved.fromJson(json))
            .toList();
      } else {
        throw Exception('Request Error: ${response.statusCode}');
      }
    } on Exception {
      rethrow;
    }
  }

  Future approveLeave(
      String granID,
      String typeLeave,
      String requestID,
      String nextGranEmpID,
      String granEmpID,
      String typeQuery,
      String reson,
      String gntStatus) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    apiToken = pref.getString("apiToken");
    this.getNewToken(apiToken);
    String NewApiToken = pref.getString("apiToken");
    // print(granID);
    // print(typeLeave);
    // print(requestID);
    // print(nextGranEmpID);
    // print(granEmpID);
    // print(typeQuery);
    // print(reson);
    // print(gntStatus);
    // print(apiToken);
    try {
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      dio.options.headers.addAll({"authorization": "Bearer " + NewApiToken});
      var response = await dio.post<Map>(
        urlApi + "ProcessApproveLeave",
        data: {
          "grantID": granID,
          "leaveType": typeLeave,
          "requestID": requestID,
          "nextGranEmpID": nextGranEmpID,
          "granEmpID": granEmpID,
          "typeQuery": typeQuery,
          "reason": reson,
          "gntStatus": gntStatus
        },
      );
      if (response.statusCode == 200) {
        var data = response.data;
        print(data);
      } else {
        throw Exception('Request Error: ${response.statusCode}');
      }
    } on Exception {
      rethrow;
    }
  }

  Future<List<GetApprovePerson>> getNextApproveLeave(String empID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    apiToken = pref.getString("apiToken");
    this.getNewToken(apiToken);
    String NewApiToken = pref.getString("apiToken");
    try {
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      dio.options.headers.addAll({"authorization": "Bearer " + NewApiToken});
      var response = await dio.post<Map>(
        urlApi + "getEmployeeApproved",
        data: {"empID": empID},
      );
      if (response.statusCode == 200) {
        var data = response.data['data'];
        return data
            .map<GetApprovePerson>((json) => GetApprovePerson.fromJson(json))
            .toList();
      } else {
        throw Exception('Request Error: ${response.statusCode}');
      }
    } on Exception {
      rethrow;
    }
  }

  Future requstLeave(String typeLeave, String leaveId, String leaveDetail,
      String startDateTime, String endDateTime, String gatEmpID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String empID = prefs.getString("empID");
    String apiToken = prefs.getString("apiToken");
    print("date: $startDateTime $endDateTime");
    // return "Y";
    try {
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      var response = await dio.post<Map>(
        "https://mainapi.laotel.com/leaveRequest",
        data: {
          "typeLeave": typeLeave,
          "leaveTypeID": leaveId,
          "empID": empID,
          "granEmpID": gatEmpID,
          "startDateTime": startDateTime,
          "endDateTime": endDateTime,
          "leaveDetail": leaveDetail
        },
      );
      if (response.statusCode == 200) {
        var data = response.data['data'];
        print("Data: " + data);
        return data;
      } else {
        //print(response.statusCode);
        //print(response.data);
      }
    } catch (e) {
      return "N";
    }
  }
/*Future<List<LeaveDataModels>> getleaveWaitApprove(String years) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    apiToken = pref.getString("apiToken");
    try {
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(
        Duration(seconds: 60),
      );
      dio.interceptors.add(_dioCacheManager.interceptor);
      var response = await dio.post<Map>(
        "https://mainapi.laotel.com/LeaveGetDataEmployee",
        options: _cacheOptions,
        data: {
          "empID": empID,
          "viewYear": years,
        },
      );
      if (response.statusCode == 200) {
        var data = response.data['requestLeave'];
        //print(data);
        return data
            .map<LeaveDataModels>((json) => LeaveDataModels.fromJson(json))
            .toList();
      } else {
        throw Exception('Request Error: ${response.statusCode}');
      }
    } on Exception {
      rethrow;
    }
  }*/

  Future<FormGetLeave> getLeaveForm() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    apiToken = pref.getString("apiToken");
    try {
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(
        Duration(seconds: 60),
      );
      dio.interceptors.add(_dioCacheManager.interceptor);
      var response = await dio.post<Map>(
        "https://mainapi.laotel.com/getLeaveForm",
        options: _cacheOptions,
        data: {
          "empID": empID,
        },
      );
      if (response.statusCode == 200) {
        var data = FormGetLeave.fromJson(response.data);
        print(data);
        return data;
      } else {
        print("StatusCode Error: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

/// Get EmployeeApproved Model//
class ModelEmployeeApproved {
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

  ModelEmployeeApproved(
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

  ModelEmployeeApproved.fromJson(Map<String, dynamic> json) {
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

/// Get EmployeeApproved Model//

/// Result Leave Waiting ///

class ModelResultLeaveWaiting {
  List<ResultLeaveWaiting> resultLeaveWaiting;

  ModelResultLeaveWaiting({this.resultLeaveWaiting});

  ModelResultLeaveWaiting.fromJson(Map<String, dynamic> json) {
    if (json['resultLeaveWaiting'] != null) {
      resultLeaveWaiting = new List<ResultLeaveWaiting>();
      json['resultLeaveWaiting'].forEach((v) {
        resultLeaveWaiting.add(new ResultLeaveWaiting.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resultLeaveWaiting != null) {
      data['resultLeaveWaiting'] =
          this.resultLeaveWaiting.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultLeaveWaiting {
  int requestID;
  String startDate;
  String endDate;
  String resTime;
  int leaveTypeID;
  String leaveTypeName;
  String detail;
  String typeLeave;
  int empID;
  int grantEmpID;
  bool nextApprove;
  int granID;

  ResultLeaveWaiting(
      {this.requestID,
      this.startDate,
      this.endDate,
      this.resTime,
      this.leaveTypeID,
      this.leaveTypeName,
      this.detail,
      this.typeLeave,
      this.empID,
      this.grantEmpID,
      this.nextApprove,
      this.granID});

  ResultLeaveWaiting.fromJson(Map<String, dynamic> json) {
    requestID = json['requestID'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    resTime = json['resTime'];
    leaveTypeID = json['leaveTypeID'];
    leaveTypeName = json['leaveTypeName'];
    detail = json['detail'];
    typeLeave = json['TypeLeave'];
    empID = json['empID'];
    grantEmpID = json['grantEmpID'];
    nextApprove = json['nextApprove'];
    granID = json['grantID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestID'] = this.requestID;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['resTime'] = this.resTime;
    data['leaveTypeID'] = this.leaveTypeID;
    data['leaveTypeName'] = this.leaveTypeName;
    data['detail'] = this.detail;
    data['TypeLeave'] = this.typeLeave;
    data['empID'] = this.empID;
    data['grantEmpID'] = this.grantEmpID;
    data['nextApprove'] = this.nextApprove;
    data['grantID'] = this.granID;
    return data;
  }
}

/// Model Load File To Url ///
///
class GetImageEmp {
  String url;
  String fileName;
  String fileSize;
  String fileType;

  GetImageEmp({this.url, this.fileName, this.fileSize, this.fileType});

  GetImageEmp.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    fileName = json['fileName'];
    fileSize = json['fileSize'];
    fileType = json['fileType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['fileName'] = this.fileName;
    data['fileSize'] = this.fileSize;
    data['fileType'] = this.fileType;
    return data;
  }
}
