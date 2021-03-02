import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ltcmainapp/Events/Models/eventModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventServices {
  String empID, apiToken;
  Dio dio = Dio();
  final String UrlAPI = 'https://mainapi.laotel.com/';
  Future<AllCheckIn> QRCodeAllCheckIn(String activeCode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    apiToken = pref.getString("apiToken");
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded").toString();
    dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
    var response = await dio.post<Map>(
      UrlAPI + "LTCLibrary_AllCheckIn",
      data: {"activeCode": activeCode, "empID": empID},
    );
    if (response.statusCode == 200) {
      var res = json.decode(json.encode(response.data));
      final parsed = AllCheckIn.fromJson(res);
      //print(res);
      return parsed;
    } else {
      throw Exception('Request Error: ${response.statusCode}');
    }
  }

  Future<List<DataInvite>> loadInviteEvent() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    apiToken = pref.getString("apiToken");
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded").toString();
    dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
    var response = await dio.post<Map>(
      UrlAPI + "getEventEmployee",
      data: {"empID": empID},
    );
    if (response.statusCode == 200) {
      var data = response.data['data'];
      return data.map<DataInvite>((json) => DataInvite.fromJson(json)).toList();
    } else {
      throw Exception('Request Error: ${response.statusCode}');
    }
  }

  approvedInvite(String aiID, String aprStatus) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    apiToken = pref.getString("apiToken");
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded").toString();
    dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
    var response = await dio.post<Map>(
      UrlAPI + "LTCLibrary_approveInvite",
      data: {"aiID": aiID, "apprStatus": aprStatus},
    );
    if (response.statusCode == 200) {
      //var data = json.decode(json.encode(response.data))["response"];
      //print(data);
      return response;
    } else {
      throw Exception('Request Error: ${response.statusCode}');
    }
  }

  InviteOpened(String atID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    apiToken = pref.getString("apiToken");
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded").toString();
    dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
    var response = await dio.post<Map>(
      UrlAPI + "LTCLibrary_InviteOpened",
      data: {"empID": empID, "atID": atID},
    );
    if (response.statusCode == 200) {
      //print(empID);
      return json.decode(json.encode(response.data));
    } else {
      throw Exception('Request Error: ${response.statusCode}');
    }
  }

  Future<List<DataEventActive>> eventActiveList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    apiToken = pref.getString("apiToken");
    if (apiToken.isNotEmpty && empID.isNotEmpty) {
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      var response = await dio.post<Map>(
        UrlAPI + "activeAllEvent",
        data: {"empID": empID},
      );
      if (response.statusCode == 200) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        var data = json.decode(response.data['activeEvent']);
        return data
            .map<DataEventActive>((json) => DataEventActive.fromJson(json))
            .toList();
      } else {
        throw Exception('Request Error: ${response.statusCode}');
      }
    } else {
      print("API ERRors");
    }
  }
}
