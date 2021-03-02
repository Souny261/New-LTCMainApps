import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ltcmainapp/Events/Content/scanEventPage.dart';
import 'package:ltcmainapp/Events/Controller/eventService.dart';
import 'package:ltcmainapp/Events/Models/eventModel.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'Pages/invitePage.dart' as invitePage;
import 'Pages/eventPage.dart' as eventPage;

class EventHomePage extends StatefulWidget {
  @override
  _EventHomePageState createState() => _EventHomePageState();
}

class _EventHomePageState extends State<EventHomePage>
    with SingleTickerProviderStateMixin {
  String barcode = "";
  Future<List<DataInvite>> ResultdataInvite;
  TabController controller;
  ScrollController _scrollViewController;
  final controllers = ScrollController();
  EventServices _eventServices = new EventServices();
  bool notification;
  TabController homeEvent;
  String Title = 'Event';
  ProgressDialog pr;
  TextEditingController controllerText = new TextEditingController();
  String filter;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeEvent = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController();
    // callData();
  }

  @override
  void dispose() {
    homeEvent.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
    return Container(
      color: Colors.red[800],
      child: SafeArea(
        child: NestedScrollView(
          controller: _scrollViewController, //_scrollViewController
          headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Center(
                    child: Text(
                      Title,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'NotoSansLaoUI-Regular',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                actions: <Widget>[],
                pinned: true,
                floating: true,
                backgroundColor: Colors.red[800],
                snap: true,
                bottom: TabBar(
                  isScrollable: true,
                  controller: homeEvent,
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.notifications_active),
                    ),
                    // ແຈ້ງ ການຕ່າງໆ
                    Tab(
                      icon: Icon(Icons.insert_invitation),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: homeEvent,
            children: <Widget>[
              Material(
                child: Container(
                  child: eventPage.eventPage(),
                ),
              ),
              Container(
                child: invitePage.invitePage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future EventScan() async {
    try {
      var barcode = await BarcodeScanner.scan();
      await pr.show();
      Future.delayed((Duration(seconds: 1))).whenComplete(() {
        pr.hide().whenComplete(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => scanEventPage(
                activeCode: barcode,
              ),
            ),
            // dataInvite: dataInvite, fileID: fileID,
          );
        });
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
