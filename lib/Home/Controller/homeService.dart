import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ltcmainapp/Authentication/Controller/Auth_Services.dart';
import 'package:ltcmainapp/Controller/provider.dart';
import 'package:ltcmainapp/Controller/sharedata.dart';
import 'package:ltcmainapp/Home/Models/homeModel.dart';
import 'package:ltcmainapp/Rountes/router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class HomeService {
  static String urlApi = "https://mainapi.laotel.com/";
  DioCacheManager _dioCacheManager;
  Dio _dio = Dio();
  ShareData shareData = new ShareData();
  RouterApp _router = new RouterApp();
  String empID, apiToken;
  Future<ChVersion> getVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Services services = new Services();
    var apiToken = prefs.getString('apiToken');
    services.getNewToken(apiToken);
    try {
      final response = await http.get(
        urlApi + 'checkVersion',
      );
      var res = json.decode(response.body);
      if (response.statusCode == 200) {
        //print(response.body);
        return ChVersion.fromJson(res);
      } else {
        throw Exception('Request Error: ${response.statusCode}');
      }
    } on Exception {
      rethrow;
    }
  }

  updateUserVersion(String version, String empID) async {
    try {
      final response = await http.post(
        urlApi + 'updateUserVersion',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Accept": 'application/x-www-form-urlencoded',
        },
        body: {"version": version, "empID": empID},
      ).timeout(
        Duration(seconds: 3),
        onTimeout: () {
          // time has run out, do what you wanted to do
          return shareData.checkingInternet();
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Request Error: ${response.statusCode}');
      }
    } catch (e) {
      print("ERROR: " + e.toString());
    }
  }

  Future<CheckIn> getCheckIn(String lat, String lon, String codeQR) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // print(lat);
    // print(lon);
    empID = pref.getString("empID");
    apiToken = pref.getString("apiToken");
    // print(empID);
    // print(apiToken);
    // print(codeQR);
    try {
      if (lat != null && lon != null) {
        final response = await http.post(
          urlApi + 'FingerCheckFingerLocation',
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": 'application/x-www-form-urlencoded',
            "Authorization": "Bearer $apiToken",
          },
          body: {
            "empID": empID,
            "lat": lat,
            "lon": lon,
            "codeQR": codeQR,
          },
        );
        if (response.statusCode == 200) {
          var res = json.decode(response.body);
          return CheckIn.fromJson(res);
        } else {
          throw Exception('Request Error: ${response.statusCode}');
        }
      } else {
        print("errors");
      }
    } on Exception {
      rethrow;
    }
  }

  Future<HomeData> getHomedata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    apiToken = pref.getString("apiToken");
    if (apiToken.isNotEmpty && empID.isNotEmpty) {
      _dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      _dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      Response response = await _dio.post(
        urlApi + 'appDustBoard',
        data: {
          "empID": empID,
        },
      );
      if (response.statusCode == 200) {
        var data = response.data;
        return HomeData.fromJson(data);
      } else {
        print("Api is Error");
      }
    } else {
      print("Data is Error");
    }
  }

  Future getImageUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    apiToken = pref.getString("apiToken");
    try {
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(Duration(days: 30));
      _dio.interceptors.add(_dioCacheManager.interceptor);
      _dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      _dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      var response = await _dio.post<Map>(
        "https://mainapi.laotel.com/loadFileData",
        options: _cacheOptions,
        data: {"fileID": empID, "type": "e"},
      );
      if (response.statusCode == 200) {
        return response.data['url'];
      } else {
        print("object");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
