import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:ltcmainapp/Controller/provider.dart';
import 'package:ltcmainapp/Controller/sharedata.dart';
import 'package:ltcmainapp/Home/Models/homeModel.dart';
import 'package:ltcmainapp/Home/Controller/homeService.dart';
import 'package:ltcmainapp/Home/Widget/bottomAppBar.dart';
import 'package:ltcmainapp/Home/Widget/drawer.dart';
import 'package:ltcmainapp/Home/Widget/menu.dart';
import 'package:ltcmainapp/Home/bloc/bloc_service.dart';
import 'package:ltcmainapp/LTCSmartDoors/Pages/OpenDoorFromDetail.dart';
import 'package:ltcmainapp/Leave/Controllers/leaveService.dart';
import 'package:ltcmainapp/LtcEvent/Controller/EventModel.dart';
import 'package:ltcmainapp/LtcEvent/Controller/EventServices.dart';
import 'package:ltcmainapp/Models/mainModels.dart';
import 'package:ltcmainapp/Rountes/router.dart';
import 'package:ltcmainapp/Screens/errorPage.dart';
import 'package:ltcmainapp/Screens/updatePage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:package_info/package_info.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Controller/drawerService.dart';
import 'package:ltcmainapp/Home/Widget/getImageProfile.dart' as ImageProfile;

import 'package:provider/provider.dart';

import 'Widget/sliderTap.dart';

FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<EventModel> evenList;
  LeaveService service = new LeaveService();
  RouterApp _router = new RouterApp();
  String result1, content, urlQR;
  bool isLoading = true;

  String apiToken = "";
  ProgressDialog pr;
  String barcode = "";
  var _lat;
  var _long;
  String fullname = "";
  String imageUser = "";
  String empID;
  String vs;
  String currentV;
  String url = "";
  String name = "";
  String leaveWaitApp;
  List<LeaveProfileData> leaveProfileData = [];
  HomeService homeService = new HomeService();
  ShareData shareData = new ShareData();
  DrawerService _drawerService = new DrawerService();
  String appID;
  StartWorkBloc workingTimeBloc = StartWorkBloc();
  OutWorkBloc outWorkBloc = OutWorkBloc();
  TotalWorkBloc totalTime = TotalWorkBloc();
  ApiTekenBloc tekenBloc = ApiTekenBloc();
  ApiServiceProvider event = new ApiServiceProvider();
  List<ResultLeaveWaiting> waitApprove;
  int counter = 0;
  String empIDS;
  bool loading = true;
  List<EventModel> eventModel;
  callData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      fullname = pref.getString("fullname");
      imageUser = pref.getString("imageUser");
      empID = pref.getString("empID");
      empIDS = pref.getString("empID");
      apiToken = pref.getString("apiToken");
      _drawerService.getUserData();
      homeService.getHomedata().then((value) {
        List<WorkingTime> workingTime = value.workingTime;
        context.read<WorkingTimeStart>().increment(workingTime[0].inTime);
        context.read<WorkingTimeEnd>().increment(workingTime[0].outTime);
        totalTime.incrementCounter.add(workingTime[0].OnDayToday);
        leaveProfileData = value.leaveProfileData;
        eventModel = value.eventModel;
        print(apiToken);
      }).then((value) {
        setState(() {
          loading = false;
        });
      });
    });
    event.getEvent().then((value) {
      setState(() {
        evenList = value;
      });
    });
    service.getLeaveForm().then((value) {
      setState(() {
        leaveWaitApp = value.waitDetail.toString();
      });
    });
  }

  void setUpNotification() async {
    _firebaseMessaging.getToken().then((token) {
      appID = token;
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> meassage) async {
        print(meassage);
        var data = jsonDecode(jsonEncode(meassage['notification']));
        var msg = showMessage.fromJson(data);
        AwesomeDialog(
            context: context,
            dialogType: DialogType.INFO,
            animType: AnimType.TOPSLIDE,
            headerAnimationLoop: false,
            title: msg.title,
            desc: msg.body,
            btnOkOnPress: () {
              Navigator.of(context).push(_router.listNoficationPage());
            },
            btnOkIcon: Icons.message,
            btnOkColor: Colors.indigo,
            btnOkText: "ເປີດເບິ່ງ",
            btnCancelOnPress: () {},
            btnCancelText: "ປິດກ່ອນ")
          ..show();
      },
      onResume: (Map<String, dynamic> meassage) async {
        print("onResume");
        print(meassage);
      },
      onLaunch: (Map<String, dynamic> meassage) async {
        print("onLaunch");
        print(meassage);
      },
    );
  }

  getCurrentlocation() async {
    Position positions = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var Lat = positions.latitude.toString();
    var Long = positions.longitude.toString();
    setState(() {
      _lat = Lat;
      _long = Long;
    });
    //print(_lat + ":" + _long);
  }

// --------- Version -------------
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    _packageInfo = info;
    homeService.getVersion().then((val) {
      vs = val.version;
      url = val.url;
      name = val.name;
      currentV = _packageInfo.version;
      homeService.updateUserVersion(currentV, empID);
      if (vs.toString() != currentV) {
        _showDialogUpdate("New Version", "ກະລຸນາອັບເດດແອບຂອງທ່ານ");
      }
    });
  }

  @override
  void initState() {
    getCurrentlocation();
    _initPackageInfo();
    setUpNotification();
    callData();
    super.initState();
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
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.red[800],
        drawer: NavDrawer(fullname, imageUser, empID, apiToken),
        appBar: AppBar(
          backgroundColor: Colors.red[800],
          elevation: 0,
          title: Center(
            child: Text(
              "LTC Main App",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            // IconButton(
            //     icon: Icon(Icons.ac_unit),
            //     onPressed: () async {
            //       AwesomeDialog(
            //         context: context,
            //         dialogType: DialogType.ERROR,
            //         animType: AnimType.SCALE,
            //         headerAnimationLoop: false,
            //         title: "content",
            //         dismissOnTouchOutside: false,
            //         btnCancelColor: Colors.red[800],
            //         btnCancelOnPress: () {},
            //         desc: '',
            //       )..show();
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (_) => SmartDoorHomePage()));
            //       // pr.show();
            //       // List<EventModel> evenList;
            //       // event.getEvent().then((value) {
            //       //   evenList = value;
            //       // }).whenComplete(() {
            //       //   Navigator.push(
            //       //           context,
            //       //           MaterialPageRoute(
            //       //               builder: (_) => NewEventHomePage(evenList)))
            //       //       .whenComplete(() => pr.hide());
            //       // });

            //       //.then((value) {
            //       //   Navigator.push(
            //       //       context,
            //       //       MaterialPageRoute(
            //       //           builder: (_) => NewEventHomePage(value)));
            //       // }).whenComplete(() => pr.hide());
            //     }),
            Stack(
              children: <Widget>[
                new IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      /*setState(() {
                        counter = 0;
                      });*/
                      Navigator.of(context).push(_router.listNoficationPage());
                    }),
                counter != 0
                    ? new Positioned(
                        right: 11,
                        top: 11,
                        child: new Container(
                          padding: EdgeInsets.all(2),
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 14,
                            minHeight: 14,
                          ),
                          child: Text(
                            '$counter',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : new Container()
              ],
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Column(
              children: <Widget>[
                Stack(
                  children: [
                    myheader(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Material(
                          elevation: 5.0,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            radius: 45.0,
                            child: ImageProfile.ImageProfile1(
                              apiToken: apiToken,
                              empID: empID,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Menu(
                  empID: empID,
                  apiToken: apiToken,
                  leaveWaitApp: leaveWaitApp,
                  evenList: evenList,
                  eventModel: eventModel,
                ),
                Expanded(
                  child: Container(
                    child: SlideTapHomeWidget(
                      eventModel: eventModel,
                      leaveProfileData: leaveProfileData,
                      loading: loading,
                    ),
                  ),
                )
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(left: 8),
                //       child: Text(
                //         "ປະຫວັດການລາພັກ",
                //         style: TextStyle(
                //           fontSize: 15,
                //           fontFamily: 'NotoSansLaoUI-Regular',
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // Expanded(
                //   child: LeaveListview(
                //     apiToken: apiToken,
                //     leaveProfileData: leaveProfileData,
                //     loading: loading,
                //   ),
                // )
              ],
            )
          ],
        ),
        bottomNavigationBar: BottonAppBarr(
          version: _packageInfo.version,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.keyboard_arrow_up,
              size: 50,
              color: Colors.red[800],
            ),
          ),
          tooltip: 'scan Qr code',
          onPressed: () {
            showBottonSheet(context);
            // showDialog(
            //   context: context,
            //   builder: (_) => Checkin(
            //     lat: _lat,
            //     long: _long,
            //   ),
            // );
            // shareData.startvibrate();
            // scan();
          },
        ),
      ),
    );
  }

  _showDialogUpdate(title, text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: <Widget>[
                Icon(
                  Icons.system_update,
                  color: Colors.red,
                  size: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                ),
              ],
            ),
            content: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 18),
              ),
            ),
            actions: <Widget>[
              Container(
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: FlatButton(
                  child: Text(
                    'ອັບເດດ',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'NotoSansLaoUI-Regular',
                        color: Colors.white),
                  ),
                  onPressed: () {
                    shareData.startvibrate();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdatePage(
                          url: url,
                          name: name,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: FlatButton(
                  child: Text(
                    'ປິດ',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NotoSansLaoUI-Regular',
                        fontSize: 15),
                  ),
                  onPressed: () {
                    shareData.startvibrate();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        });
  }

  Widget myheader() {
    return Container(
      height: MediaQuery.of(context).size.height / 3.3,
      child: Container(
        padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          elevation: 5.0,
          shadowColor: Colors.red[800],
          color: Colors.white,
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  shareData.saveApiToken(apiToken);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 3),
                  child: Text(fullname,
                      style: TextStyle(
                        fontSize: 23,
                        fontFamily: 'NotoSansLaoUI-Regular',
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              Material(
                child: Container(
                  height: MediaQuery.of(context).size.height / 10.2,
                  color: Colors.red[800],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: Column(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  workingTimeBloc.incrementCounter.add("455");
                                },
                                child: Text(
                                  context.watch<WorkingTimeStart>().mytime,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'NotoSansLaoUI-Regular',
                                  ),
                                )),
                            Text(
                              "ເຂົ້າວຽກ",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'NotoSansLaoUI-Regular',
                              ),
                            ),
                          ],
                        )),
                        Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 30,
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            showTotalTime(),
                            Text(
                              "ລວມ",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'NotoSansLaoUI-Regular',
                              ),
                            ),
                          ],
                        )),
                        Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 30,
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            Text(
                              context.watch<WorkingTimeEnd>().mytime,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NotoSansLaoUI-Regular',
                              ),
                            ),
                            Text(
                              "ອອກວຽກ",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'NotoSansLaoUI-Regular',
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showTotalTime() {
    return StreamBuilder<String>(
        stream: totalTime.pressedCount,
        builder: (context, snapshot) {
          return Text(
            snapshot.data == null ? "0" : snapshot.data,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'NotoSansLaoUI-Regular',
            ),
          );
        });
  }

  void showBottonSheet(context) {
    showCupertinoModalBottomSheet(
      backgroundColor: Colors.white38,
      context: context,
      builder: (context, scrollController) {
        return Container(
            height: MediaQuery.of(context).size.height / 5,
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          pr.show();
                          homeService
                              .getCheckIn(_lat, _long,
                                  'aXdYcVg0ZTdpTkljZmpxWkRYSnRMUT09')
                              .then((value) {
                            String time = DateFormat("HH:mm").format(
                                DateTime.parse(DateTime.now().toString()));
                            String checkingTime = DateFormat("HH").format(
                                DateTime.parse(DateTime.now().toString()));
                            CheckIn checkIn = value;
                            result1 = checkIn.result;
                            content = checkIn.content;
                            urlQR = checkIn.url;
                            if (result1 == "Y") {
                              int mytime = int.parse(checkingTime);
                              mytime >= 4 && mytime <= 12
                                  ? context
                                      .read<WorkingTimeStart>()
                                      .increment(time)
                                  : context
                                      .read<WorkingTimeEnd>()
                                      .increment(time);
                              pr.hide();
                              return AwesomeDialog(
                                  context: context,
                                  animType: AnimType.SCALE,
                                  headerAnimationLoop: false,
                                  dialogType: DialogType.SUCCES,
                                  title: content,
                                  desc: '',
                                  btnOkIcon: Icons.check_circle,
                                  dismissOnTouchOutside: false,
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
                              Navigator.of(context)
                                  .push(_router.webViewRouter(urlQR));
                            } else {
                              pr.hide();
                              return AwesomeDialog(
                                context: context,
                                dialogType: DialogType.ERROR,
                                animType: AnimType.SCALE,
                                dismissOnTouchOutside: false,
                                headerAnimationLoop: false,
                                title: content,
                                btnCancelColor: Colors.red[800],
                                btnCancelOnPress: () {
                                  Navigator.pop(context);
                                },
                                desc: '',
                              )..show();
                            }
                          }).whenComplete(() => pr.hide());
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
                                      child: Image.asset(
                                          'assets/menu/checkin.png'),
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.red[800],
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ));
      },
    );
  }

  Future scan() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var barcode = await BarcodeScanner.scan();
      var result = await Connectivity().checkConnectivity();
      String time =
          DateFormat("HH:mm").format(DateTime.parse(DateTime.now().toString()));
      String checkingTime =
          DateFormat("HH").format(DateTime.parse(DateTime.now().toString()));
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
        homeService.getCheckIn(_lat, _long, barcode.toString()).then((value) {
          CheckIn checkIn = value;
          result1 = checkIn.result;
          content = checkIn.content;
          urlQR = checkIn.url;
          print(urlQR);
          if (checkIn.res == "D") {
            if (result1 == "Y") {
              pr.hide();
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => OpenDoorFrom(),
              );
            } else {
              return AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                dismissOnTouchOutside: false,
                animType: AnimType.SCALE,
                headerAnimationLoop: false,
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
          } else {
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
                  dismissOnTouchOutside: false,
                  dialogType: DialogType.SUCCES,
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
                dismissOnTouchOutside: false,
                animType: AnimType.SCALE,
                headerAnimationLoop: false,
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
          }
        });
      } else if (result == ConnectivityResult.wifi) {
        pr.show();
        homeService.getCheckIn(_lat, _long, barcode.toString()).then((value) {
          CheckIn checkIn = value;
          result1 = checkIn.result;
          content = checkIn.content;
          urlQR = checkIn.url;
          print(urlQR);
          if (checkIn.res == "D") {
            if (result1 == "Y") {
              pr.hide();
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => OpenDoorFrom(),
              );
            } else {
              return AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                dismissOnTouchOutside: false,
                animType: AnimType.SCALE,
                headerAnimationLoop: false,
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
          } else {
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
                  dismissOnTouchOutside: false,
                  dialogType: DialogType.SUCCES,
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
                dismissOnTouchOutside: false,
                animType: AnimType.SCALE,
                headerAnimationLoop: false,
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
