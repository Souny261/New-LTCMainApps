import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltcmainapp/Controller/sharedata.dart';
import 'package:ltcmainapp/FingerPrintHistory/Bloc/bloc/conversatoin_bloc.dart';
import 'package:ltcmainapp/FingerPrintHistory/Bloc/events/add_message.dart';
import 'package:ltcmainapp/FingerPrintHistory/Bloc/events/update_food.dart';
import 'package:ltcmainapp/FingerPrintHistory/DB/database_provider.dart';
import 'package:ltcmainapp/FingerPrintHistory/Models/fingerModels.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FingerService {
  String empID, apiToken;
  final String UrlAPI = 'https://mainapi.laotel.com/';
  Dio dio = Dio();
  DioCacheManager _dioCacheManager;
  ShareData _shareData = new ShareData();

  Future<List<FingerListMonth>> getFingerListMonth() async {
    _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions = buildCacheOptions(Duration(seconds: 3));
    dio.interceptors.add(_dioCacheManager.interceptor);
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded").toString();
    var response = await dio.post<Map>(
      UrlAPI + "getListMonth",
      options: _cacheOptions,
    );
    if (response.statusCode == 200) {
      var data = response.data['list'];
      // print(data);
      return data
          .map<FingerListMonth>((json) => FingerListMonth.fromJson(json))
          .toList();
    } else {
      throw Exception('Request Error: ${response.statusCode}');
    }
  }

  Future<List<FingerList>> getSearchFingerList(
      String month, String apiToken) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    // apiToken = pref.getString("apiToken");
    if (empID.isNotEmpty && apiToken.isNotEmpty) {
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options cacheOptions = buildCacheOptions(Duration(hours: 1),
          primaryKey: "new", subKey: "sumary");
      dio.interceptors.add(_dioCacheManager.interceptor);
      dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      var response = await dio.post<Map>(
        UrlAPI + "getEmployeeFingerprintResaults",
        options: cacheOptions,
        data: {"empID": empID, "viewMonth": month},
      );
      if (response.statusCode == 200) {
        var data = response.data['data'];
        //print(data);
        return data
            .map<FingerList>((json) => FingerList.fromJson(json))
            .toList();
      } else {
        print("object");
      }
    } else {
      print("empID and apiToken are called on null");
    }
  }

  Future<List<FingerList>> getSearchMomthFingerList(String month) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      empID = pref.getString("empID");
      apiToken = pref.getString("apiToken");
      print(month);
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(Duration(days: 3));
      dio.interceptors.add(_dioCacheManager.interceptor);
      dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      var response = await dio.post<Map>(
        UrlAPI + "getEmployeeFingerprintResaults",
        options: _cacheOptions,
        data: {"empID": empID, "viewMonth": month},
      );
      if (response.statusCode == 200) {
        var data = response.data['data'];
        return data
            .map<FingerList>((json) => FingerList.fromJson(json))
            .toList();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<TotalMonthFinger> getTotalFinger(String month) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    apiToken = pref.getString("apiToken");
    _dioCacheManager = DioCacheManager(CacheConfig());
    // Options _cacheOptions = buildCacheOptions(Duration(days: 30));
    dio.interceptors.add(_dioCacheManager.interceptor);
    dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded").toString();
    var response = await dio.post<Map>(
      UrlAPI + "getEmployeeFingerprintResaults",
      // options: _cacheOptions,
      data: {"empID": empID, "viewMonth": month},
    );
    if (response.statusCode == 200) {
      var data = response.data['total'];
      return TotalMonthFinger.fromJson(data);
    } else {
      print("object");
    }
  }

  Future saveDataToSqlite(
      String month, String apiToken, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    if (empID.isNotEmpty && apiToken.isNotEmpty) {
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options cacheOptions = buildCacheOptions(Duration(minutes: 30),
          primaryKey: "new", subKey: "sumary");
      dio.interceptors.add(_dioCacheManager.interceptor);
      dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      var response = await dio.post<Map>(
        UrlAPI + "getEmployeeFingerprintResaults",
        //  options: cacheOptions,
        data: {"empID": empID, "viewMonth": month},
      );
      if (response.statusCode == 200) {
        List data = response.data['data'];
        print(response.data);
        DatabaseProvider.db.getFingerBloc().then((value) {
          print("db" + value.length.toString());
          DatabaseProvider.db.delete().whenComplete(() {
            print("Insert");
            for (var i = 0; i < data.length; i++) {
              SumFingerModels models = SumFingerModels(
                  dateTime: data[i]['This'],
                  Finger: data[i]['Finger'],
                  inTime: data[i]['inTime'],
                  outTime: data[i]['outTime'],
                  leaveCut: data[i]['LeaveCut'],
                  leaveNormal: data[i]['LeaveNormal'],
                  leavePerson: data[i]['Person'],
                  OnDay: data[i]['OnDay']);
              DatabaseProvider.db.insert(models).then(
                    (storedFood) => BlocProvider.of<FingerBloc>(context).add(
                      AddFinger(storedFood),
                    ),
                  );
            }
          });
          // if (value.length == 0) {
          //   print("Insert");
          //   for (var i = 0; i < data.length; i++) {
          //     SumFingerModels models = SumFingerModels(
          //         dateTime: data[i]['This'],
          //         Finger: data[i]['Finger'],
          //         inTime: data[i]['inTime'],
          //         outTime: data[i]['outTime'],
          //         leaveCut: data[i]['LeaveCut'],
          //         leaveNormal: data[i]['LeaveNormal'],
          //         leavePerson: data[i]['Person'],
          //         OnDay: data[i]['OnDay']);
          //     DatabaseProvider.db.insert(models).then(
          //           (storedFood) => BlocProvider.of<FingerBloc>(context).add(
          //             AddFinger(storedFood),
          //           ),
          //         );
          //   }
          // } else {
          //   print("Update");
          //   for (var i = 0; i < data.length; i++) {
          //     SumFingerModels models = SumFingerModels(
          //         dateTime: data[i]['This'],
          //         Finger: data[i]['Finger'],
          //         inTime: data[i]['inTime'],
          //         outTime: data[i]['outTime'],
          //         leaveCut: data[i]['LeaveCut'],
          //         leaveNormal: data[i]['LeaveNormal'],
          //         leavePerson: data[i]['Person'],
          //         OnDay: data[i]['OnDay']);
          //     DatabaseProvider.db.update(models).then(
          //           (storedFood) => BlocProvider.of<FingerBloc>(context).add(
          //             UpdateSum(i, models),
          //           ),
          //         );
          //   }
          // }
        });

        print("api: " + data.length.toString());
      } else {
        print("object");
      }
    } else {
      print("empID and apiToken are called on null");
    }
  }

  Future sumFingerPrint(String date) async {
//https://mainapi.laotel.com/RecallProcessEmployee
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    apiToken = pref.getString("apiToken");
    if (empID.isNotEmpty && apiToken.isNotEmpty) {
      _dioCacheManager = DioCacheManager(CacheConfig());
      dio.interceptors.add(_dioCacheManager.interceptor);
      dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      var response = await dio.post<Map>(
        UrlAPI + "RecallProcessEmployee",
        data: {"empID": empID, "date": date},
      );
      if (response.statusCode == 200) {
        var data = response.data['result']['Finger'];

        return data;
      }
    }
  }
}
