import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:ltcmainapp/Home/Controller/drawerService.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ResetID extends StatefulWidget {
  @override
  _ResetIDState createState() => _ResetIDState();
}

class _ResetIDState extends State<ResetID> with SingleTickerProviderStateMixin {
  Animation<double> scaleAnimation;
  AnimationController controller;
  ProgressDialog pr;
  final enpIDNO = TextEditingController();
  DrawerService _drawerService = new DrawerService();
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
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red[800],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "ປ້ອນລະຫັດພະນັກງານ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'NotoSansLaoUI-Regular',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: TextField(
                          textAlign: TextAlign.center,
                          onChanged: (String value) {},
                          cursorColor: Colors.red,
                          controller: enpIDNO,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          decoration: InputDecoration(
                              hintText: 'ລະຫັດພະນັກງານ',
                              hintStyle: TextStyle(
                                fontFamily: 'NotoSansLaoUI-Regular',
                              ),
                              prefixIcon: Container(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  margin: const EdgeInsets.only(right: 8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.red[700],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(20.0),
                                      )),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  )),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 13)),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          color: Colors.green[600],
                          onPressed: () {
                            pr.show();
                            _drawerService.resetID(enpIDNO.text).then((value) {
                              if (value == 'Y') {
                                pr.hide();
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.SUCCES,
                                    animType: AnimType.TOPSLIDE,
                                    headerAnimationLoop: false,
                                    dismissOnTouchOutside: false,
                                    title: 'ສຳເລັດ',
                                    desc: '',
                                    btnOkOnPress: () {
                                      Navigator.pop(context);
                                    },
                                    btnOkIcon: Icons.check,
                                    btnOkColor: Colors.green)
                                  ..show();
                              } else {
                                pr.hide();
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.ERROR,
                                    animType: AnimType.TOPSLIDE,
                                    headerAnimationLoop: false,
                                    dismissOnTouchOutside: false,
                                    title: 'Errors',
                                    desc: 'ກວດສອບລະຫັດພະນັກງານ',
                                    btnOkOnPress: () {},
                                    btnOkIcon: Icons.cancel,
                                    btnOkColor: Colors.red)
                                  ..show();
                              }
                            });
                          },
                          child: Text(
                            "ຕົກລົງ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'NotoSansLaoUI-Regular',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                          color: Colors.red[800],
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "ປິດ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'NotoSansLaoUI-Regular',
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
