import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ltcmainapp/Events/Content/scanEventPage.dart';
import 'package:ltcmainapp/Events/Controller/eventService.dart';
import 'package:ltcmainapp/Events/Models/eventModel.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class eventPage extends StatefulWidget {
  String empID;
  String apiToken;

  eventPage({this.empID, this.apiToken});

  @override
  _HomeEventState createState() => _HomeEventState();
}

class _HomeEventState extends State<eventPage>
    with SingleTickerProviderStateMixin {
  String barcode = "";
  String apiToken = "";
  String UserEmpID = "";
  bool btnCheckIn = false;

  ProgressDialog pr;
  Future<List<DataEventActive>> ResultdataEventActive;
  TextEditingController controller = new TextEditingController();
  EventServices _eventServices = new EventServices();
  String filter;
  final primary1 = Color(0xff696b9e);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

    return new RefreshIndicator(
      child: Center(
        child: FlatButton(
          onPressed: () {
            _eventServices.eventActiveList();
          },
          child: getListEventActive(),
        ),
      ),
      onRefresh: _handleRefresh,
    );
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    setState(() {
      ResultdataEventActive = _eventServices.eventActiveList();
    });
  }

  /*Text(
  "ບໍ່ພົບ Events ສຳຫຼັບທ່ານ",
  style: TextStyle(
  fontSize: 15,
  fontStyle: FontStyle.italic,
  fontFamily: 'NotoSansLaoUI-Regular'),
  ),*/

  Widget getListEventActive() {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return Center(
              child: FadeAnimatedTextKit(
                  text: [
                    "ບໍ່ພົບ",
                    "Events",
                    "ສຳຫຼັບທ່ານ",
                  ],
                  textStyle: TextStyle(
                      fontSize: 30.0, fontFamily: "NotoSansLaoUI-Regular"),
                  textAlign: TextAlign.start,
                  alignment:
                      AlignmentDirectional.topStart // or Alignment.topLeft
                  ),
            );
          }
          return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(3.0),
              itemBuilder: (context, index) {
                Fluttertoast.showToast(msg: snapshot.data.length.toString());
                DataEventActive dataEventActive = snapshot.data[index];
                var start = dataEventActive.sdate.substring(11);
                var end = dataEventActive.edate.substring(11);
                return Card(
                  margin: EdgeInsets.all(1.0),
                  child: GestureDetector(
                    onTap: () {
                      EventScan();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      dataEventActive.cntCheck > 0
                                          ? Icon(
                                              Icons.notifications,
                                              color: Colors.red,
                                            )
                                          : Icon(
                                              Icons.notifications_active,
                                              color: Colors.yellow,
                                            ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(12),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                dataEventActive.sdate,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Center(
                                      child: Text(
                                        dataEventActive.title,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'NotoSansLaoUI-Regular',
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'ເຊີນຈາກ : ',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontStyle: FontStyle.italic,
                                            fontFamily: 'NotoSansLaoUI-Regular',
                                          ),
                                        ),
                                        Text(
                                          dataEventActive.invite_by,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontStyle: FontStyle.italic,
                                            fontFamily: 'NotoSansLaoUI-Regular',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'ເລີມເວລາ : ',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontStyle: FontStyle.italic,
                                            fontFamily: 'NotoSansLaoUI-Regular',
                                          ),
                                        ),
                                        Text(
                                          '${start} - ${end}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontStyle: FontStyle.italic,
                                            fontFamily: 'NotoSansLaoUI-Regular',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'ສະຖານທີ : ${dataEventActive.room}',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontStyle: FontStyle.italic,
                                              fontFamily:
                                                  'NotoSansLaoUI-Regular'),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'ຈຳນວນຜູ້ເຂົ້າຮ່ວມ : ${dataEventActive.emp_join} ທ່ານ',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontStyle: FontStyle.italic,
                                              fontFamily:
                                                  'NotoSansLaoUI-Regular'),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black12,
                );
              },
              itemCount: snapshot.data.length);
        } else if (snapshot.hasError) {
          //return shared.checkingInternet();
          //print(snapshot.error);
          return Center(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 8),
              child: Container(
                height: MediaQuery.of(context).size.height / 5.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: primary1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.not_interested,
                      color: primary1,
                      size: 45,
                    ),
                    Text(
                      "ບໍ່ມີ Event",
                      style: TextStyle(
                          color: primary1,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoSansLaoUI-Regular'),
                    ),
                  ],
                ),
                alignment: Alignment.center,
              ),
            ),
          );
        } else {
          return Center(
            child: Image.asset(
              "assets/r.gif",
              height: 100.0,
              width: 100.0,
            ),
          );
        }
      },
      future:
          _eventServices.eventActiveList(), //eventClass.getSaveInvitEvent(),
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
                empID: widget.empID,
                apiToken: widget.apiToken,
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
