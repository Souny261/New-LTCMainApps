import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:ltcmainapp/LtcEvent/Controller/EventModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServiceProvider {
  String empID;
  String apiToken;
  Dio _dio = Dio();
  DioCacheManager _dioCacheManager;

  String mainUrl = "https://mainapi.laotel.com/";
  Future<String> loadPDF(String doc) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String newPath = doc.substring(doc.lastIndexOf('/')).substring(1);
    var data = pref.getString(newPath);
    if (data == null) {
      print("Save Img");
      var response = await http.get(doc);
      var dir = await getApplicationDocumentsDirectory();
      File file = new File("${dir.path}/$newPath-data.pdf");
      file.writeAsBytesSync(response.bodyBytes, flush: true);
      pref.setString(newPath, file.path);
      return file.path;
    } else {
      print("get");
      return data;
    }
  }

  Future<List<EventModel>> getEvent() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    apiToken = pref.getString("apiToken");
    try {
      _dioCacheManager = DioCacheManager(CacheConfig());
      //Options _cacheOptions = buildCacheOptions(Duration(days: 30));
      _dio.interceptors.add(_dioCacheManager.interceptor);
      _dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      _dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      var response = await _dio.post<Map>(mainUrl + "EventLists",
          //options: _cacheOptions,
          data: {"empID": empID});
      if (response.statusCode == 200) {
        var data = response.data['result'];
        return data
            .map<EventModel>((json) => EventModel.fromJson(json))
            .toList();
      } else {
        print("object");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<AddCommentModel> inserComment(String comment, String choiceID,
      String fmID, String formInviteID, List attrFile) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    apiToken = pref.getString("apiToken");
    try {
      _dioCacheManager = DioCacheManager(CacheConfig());
      _dio.interceptors.add(_dioCacheManager.interceptor);
      _dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      _dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      var data = {
        "comment": comment,
        "choiceID": choiceID,
        "fmID": fmID,
        "formInviteID": formInviteID,
        "attrFile": attrFile
      };
      //print(data);
      var response = await _dio.post<Map>(
        mainUrl + "EventAddComments",
        data: data,
      );
      //print(data);
      if (response.statusCode == 200) {
        var data = response.data['result'];
        print(data);
        return AddCommentModel.fromJson(data);
      } else {
        print("object");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
