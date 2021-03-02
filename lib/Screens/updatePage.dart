import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:ota_update/ota_update.dart';

class UpdatePage extends StatefulWidget {
  String url;
  String name;

  UpdatePage({this.url, this.name});

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {


  OtaEvent currentEvent;
  var load;
  var ev;
  String url;
  String name;


  Future<void> tryOtaUpdate() async {
    try {
      OtaUpdate()
          .execute(
        widget.url,
        destinationFilename: widget.name,
      )
          .listen(
            (OtaEvent event) {
          setState(() {
            ev = event;
            load = event.value;
          });
          /*print("URL=>" + url);
          print("URL=>" + name);
          print('EVENT: ${event.status} : ${event.value}');*/
        },
      );
    } catch (e) {
      print('Failed to make OTA update. Details: $e');
    }
  }
  @override
  void initState() {
    tryOtaUpdate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (ev == null) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Image.asset(
            "assets/r.gif",
            height: 200.0,
            width: 200.0,
          ),
        ),
      );
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: Center(child: const Text('Update App')),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/r.gif",
                height: 150.0,
                width: 200.0,
              ),
              Text(
                'ກຳລັງໂຫລດຂໍ້ມູນ: ' + load + " %",
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'NotoSansLaoUI-Regular',
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
