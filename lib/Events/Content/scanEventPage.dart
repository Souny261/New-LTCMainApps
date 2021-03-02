import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ltcmainapp/Events/Controller/eventService.dart';
import 'package:progress_dialog/progress_dialog.dart';

class scanEventPage extends StatefulWidget {
  String empID;
  String apiToken;
  String activeCode;

  scanEventPage({this.empID, this.apiToken, this.activeCode});

  @override
  _HomescanState createState() => _HomescanState();
}

class _HomescanState extends State<scanEventPage>
    with SingleTickerProviderStateMixin {
  String barcode = "";
  String apiToken = "";
  String UserEmpID = "";
  bool btnCheckIn = false;
  EventServices _eventServices = new EventServices();
  ProgressDialog pr;
  int elapsed = 1;
  String info = " ";

  process() {
    _eventServices.QRCodeAllCheckIn(widget.activeCode).then((res) {
      Fluttertoast.showToast(
          msg: res.info,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
      setState(() {
        info = res.info;

        pr.hide();
      });
    });
  }

  @override
  void initState() {
    process();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ProgressDialog//
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.style(
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: Image.asset(
          "assets/r.gif",
          height: 100.0,
          width: 100.0,
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(
          child: Text("Active QRCode Scan"),
        ),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: Image.asset('assets/smile.png', key: ValueKey(elapsed)),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
              child: Text(
                info,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'NotoSansLaoUI-Regular',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
