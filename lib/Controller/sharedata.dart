import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ltcmainapp/Models/mainModels.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShareData {
  DioCacheManager _dioCacheManager;
  Dio _dio = Dio();
  final dio = Dio();
  static String urlApi = "https://mainapi.laotel.com/";
  final String UrlAPI = 'https://mainapi.laotel.com/';
  _showDialog(title, text) {
    showDialog(
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: <Widget>[
              Icon(
                Icons.signal_wifi_off,
                color: Colors.red,
                size: 50,
              ),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSansLaoUI-Regular',
                ),
              ),
            ],
          ),
          content: Text(text),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'ປິດ',
                style: TextStyle(
                  fontFamily: 'NotoSansLaoUI-Regular',
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  showImage(String response, double h, double w) {
    //String Token
    Uint8List _bytesImage;
    _bytesImage = Base64Decoder().convert(response);
    return _bytesImage ?? false;
  }

  checkingInternet() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog('ຂາດການເຊື່ອມຕໍ່!', "ກະລຸນາກວດສອບສັນຍານ Internet ຂອງທ່ານ");
    }
  }

  startvibrate() async {
    await SystemChannels.platform.invokeMethod<void>('HapticFeedback.vibrate');
  }

  Future<NewToken> getNewToken(String apiToken) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      if (apiToken.isNotEmpty) {
        _dioCacheManager = DioCacheManager(CacheConfig());
        Options _cacheOptions = buildCacheOptions(Duration(hours: 2));
        _dio.interceptors.add(_dioCacheManager.interceptor);
        _dio.options.contentType =
            ContentType.parse("application/x-www-form-urlencoded").toString();
        _dio.options.headers.addAll({"authorization": "Bearer " + apiToken});

        Response response = await _dio.post(
          UrlAPI + 'getNewToken',
          options: _cacheOptions,
          data: {
            "apiToken": apiToken,
          },
        );
        if (response.statusCode == 200) {
          var res = json.decode(response.data);
          var newToken = response.data['response'];
          pref.setString("apiToken", newToken);
          final parsed = NewToken.fromJson(res);
          return parsed;
        } else {
          throw Exception('Request Error: ${response.statusCode}');
        }
      } else {
        print("Error");
      }
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  Future<NewToken> saveApiToken(String apiToken) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (apiToken.isNotEmpty) {
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(Duration(minutes: 50));
      _dio.interceptors.add(_dioCacheManager.interceptor);
      _dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      Response response = await _dio.post(
        UrlAPI + 'getNewToken',
        options: _cacheOptions,
        data: {
          "apiToken": apiToken,
        },
      );
      if (response.statusCode == 200) {
        var newToken = response.data['response'];
        pref.setString("apiToken", newToken);
        var res = response.data;
        // print(res);
        final parsed = NewToken.fromJson(res);
        return parsed;
      } else {
        print("Api is Error");
      }
    } else {
      print("Data is Error");
    }
  }

  Future<LocationModel> getLocation() async {
    Position positions = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var Lat = positions.latitude.toString();
    var Long = positions.longitude.toString();
    var data = LocationModel(lat: Lat, long: Long);
    return data;
  }
}
