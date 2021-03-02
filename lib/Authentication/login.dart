import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ltcmainapp/Animation/FadeAnimation.dart';
import 'package:ltcmainapp/Authentication/loginPassword.dart';
import 'package:ltcmainapp/Authentication/Controller/Auth_Services.dart';
import 'package:progress_dialog/progress_dialog.dart';

FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final empIDNo = TextEditingController();
  ProgressDialog pr;
  final Services services = new Services();
  String appID;

  setData() {
    _firebaseMessaging.getToken().then((token) {
      setState(() {
        appID = token;
      });
    });
  }

  void setUpNotification() async {
    _firebaseMessaging.getToken().then((token) {
      appID = token;
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> meassage) async {
        print("Message: $meassage");
      },
      onResume: (Map<String, dynamic> meassage) async {
        print("Message: $meassage");
      },
      onLaunch: (Map<String, dynamic> meassage) async {
        print("Message: $meassage");
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
    setUpNotification();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(
        message: 'ກະລຸນາລໍຖ້າ...',
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
          color: Colors.black,
          fontSize: 13.0,
          fontWeight: FontWeight.w400,
          fontFamily: 'NotoSansLaoUI-Regular',
        ),
        messageTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 19.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'NotoSansLaoUI-Regular',
        ));
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.fill,
          ),
          // shape: BoxShape.circle,
        ),
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FadeAnimation(
                        1,
                        Container(
                          height: 150,
                          child: Image.asset('assets/Iconltc.png'),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                        1.2,
                        Text(
                          "ຂໍລະຫັດຜ່ານ",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'NotoSansLaoUI-Regular',
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          FadeAnimation(
                            1.2,
                            makeInput(
                                label: "ປ້ອນລະຫັດພະນັກງານ",
                                obscureText: false,
                                icons: Icon(Icons.person, color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(1.4, makeButton()),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: totalSale()),
      ),
    );
  }

  Widget totalSale() {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        elevation: 0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: FadeAnimation(
            1,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.copyright,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "LTC Main App",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ));
  }

  Widget makeButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Container(
        padding: EdgeInsets.only(top: 3, left: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: MaterialButton(
          minWidth: double.infinity,
          color: Colors.white,
          height: 45,
          onPressed: () async {
            print(appID);
            pr.show();
            Response<Map> r = await services.getPassword(empIDNo.text, appID);
            String status = r.data["status"].toString();
            String res = r.data["response"];
            /* print(status);
            print(appID);*/
            print(appID);
            pr.hide().whenComplete(() async {
              if (status == "true") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginPasswordPage(empIDNo: empIDNo.text),
                      fullscreenDialog: true,
                      maintainState: true),
                );
              }
              if (status == "false") {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.ERROR,
                    animType: AnimType.TOPSLIDE,
                    headerAnimationLoop: false, dismissOnTouchOutside: false,
                    title: 'ແຈ້ງເຕືອນ',
                    desc: 'ທ່ານປ້ອນລະຫັດພະນັກງານບໍ່ຖືກຕ້ອງ !!!',
                    btnOkOnPress: () {},
                    btnOkIcon: Icons.cancel,
                    btnOkColor: Colors.red)
                  ..show();
                //  pr.hide();
              }
              if (status == "haved") {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.ERROR,
                    animType: AnimType.TOPSLIDE,
                    headerAnimationLoop: false, dismissOnTouchOutside: false,
                    title: 'ແຈ້ງເຕືອນ',
                    desc:
                        'ລະຫັດພະນັກງານນີ້ ໄດ້ຖືກນຳໃຊ້ໃນເຄື່ອງອື່ນແລ້ວ. \n ກໍລະນີມີການປ່ຽນແປງການນຳໃຊ້ອຸປະກອນ ກະລຸນາຕິດຕໍ່ admin',
                    btnOkOnPress: () {},
                    btnOkIcon: Icons.cancel,
                    btnOkColor: Colors.red)
                  ..show();
              }
            });
          },
          elevation: 5,
          splashColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text("ຢືນຍັນ",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSansLaoUI-Regular',
                  color: Colors.black)),
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false, Icon icons}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        elevation: 2.0,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: TextField(
          controller: empIDNo,
          textAlign: TextAlign.center,
          onChanged: (String value) {},
          cursorColor: Colors.red,
          obscureText: obscureText,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          //keyboardType: TextInputType.number,
          decoration: InputDecoration(
              hintText: label,
              hintStyle: TextStyle(
                  fontFamily: 'NotoSansLaoUI-Regular',
                  fontWeight: FontWeight.bold),
              prefixIcon: Container(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  margin: const EdgeInsets.only(right: 8.0),
                  decoration: BoxDecoration(
                      color: Colors.red[700],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                        topRight: Radius.circular(20.0),
                      )),
                  child: icons),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
        ),
      ),
    );
  }
}
