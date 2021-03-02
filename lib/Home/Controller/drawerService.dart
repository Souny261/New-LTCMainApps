import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:ltcmainapp/Home/Models/drawerModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerService {
  String empID;
  String urlApi = "https://mainapi.laotel.com/index.php/";
  DioCacheManager _dioCacheManager;
  Dio _dio = Dio();

  Future getUserData1() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    String url = urlApi + 'index.php/getFullDetailEmployee';
    final response = await http.post(url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"empID": empID, "text": ""});
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("errros");
    }
  }

  Future<UserDetail> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    if (empID.isNotEmpty) {
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(Duration(hours: 2));
      _dio.interceptors.add(_dioCacheManager.interceptor);
      _dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      // _dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      Response response = await _dio.post(
        urlApi + 'getFullDetailEmployee',
        options: _cacheOptions,
        data: {
          "empID": empID,
        },
      );
      if (response.statusCode == 201) {
        var res = response.data["Profile"]["data"];
        return UserDetail.fromJson(res);
      } else {
        print("Api is Error");
      }
    } else {
      print("Data is Error");
    }
  }

  Future resetID(String empIDNo) async {
    try {
      final response = await http.get(
        'https://mainapi.laotel.com/index.php/deletetoken/' + empIDNo,
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['message'];
        return data;
      } else if (response.statusCode == 500) {
        return 'N';
      }
    } catch (e) {
      return 'N';
    }
  }

  Future<SpecailGroup> CallDataSpecailGroupOrg() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      empID = pref.getString("empID");
      if (empID.isNotEmpty) {
        _dioCacheManager = DioCacheManager(CacheConfig());
        Options _cacheOptions = buildCacheOptions(Duration(hours: 2));
        _dio.interceptors.add(_dioCacheManager.interceptor);
        _dio.options.contentType =
            ContentType.parse("application/x-www-form-urlencoded").toString();
        // _dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
        Response response = await _dio.post(
          urlApi + 'getFullDetailEmployee',
          options: _cacheOptions,
          data: {
            "empID": empID,
          },
        );
        if (response.statusCode == 201) {
          var res = response.data["SpecialGroup"]["data"]["org"];
          print(res);
          return SpecailGroup.fromJson(res);
        } else {
          print("Api is Error");
        }
      } else {
        print("Data is Error");
      }
    } catch (e) {
      var error = {
        "dateOrg": "0",
      };
      return SpecailGroup.fromJson(error);
    }
  }

  Future<List<UserEducation1>> getUserEducation() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    if (empID.isNotEmpty) {
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(Duration(hours: 2));
      _dio.interceptors.add(_dioCacheManager.interceptor);
      _dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      // _dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      Response response = await _dio.post(
        urlApi + 'getFullDetailEmployee',
        options: _cacheOptions,
        data: {
          "empID": empID,
        },
      );
      if (response.statusCode == 201) {
        var res = response.data["Education"]["data"];
        //print(res);
        return res
            .map<UserEducation1>((json) => UserEducation1.fromJson(json))
            .toList();
      } else {
        print("Api is Error");
      }
    } else {
      print("Data is Error");
    }
  }

  Future<List<Family>> getUserFamily() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    if (empID.isNotEmpty) {
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(Duration(hours: 2));
      _dio.interceptors.add(_dioCacheManager.interceptor);
      _dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      // _dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      Response response = await _dio.post(
        urlApi + 'getFullDetailEmployee',
        options: _cacheOptions,
        data: {
          "empID": empID,
        },
      );
      if (response.statusCode == 201) {
        var res = response.data["Family"]["Family"];
        print(res);
        return res.map<Family>((json) => Family.fromJson(json)).toList();
      } else {
        print("Api is Error");
      }
    } else {
      print("Data is Error");
    }
  }

  Future<List<SpecailGroup>> getUserGroup() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    if (empID.isNotEmpty) {
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(Duration(hours: 2));
      _dio.interceptors.add(_dioCacheManager.interceptor);
      _dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      // _dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      Response response = await _dio.post(
        urlApi + 'getFullDetailEmployee',
        options: _cacheOptions,
        data: {
          "empID": "2106",
        },
      );
      if (response.statusCode == 201) {
        var res = response.data["SpecialGroup"]["data"];
        return res
            .map<SpecailGroup>((json) => SpecailGroup.fromJson(json))
            .toList();
      } else {
        print("Api is Error");
      }
    } else {
      print("Data is Error");
    }
  }

  Future<List<ChildModel>> getUserChild() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    if (empID.isNotEmpty) {
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(Duration(hours: 2));
      _dio.interceptors.add(_dioCacheManager.interceptor);
      _dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      // _dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      Response response = await _dio.post(
        urlApi + 'getFullDetailEmployee',
        options: _cacheOptions,
        data: {
          "empID": empID,
        },
      );
      if (response.statusCode == 201) {
        var res = response.data["Family"]["child"];
        //print(res);
        return res
            .map<ChildModel>((json) => ChildModel.fromJson(json))
            .toList();
      } else {
        print("Api is Error");
      }
    } else {
      print("Data is Error");
    }
  }

  Future<List<Working>> getUserWorking() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    if (empID.isNotEmpty) {
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(Duration(hours: 2));
      _dio.interceptors.add(_dioCacheManager.interceptor);
      _dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      // _dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      Response response = await _dio.post(
        urlApi + 'getFullDetailEmployee',
        options: _cacheOptions,
        data: {
          "empID": empID,
        },
      );
      if (response.statusCode == 201) {
        var res = response.data["HistoryWork"]["data"];
        print(res);
        return res.map<Working>((json) => Working.fromJson(json)).toList();
      } else {
        print("Api is Error");
      }
    } else {
      print("Data is Error");
    }
  }

  Future<List<Training>> getUserTrianing() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    if (empID.isNotEmpty) {
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(Duration(hours: 2));
      _dio.interceptors.add(_dioCacheManager.interceptor);
      _dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      // _dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      Response response = await _dio.post(
        urlApi + 'getFullDetailEmployee',
        options: _cacheOptions,
        data: {
          "empID": empID,
        },
      );
      if (response.statusCode == 201) {
        var res = response.data["HisTrain"];
        print(res);
        return res.map<Training>((json) => Training.fromJson(json)).toList();
      } else {
        print("Api is Error");
      }
    } else {
      print("Data is Error");
    }
  }

  Future<List<Certificate>> getUserCerti() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    empID = pref.getString("empID");
    if (empID.isNotEmpty) {
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(Duration(hours: 2));
      _dio.interceptors.add(_dioCacheManager.interceptor);
      _dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      // _dio.options.headers.addAll({"authorization": "Bearer " + apiToken});
      Response response = await _dio.post(
        urlApi + 'getFullDetailEmployee',
        options: _cacheOptions,
        data: {
          "empID": empID,
        },
      );
      if (response.statusCode == 201) {
        var res = response.data["HisPraise"];
        print(res);
        return res
            .map<Certificate>((json) => Certificate.fromJson(json))
            .toList();
      } else {
        print("Api is Error");
      }
    } else {
      print("Data is Error");
    }
  }
}
