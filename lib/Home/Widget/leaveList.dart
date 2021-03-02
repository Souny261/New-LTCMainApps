import 'dart:async';
import 'package:ltcmainapp/Controller/sharedata.dart';
import 'package:ltcmainapp/Home/Models/homeModel.dart';
import 'package:ltcmainapp/Home/Widget/shimmerAnimation.dart';
import 'package:ltcmainapp/Home/leaveDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:ltcmainapp/Home/Controller/homeService.dart';

HomeService homeService = new HomeService();

class LeaveListview extends StatefulWidget {
  String empID;
  String apiToken;
  List<LeaveProfileData> leaveProfileData;
  bool loading;
  LeaveListview(
      {this.empID, this.apiToken, this.leaveProfileData, this.loading});

  @override
  _LeaveListviewState createState() => _LeaveListviewState();
}

class _LeaveListviewState extends State<LeaveListview> {
  ShareData _shareData = new ShareData();
  HomeService homeService = new HomeService();
  String newApiToken = "A";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.loading == true
        ? Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.red[100],
            enabled: widget.loading,
            child: ListView.separated(
              itemCount: widget.leaveProfileData.length = 4,
              itemBuilder: (context, index) {
                return historyLeave(widget.leaveProfileData[index]);
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          )
        : widget.leaveProfileData.length == 0
            ? Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  children: [
                    
                    Image.asset(
                      "assets/menu/leave.png",
                      height: 80,
                      width: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 8),
                      child: Text(
                        "ຍັງບໍ່ໄດ້ລາພັກ",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'NotoSansLaoUI-Regular',
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: widget.leaveProfileData.length,
                itemBuilder: (context, index) {
                  return historyLeave(widget.leaveProfileData[index]);
                },
              );
  }

  Widget historyLeave(_leaveProfileData) {
    return ListTile(
      onTap: () {
        //print(_leaveProfileData.leaveDetail);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => LeaveDetailPage(_leaveProfileData.leaveType,
                    _leaveProfileData.leaveDetail)));
      },
      leading: Image.asset(
        "assets/menu/leave.png",
      ),
      title: Text(
        _leaveProfileData == null ? "###########" : _leaveProfileData.leaveType,
        style: TextStyle(
            fontSize: 17,
            fontFamily: 'NotoSansLaoUI-Regular',
            fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          Icon(
            Icons.access_time,
            size: 15,
            color: Colors.red[800],
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            _leaveProfileData == null
                ? "###########"
                : _leaveProfileData.cntDays,
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'NotoSansLaoUI-Regular',
            ),
          ),
        ],
      ),
      trailing: Icon(Icons.remove_red_eye),
    );
    /*return Card(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0),
        child: ListTile(
          leading: Image.asset(
            "assets/menu/leave.png",
          ),
          title: Text(
            loading != false ? "...." : '.....',///_leaveProfileData.leaveType,
            style: TextStyle(
                fontSize: 17,
                fontFamily: 'NotoSansLaoUI-Regular',
                fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: [
              Icon(
                Icons.access_time,
                size: 15,
                color: Colors.red[800],
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                loading != false ? "...." : '...',/// _leaveProfileData.cntDays,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'NotoSansLaoUI-Regular',
                ),
              ),
            ],
          ),
        ),
      ),
    );*/
  }
}
