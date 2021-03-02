import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ltcmainapp/LTCSmartDoors/Pages/OpenDoorFromDetail.dart';

class SmartDoorHomePage extends StatefulWidget {
  @override
  _SmartDoorHomePageState createState() => _SmartDoorHomePageState();
}

class _SmartDoorHomePageState extends State<SmartDoorHomePage> {
  final referenceDatabase = FirebaseDatabase.instance;
  Future openDoor() async {
    final ref = referenceDatabase.reference();
    ref.child('LTCSmartDoor').child('door-1').set({"status": 0}).asStream();
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        elevation: 0,
        title: Center(child: Text("LTC Smart Doors")),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => OpenDoorFrom(),
              );
            },
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          openDoor().whenComplete(() {
            AwesomeDialog(
                context: context,
                animType: AnimType.SCALE,
                headerAnimationLoop: false,
                dialogType: DialogType.SUCCES,
                dismissOnTouchOutside: false,
                title: "ເປີດປະຕູສຳເລັດ",
                desc: '',
                btnOkIcon: Icons.check_circle,
                btnOkColor: Colors.green,
                btnOkOnPress: () {},
                onDissmissCallback: () {
                  print("object");
                })
              ..show();
          });
        },
        child: Center(
          child: Card(
            color: Colors.grey[900],
            shadowColor: Colors.red[800],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.qr_code,
                color: Colors.red[800],
                size: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
