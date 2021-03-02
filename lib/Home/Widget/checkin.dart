import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:ltcmainapp/Controller/provider.dart';
import 'package:ltcmainapp/Home/Controller/homeService.dart';
import 'package:ltcmainapp/Home/Models/homeModel.dart';
import 'package:ltcmainapp/Home/bloc/bloc_service.dart';
import 'package:ltcmainapp/Rountes/router.dart';
import 'package:ltcmainapp/Screens/errorPage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class Checkin extends StatefulWidget {
  String lat;
  String long;
  Checkin({this.lat, this.long});
  @override
  _CheckinState createState() => _CheckinState();
}

class _CheckinState extends State<Checkin> with SingleTickerProviderStateMixin {
  RouterApp _router = new RouterApp();
  String barcode = "";
  String result1, content, urlQR;
  HomeService homeService = new HomeService();
  ProgressDialog pr;

  StartWorkBloc workingTimeBloc = StartWorkBloc();
  OutWorkBloc outWorkBloc = OutWorkBloc();
  TotalWorkBloc totalTime = TotalWorkBloc();
  ApiTekenBloc tekenBloc = ApiTekenBloc();

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
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 30),
      child: Row(
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () {
              checkin();
            },
            child: Card(
              child: Container(
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/menu/checkin.png'),
                        ),
                      ),
                      Text(
                        "Check-In",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoSansLaoUI-Regular',
                        ),
                      )
                    ],
                  )),
            ),
          )),
          Expanded(
              child: GestureDetector(
            onTap: () {
              scan();
            },
            child: Card(
              child: Container(
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.qr_code,
                            color: Colors.red[800],
                            size: 45,
                          ),
                        ),
                      ),
                      Text(
                        "ສະແກຣນ QR",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoSansLaoUI-Regular',
                        ),
                      )
                    ],
                  )),
            ),
          )),
        ],
      ),
    );
  }

  Future checkin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String newToken = pref.getString("apiToken");
    String empID = pref.getString("empID");
    String time =
        DateFormat("HH:mm").format(DateTime.parse(DateTime.now().toString()));
    String checkingTime =
        DateFormat("HH").format(DateTime.parse(DateTime.now().toString()));
    homeService
        .getCheckIn(widget.lat, widget.long, 'aXdYcVg0ZTdpTkljZmpxWkRYSnRMUT09')
        .then((value) {
      CheckIn checkIn = value;
      result1 = checkIn.result;
      content = checkIn.content;
      urlQR = checkIn.url;
      print(urlQR);
      if (result1 == "Y") {
        int mytime = int.parse(checkingTime);
        mytime >= 4 && mytime <= 12
            ? context.read<WorkingTimeStart>().increment(time)
            : context.read<WorkingTimeEnd>().increment(time);
        return AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            headerAnimationLoop: false,
            dismissOnTouchOutside: false,
            dialogType: DialogType.SUCCES,
            title: content,
            desc: '',
            btnOkColor: Colors.green,
            btnOkOnPress: () {
              pr.hide().whenComplete(() {
                Navigator.pop(context);
              });
            },
            onDissmissCallback: () {
              print("object");
            })
          ..show();
      } else if (result1 == "W") {
        Navigator.of(context).push(_router.webViewRouter(urlQR));
      } else {
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          headerAnimationLoop: false,
          dismissOnTouchOutside: false,
          title: content,
          desc: '',
          btnCancelColor: Colors.red[800],
          btnCancelOnPress: () {
            Navigator.pop(context);
          },
        )..show();
      }
    });
  }

  Future scan() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String newToken = pref.getString("apiToken");
      String empID = pref.getString("empID");
      var barcode = await BarcodeScanner.scan();
      var result = await Connectivity().checkConnectivity();
      String time =
          DateFormat("HH:mm").format(DateTime.parse(DateTime.now().toString()));
      String checkingTime =
          DateFormat("HH").format(DateTime.parse(DateTime.now().toString()));
      //print(barcode);
      if (result == ConnectivityResult.none) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ErrorPage(),
          ),
        );
      } else if (result == ConnectivityResult.mobile) {
        print("code: " + barcode.toString());
        pr.show();
        homeService
            .getCheckIn(widget.lat, widget.long, barcode.toString())
            .then((value) {
          CheckIn checkIn = value;
          result1 = checkIn.result;
          content = checkIn.content;
          urlQR = checkIn.url;
          print(urlQR);
          if (result1 == "Y") {
            int mytime = int.parse(checkingTime);
            mytime >= 4 && mytime <= 12
                ? context.read<WorkingTimeStart>().increment(time)
                : context.read<WorkingTimeEnd>().increment(time);
            pr.hide();
            return AwesomeDialog(
                context: context,
                animType: AnimType.SCALE,
                headerAnimationLoop: false,
                dialogType: DialogType.SUCCES,
                dismissOnTouchOutside: false,
                title: content,
                desc: '',
                btnOkIcon: Icons.check_circle,
                btnOkColor: Colors.green,
                btnOkOnPress: () {
                  pr.hide().whenComplete(() {
                    Navigator.pop(context);
                  });
                },
                onDissmissCallback: () {
                  print("object");
                })
              ..show();
          } else if (result1 == "W") {
            pr.hide();
            Navigator.of(context).push(_router.webViewRouter(urlQR));
          } else {
            pr.hide();
            return AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.SCALE,
              headerAnimationLoop: false,
              dismissOnTouchOutside: false,
              title: content,
              desc: '',
              btnCancelColor: Colors.red[800],
              btnCancelOnPress: () {
                pr.hide().whenComplete(() {
                  Navigator.pop(context);
                });
              },
            )..show();
          }
        });
      } else if (result == ConnectivityResult.wifi) {
        pr.show();
        homeService
            .getCheckIn(widget.lat, widget.long, barcode.toString())
            .then((value) {
          CheckIn checkIn = value;
          result1 = checkIn.result;
          content = checkIn.content;
          urlQR = checkIn.url;
          print("WIFI");
          print(urlQR);
          if (result1 == "Y") {
            int mytime = int.parse(checkingTime);

            mytime >= 4 && mytime <= 12
                ? context.read<WorkingTimeStart>().increment(time)
                : context.read<WorkingTimeEnd>().increment(time);

            pr.hide();
            return AwesomeDialog(
                context: context,
                animType: AnimType.SCALE,
                headerAnimationLoop: false,
                dialogType: DialogType.SUCCES,
                dismissOnTouchOutside: false,
                title: content,
                desc: '',
                btnOkIcon: Icons.check_circle,
                btnOkColor: Colors.green,
                btnOkOnPress: () {
                  pr.hide().whenComplete(() {
                    Navigator.pop(context);
                  });
                },
                onDissmissCallback: () {
                  print("object");
                })
              ..show();
          } else if (result1 == "W") {
            pr.hide();
            Navigator.of(context).push(_router.webViewRouter(urlQR));
          } else {
            pr.hide();
            return AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.SCALE,
              headerAnimationLoop: false,
              title: content,
              dismissOnTouchOutside: false,
              btnCancelColor: Colors.red[800],
              btnCancelOnPress: () {
                Navigator.pop(context);
              },
              desc: '',
            )..show();
          }
        });
      }
      setState(() {
        this.barcode = barcode.toString();
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'Camera permission not granted';
        });
      } else {
        setState(() {
          this.barcode = 'Unknown Error : $e';
        });
      }
    } on FormatException {
      setState(() {
        this.barcode = 'null (user return)';
      });
    } catch (e) {
      setState(() {
        this.barcode = 'unknown';
      });
    }
  }
}
