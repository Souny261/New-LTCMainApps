import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

DioCacheManager _dioCacheManager;

class Services {
  static String urlApi = "https://mainapi.laotel.com/";
  final dio = Dio();
// function get password
  getPassword(String empIDNo, String appId) async {
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded").toString();
    var response = await dio.post<Map>(
      urlApi + "index.php/LoginGetPassword",
      data: {"empIDNo": empIDNo, "appID": appId},
    );
    print(response);
    return response;
  }

  checkLogin(String empIDNo, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded").toString();
    var response = await dio.post<Map>(
      urlApi + "index.php/LoginUser",
      data: {
        "empIDNo": empIDNo, // widget.empIDNo,
        "password": password, //empPass.text,
      },
    );
    String status = response.data['status'].toString();
    String empIDLogin = response.data['empID'].toString();

    if (status == "true") {
      String token = response.data['userToken'].toString();
      String apiToken = response.data['apiToken'].toString();
      pref.setString("apiToken", apiToken);
      pref.setString("Token", token);
      print(pref.getString("apiToken"));
      print(empIDLogin);

      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      var responseFullname = await dio.post<Map>(
        urlApi + "getFullDetailEmployee",
        data: {"empID": empIDLogin, "viewType": "e"},
      );
      String name = responseFullname.data['fullName'];
      String empIDNo = responseFullname.data['employeeIDNo'];
      String depID = responseFullname.data['depID'].toString();
      pref.setString("fullname", name);
      pref.setString("empID", empIDLogin);
      pref.setString("empIDNo", empIDNo);
      pref.setString("depID", depID);
    }
    return response;
  }

  getNewToken(String apiToken) async {
    try {
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(Duration(minutes: 50));
      dio.interceptors.add(_dioCacheManager.interceptor);
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      var response = await dio.post<Map>(
        urlApi + "getNewToken",
        options: _cacheOptions,
        data: {
          "apiToken": apiToken,
        },
      );
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          SharedPref sharedPref = new SharedPref();
          var newToken = response.data['response'];

          ////print(newToken);
          sharedPref.save("apiToken", newToken);
        } else {
          return null;
        }
      } else {
        throw Exception('Request Error: ${response.statusCode}');
      }
    } on Exception {
      rethrow;
    }
  }
}

class SharedPref {
  read(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ///final prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(key);
    //print(data);
    return data.toString(); //prefs.getString(key);
  }

  save(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ///inal prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ///final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ///final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
