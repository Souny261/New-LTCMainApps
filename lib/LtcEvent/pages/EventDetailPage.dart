import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ltcmainapp/Controller/sharedata.dart';
import 'package:ltcmainapp/Home/Controller/homeService.dart';
import 'package:ltcmainapp/Home/Models/homeModel.dart';
import 'package:ltcmainapp/LtcEvent/Controller/EventModel.dart';
import 'package:ltcmainapp/LtcEvent/Widgets/EventDetail.dart';
import 'package:ltcmainapp/LtcEvent/Widgets/ModelBottomAllPeople.dart';
import 'package:ltcmainapp/LtcEvent/Widgets/WorkingProcess.dart';
import 'package:ltcmainapp/Rountes/router.dart';
import 'package:ltcmainapp/Screens/errorPage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventDetailPage extends StatefulWidget {
  EventModel eventModel;
  EventDetailPage(this.eventModel);
  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  List time = ["8:00 AM", "ກຳລັງປະຊຸມ", "0"];
  var _lat;
  var _long;
  RouterApp _router = new RouterApp();
  String result1, content, urlQR;
  ProgressDialog pr;
  String barcode = "";
  HomeService homeService = new HomeService();
  ShareData shareData = new ShareData();
  int _selectedIndex = 0;

  String now =
      DateFormat("dd").format(DateTime.parse(DateTime.now().toString()));

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      EventDetailWidget(widget.eventModel),
      WorkingProcessWidget(widget.eventModel),
    ];
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

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height / 3,
        ), // here the desired height
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: widget.eventModel.eventBG,
                imageBuilder: (context, imageProvider) => Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.eventModel.fmTitle,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'NotoSansLaoUI-Regular',
                              ),
                            ),
                            Text(
                              DateFormat("MMM.dd yyyy").format(DateTime.parse(
                                    widget.eventModel.createDate,
                                  )) +
                                  " | By ${widget.eventModel.depName}/${widget.eventModel.sectionName}",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'NotoSansLaoUI-Regular',
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Icon(
                                            Icons.location_on,
                                            color: Colors.red[800],
                                            size: 18,
                                          ),
                                        ),
                                        TextSpan(
                                          text: widget.eventModel.fmAddress,
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.red[800],
                                            fontFamily: 'NotoSansLaoUI-Regular',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showCupertinoModalBottomSheet(
                                        backgroundColor: Colors.white,
                                        context: context,
                                        builder: (context, scrollController) {
                                          return PeopleInMeeting(
                                              widget.eventModel.users);
                                        });
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Icon(
                                            Icons.person_pin,
                                            color: Colors.red[800],
                                            size: 18,
                                          ),
                                        ),
                                        TextSpan(
                                          text: widget.eventModel.users.length
                                              .toString(),
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 18,
                                            color: Colors.red[800],
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'NotoSansLaoUI-Regular',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                placeholder: (context, url) =>
                    Container(height: 30, child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Positioned(
              top: 25,
              left: 8.0,
              right: 0,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    // Text(
                    //   "ລາຍລະອຽດ",
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 18,
                    //     color: Colors.black,
                    //     fontFamily: 'NotoSansLaoUI-Regular',
                    //   ),
                    // ),

                    now !=
                            DateFormat("dd").format(
                                DateTime.parse(widget.eventModel.inDate))
                        ? Container()
                        : Row(
                            children: [
                              widget.eventModel.eventTypeCheckInID == 1
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.pin_drop,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        String lat, long;
                                        pr.show();
                                        shareData.getLocation().then((value) {
                                          lat = value.lat;
                                          long = value.long;
                                        }).whenComplete(() {
                                          homeService
                                              .getCheckIn(lat, long,
                                                  widget.eventModel.codeActive)
                                              .then((value) {
                                            CheckIn checkIn = value;
                                            result1 = checkIn.result;
                                            content = checkIn.content;
                                            urlQR = checkIn.url;
                                            print("WIFI");
                                            print(urlQR);
                                            if (result1 == "Y") {
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
                                                    pr.hide();
                                                  },
                                                  onDissmissCallback: () {
                                                    print("object");
                                                  })
                                                ..show();
                                            } else if (result1 == "W") {
                                              pr.hide();
                                              Navigator.of(context).push(
                                                  _router.webViewRouter(urlQR));
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
                                                btnCancelOnPress: () {},
                                                desc: '',
                                              )..show();
                                            }
                                          });
                                        });
                                      })
                                  : IconButton(
                                      icon: Icon(
                                        Icons.qr_code,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        String lat, long;
                                        shareData.getLocation().then((value) {
                                          lat = value.lat;
                                          long = value.long;
                                        }).whenComplete(() {
                                          scan(lat: lat, long: long);
                                        });
                                      }),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text(
                'Event',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSansLaoUI-Regular',
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.attach_file,
              ),
              title: Text(
                'ແບບຟອມແນບ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSansLaoUI-Regular',
                ),
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
          selectedFontSize: 13.0,
          unselectedFontSize: 13.0,
          selectedItemColor: Colors.red[800]),
      // bottomNavigationBar: BottomAppBar(
      //   elevation: 0,
      //   shape: CircularNotchedRectangle(),
      //   color: Colors.transparent,
      //   notchMargin: 4.0,
      //   child: Container(
      //     height: 75,
      //     child: ProcessMeeting(1, time),
      //   ),
      // ),
    );
  }

  Future scan({String lat, String long}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var barcode = await BarcodeScanner.scan();
      var result = await Connectivity().checkConnectivity();
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

        homeService.getCheckIn(lat, long, barcode.toString()).then((value) {
          CheckIn checkIn = value;
          result1 = checkIn.result;
          content = checkIn.content;
          urlQR = checkIn.url;
          print(urlQR);
          if (result1 == "Y") {
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
                    //Navigator.pop(context);
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
              desc: '',
              btnCancelColor: Colors.red[800],
              btnCancelOnPress: () {
                pr.hide().whenComplete(() {
                  //Navigator.pop(context);
                });
              },
            )..show();
          }
        });
      } else if (result == ConnectivityResult.wifi) {
        pr.show();

        homeService.getCheckIn(_lat, _long, barcode.toString()).then((value) {
          CheckIn checkIn = value;
          result1 = checkIn.result;
          content = checkIn.content;
          urlQR = checkIn.url;
          print("WIFI");
          print(urlQR);
          if (result1 == "Y") {
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

  // void addProvider() {
  //   for (var i = 0; i < doodles.length; i++) {
  //     Provider.of<WorkProcessProvider>(context).addTaskInList(
  //         doodles[i].name,
  //         doodles[i].time,
  //         doodles[i].content,
  //         doodles[i].status,
  //         doodles[i].image);
  //   }
  //   print("object");
  // }
}
