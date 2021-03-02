import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class OpenDoorFrom extends StatefulWidget {
  @override
  _OpenDoorFromState createState() => _OpenDoorFromState();
}

class _OpenDoorFromState extends State<OpenDoorFrom>
    with SingleTickerProviderStateMixin {
  ProgressDialog pr;
  List data = [];
  final comment = new TextEditingController();
  Animation<double> scaleAnimation;
  AnimationController controller;
  final referenceDatabase = FirebaseDatabase.instance;
  Future openDoor() async {
    final ref = referenceDatabase.reference();
    ref.child('LTCSmartDoor').child('door-1').set({"status": 0}).asStream();
    print("object");
  }

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: Image.asset(
          "assets/r.gif",
          height: 100.0,
          width: 100.0,
        ),
        message: 'ກະລຸນາລໍຖ້າ',
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0))),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.bookmark,
                                color: Colors.red[800],
                              ),
                              Text(
                                "LTC Smart Door",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            maxLines: 8,
                            textAlign: TextAlign.center,
                            cursorColor: Colors.red,
                            controller: comment,
                            textInputAction: TextInputAction.go,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(
                                  fontFamily: 'NotoSansLaoUI-Regular',
                                  fontSize: 20),
                              labelText: 'ພີມລາຍລະອຽດ...',
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.red[800],
                                        size: 20,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "ປິດ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: 'NotoSansLaoUI-Regular',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                if (comment.text.isEmpty) {
                                  AwesomeDialog(
                                      context: context,
                                      animType: AnimType.SCALE,
                                      headerAnimationLoop: false,
                                      dialogType: DialogType.INFO,
                                      dismissOnTouchOutside: false,
                                      title: 'ກະລຸນາເພີ້ມຂໍ້ມູນ',
                                      desc: '',
                                      btnOkIcon: Icons.check_circle,
                                      btnOkColor: Colors.red[800],
                                      btnOkOnPress: () {},
                                      onDissmissCallback: () {})
                                    ..show();
                                } else {
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
                                        btnOkOnPress: () {
                                          Navigator.pop(context);
                                        },
                                        onDissmissCallback: () {
                                          print("object");
                                        })
                                      ..show();
                                  });
                                }
                              },
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.save,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "ບັນທຶກ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: 'NotoSansLaoUI-Regular',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
