import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:ltcmainapp/Contact/Model/contactModels.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactServices {
  final String UrlAPI = 'https://mainapi.laotel.com/';
  Dio dio = new Dio();
  String empID, apiToken;
  DioCacheManager _dioCacheManager;
  Future<List<EmpData>> contactEmployees(String search) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    apiToken = pref.getString("apiToken");
    try {
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(Duration(days: 30));
      dio.interceptors.add(_dioCacheManager.interceptor);
      dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      var response = await dio.post<Map>(
        UrlAPI + "contractEmployee",
        options: _cacheOptions,
        data: {"search": search},
      );
      if (response.statusCode == 200) {
        var data = response.data['data'];
        //print(response.data['data']);
        return data.map<EmpData>((json) => EmpData.fromJson(json)).toList();
      } else {
        print("object");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
