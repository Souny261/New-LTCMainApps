import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:ltcmainapp/Notification/Models/notiModels.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceNoti {
  String urlApi = "https://mainapi.laotel.com/";
  DioCacheManager _dioCacheManager;
  Dio _dio = Dio();
  Future<List<NotiModel>> getNoti() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var empID = pref.getString("empID");
    var apiToken = pref.getString("apiToken");
    if (empID.isNotEmpty && apiToken.isNotEmpty) {
      _dioCacheManager = DioCacheManager(CacheConfig());

      _dio.interceptors.add(_dioCacheManager.interceptor);
      _dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      _dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      Response response = await _dio.post(
        urlApi + 'listNotification',
        //options: _cacheOptions,
        data: {
          "empID": empID,
        },
      );
      if (response.statusCode == 200) {
        var res = response.data["data"];
        return res.map<NotiModel>((json) => NotiModel.fromJson(json)).toList();
      } else {
        print("Api is Error");
      }
    } else {
      print("Data is Error");
    }
  }

  Future<ContentModel> getNotiContent(String nid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var apiToken = pref.getString("apiToken");
    if (apiToken.isNotEmpty && nid.isNotEmpty) {
      _dioCacheManager = DioCacheManager(CacheConfig());
      _dio.interceptors.add(_dioCacheManager.interceptor);
      _dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      _dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      Response response = await _dio.post(
        urlApi + 'viewNotification',
        //options: _cacheOptions,
        data: {"nID": nid},
      );
      if (response.statusCode == 200) {
        var res = response.data['data'];

        return ContentModel.fromJson(res);
      } else {
        print("Api is Error");
      }
    } else {
      print("Data is Error");
    }
  }
}
