import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltcmainapp/Controller/sharedata.dart';
import 'package:ltcmainapp/Home/Controller/homeService.dart';

class historyFinger extends StatefulWidget {
  ScrollController loading;
  String empID;
  historyFinger({this.loading, this.empID});
  @override
  _HistFingerState createState() => _HistFingerState();
}

class _HistFingerState extends State<historyFinger>
    with SingleTickerProviderStateMixin {
  final ShareData share = new ShareData();
  final HomeService service = new HomeService();
  DioCacheManager _dioCacheManager;
  String apiUrl =
      "https://mainapi.laotel.com/index.php/getEmployeeFingerprintHistory";
  //ScrollController _scrollLoadmore = new ScrollController();
  bool isLoading = false;
  List finger = new List();
  final dio = new Dio();
  var nextPage;
  var moreData = 0;
  var refresh = true;
  var error = "1";
  Future<Null> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    if (_dioCacheManager != null) {
      bool res = await _dioCacheManager.deleteByPrimaryKey(
          'https://mainapi.laotel.com/index.php/getEmployeeFingerprintHistory');
      print(res);
    }
  }

  void _getMoreData() async {
    try {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
        _dioCacheManager = DioCacheManager(CacheConfig());
        Options _cacheOptions = buildCacheOptions(Duration(minutes: 2));
        dio.interceptors.add(_dioCacheManager.interceptor);
        dio.options.contentType =
            ContentType.parse("application/x-www-form-urlencoded").toString();
        final response = await dio.post(
          apiUrl,
          data: {"empID": widget.empID, "startIndex": moreData},
          options: _cacheOptions,
        );
        List tempList = new List();
        var rowShoe = response.data['rowShow'];
        moreData = moreData + rowShoe;
        for (int i = 0; i < response.data['data'].length; i++) {
          tempList.add(response.data['data'][i]);
        }
        setState(() {
          isLoading = false;
          finger.addAll(tempList);
        });
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        error = "2";
        isLoading = false;
      });
    }
  }

  //Future<List> ResultdataHistory;
  @override
  void initState() {
    this._getMoreData();
    widget.loading.addListener(() {
      if (widget.loading.position.pixels ==
          widget.loading.position.maxScrollExtent) {
        this._getMoreData();
      }
    });
    
    super.initState();
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
            opacity: isLoading ? 1.0 : 00,
            child: Image.asset(
              "assets/r.gif",
              height: 50.0,
              width: 50.0,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: RefreshIndicator(
        child: FingerHistory(),
        onRefresh: _handleRefresh,
      ),
    );
  }

  Widget FingerHistory() {
    return ListView.builder(
      itemCount: finger.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (error == "2") {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.cancel,
                size: 100,
                color: Colors.red[800],
              ),
              Text(
                "ບໍ່ພົບຂໍ້ມູນ",
                style: TextStyle(
                    fontFamily: 'NotoSansLaoUI-Regular',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )
            ],
          );
        }
        if (index == finger.length) {
          return _buildProgressIndicator();
        } else {
          return Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Icon(
                      Icons.fingerprint,
                      color: Colors.red[800],
                      size: 60,
                    ),
                    title: Text(
                      finger[index]['content'],
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'NotoSansLaoUI-Regular',
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.date_range,
                          size: 15,
                          color: Colors.red[800],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat("dd-MM-yyyy").format(DateTime.parse(
                            finger[index]['createTime'],
                          )),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider()
              ],
            ),
          );
        }
      },
    );
  }
}
