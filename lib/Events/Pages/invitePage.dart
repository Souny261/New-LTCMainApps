import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:ltcmainapp/Events/Content/EventDetail.dart';
import 'package:ltcmainapp/Events/Controller/eventService.dart';
import 'package:ltcmainapp/Events/Models/eventModel.dart';
import 'package:progress_dialog/progress_dialog.dart';

class invitePage extends StatefulWidget {
  String empID;
  String apiToken;
  invitePage({this.empID, this.apiToken});
  @override
  _HomeinviteState createState() => _HomeinviteState();
}

class _HomeinviteState extends State<invitePage>
    with SingleTickerProviderStateMixin {
      
  String barcode = "";
  String apiToken = "";
  String UserEmpID = "";
  bool btnCheckIn = false;
  ProgressDialog pr;
  EventServices _eventServices = new EventServices();
  // Future<List<DataInvite>> ResultdataInvite;
  TextEditingController controller = new TextEditingController();
  String filter;

  @override
  void initState() {
    // TODO: implement initState
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
    // eventClass.getDataInviteEvent(widget.apiToken, widget.empID);
    super.initState();
    //getInvite();
  }

  @override
  void dispose() {
    controller.dispose();
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

    return Material(
      child: new RefreshIndicator(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                hintText: 'ຄົນຫາຈາກ ຫົວຂໍ້ Invite',
              ),
              controller: controller,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'NotoSansLaoUI-Regular',
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child:  getListEvent(),
            ),
          ],
        ),
        onRefresh: _handleRefresh,
      ),
    );
  }

  Widget getListEvent() {
    return FutureBuilder(
      future: _eventServices.loadInviteEvent(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(3.0),
              itemBuilder: (context, index) {
                DataInvite dataInvite = snapshot.data[index];
                String activeCheckIn = dataInvite.activeCheckIn;
                List acListCheckedTime = dataInvite.acListCheckedTime;
                String MinTime = (acListCheckedTime[0]['minTime'] == null
                    ? '...'
                    : acListCheckedTime[0]['minTime']);
                String MaxTime = (acListCheckedTime[0]['maxTime'] == null
                    ? '...'
                    : acListCheckedTime[0]['maxTime']);

                return filter == null || filter == ""
                    ? Card(
                        margin: EdgeInsets.all(1.0),
                        child: GestureDetector(
                          onTap: () {
                            Fluttertoast.showToast(
                                msg: dataInvite.detail,
                                gravity: ToastGravity.BOTTOM,
                                toastLength: Toast.LENGTH_LONG,
                                backgroundColor: Colors.black45);
                          },
                          onLongPressUp: () {
                            Fluttertoast.showToast(
                                msg: dataInvite.createDate,
                                gravity: ToastGravity.BOTTOM,
                                toastLength: Toast.LENGTH_LONG,
                                backgroundColor: Colors.black45);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            (dataInvite.opening == true
                                                ? Icon(
                                                    Icons.drafts,
                                                    color: Colors.redAccent,
                                                  )
                                                : Icon(
                                                    Icons.markunread,
                                                    color: Colors.amber,
                                                  )),
                                            Padding(
                                              padding: EdgeInsets.all(6.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.redAccent,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(12),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      dataInvite.createDate,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                              dataInvite.title,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    'NotoSansLaoUI-Regular',
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
                                                  fontFamily:
                                                      'NotoSansLaoUI-Regular',
                                                ),
                                              ),
                                              Text(
                                                dataInvite.inviteBy,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontStyle: FontStyle.italic,
                                                  fontFamily:
                                                      'NotoSansLaoUI-Regular',
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
                                                dataInvite.inviteCode,
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
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            dataInvite.detail,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontStyle: FontStyle.italic,
                                                fontFamily:
                                                    'NotoSansLaoUI-Regular'),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'InTime: $MinTime',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontStyle: FontStyle.italic,
                                                    fontFamily:
                                                        'NotoSansLaoUI-Regular'),
                                              ),
                                              Text(
                                                'OutTime: $MaxTime',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontStyle: FontStyle.italic,
                                                    fontFamily:
                                                        'NotoSansLaoUI-Regular'),
                                              ),
                                              Text(
                                                'ເປີດ :' +
                                                    dataInvite.cntOpen +
                                                    'ຄັ້ງ',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontStyle: FontStyle.italic,
                                                    fontFamily:
                                                        'NotoSansLaoUI-Regular'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                        ),
                                        Container(
                                          color: Colors.red[50],
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              btnCheckInActive(
                                                  activeCheckIn, dataInvite),
                                              OutlineButton.icon(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          EventDetailContent(
                                                              dataInvite:
                                                                  snapshot.data[
                                                                      index],
                                                              empID:
                                                                  widget.empID,
                                                              apiToken: widget
                                                                  .apiToken),
                                                    ),
                                                  );
                                                },
                                                icon: Icon(
                                                    Icons.keyboard_arrow_right),
                                                label: Text("View Detail"),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : dataInvite.title.toLowerCase().contains(
                              filter.toLowerCase(),
                            )
                        ? Card(
                            margin: EdgeInsets.all(1.0),
                            child: GestureDetector(
                              onTap: () {
                                Fluttertoast.showToast(
                                    msg: dataInvite.detail,
                                    gravity: ToastGravity.BOTTOM,
                                    toastLength: Toast.LENGTH_LONG,
                                    backgroundColor: Colors.black45);
                              },
                              onLongPressUp: () {
                                Fluttertoast.showToast(
                                    msg: dataInvite.createDate,
                                    gravity: ToastGravity.BOTTOM,
                                    toastLength: Toast.LENGTH_LONG,
                                    backgroundColor: Colors.black45);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                (dataInvite.opening == true
                                                    ? Icon(
                                                        Icons.drafts,
                                                        color: Colors.redAccent,
                                                      )
                                                    : Icon(
                                                        Icons.markunread,
                                                        color: Colors.amber,
                                                      )),
                                                Padding(
                                                  padding: EdgeInsets.all(6.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.redAccent,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomRight:
                                                            Radius.circular(12),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          dataInvite.createDate,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Center(
                                                child: Text(
                                                  dataInvite.title,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        'NotoSansLaoUI-Regular',
                                                  ),
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              height: 1,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    'ເຊີນຈາກ : ',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontFamily:
                                                          'NotoSansLaoUI-Regular',
                                                    ),
                                                  ),
                                                  Text(
                                                    dataInvite.inviteBy,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontFamily:
                                                          'NotoSansLaoUI-Regular',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    dataInvite.inviteCode,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontFamily:
                                                            'NotoSansLaoUI-Regular'),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                dataInvite.detail,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontStyle: FontStyle.italic,
                                                    fontFamily:
                                                        'NotoSansLaoUI-Regular'),
                                              ),
                                            ),
                                            Divider(
                                              height: 1,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    'InTime: $MinTime',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontFamily:
                                                            'NotoSansLaoUI-Regular'),
                                                  ),
                                                  Text(
                                                    'OutTime: $MaxTime',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontFamily:
                                                            'NotoSansLaoUI-Regular'),
                                                  ),
                                                  Text(
                                                    'ເປີດ :' +
                                                        dataInvite.cntOpen +
                                                        'ຄັ້ງ',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontFamily:
                                                            'NotoSansLaoUI-Regular'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              height: 1,
                                            ),
                                            Container(
                                              color: Colors.red[50],
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  btnCheckInActive(
                                                      activeCheckIn,
                                                      dataInvite),
                                                  OutlineButton.icon(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EventDetailContent(
                                                                  dataInvite:
                                                                      snapshot.data[
                                                                          index],
                                                                  empID: widget
                                                                      .empID,
                                                                  apiToken: widget
                                                                      .apiToken),
                                                        ),
                                                      );
                                                    },
                                                    icon: Icon(Icons
                                                        .keyboard_arrow_right),
                                                    label: Text("View Detail"),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container();
              },
              separatorBuilder: (context, index) {
                DataInvite dataInvite = snapshot.data[index];
                return filter == null || filter == ""
                    ? Divider(
                        color: Colors.black12,
                      )
                    : dataInvite.title
                            .toLowerCase()
                            .contains(filter.toLowerCase())
                        ? Divider(
                            color: Colors.black12,
                          )
                        : Container();
              },
              itemCount: snapshot.data.length);
        } else if (snapshot.hasError) {
          //return Text("${snapshot.error}");
          return Center(
            child: Text(
              "ເກີດຂໍ້ຜິດພາດໃນການ ໂຫຼດຂໍ້ມູນ ",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'NotoSansLaoUI-Regular',
                  fontWeight: FontWeight.bold),
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
      //getDataInviteEvent(widget.apiToken, widget.empID), //eventClass.getSaveInvitEvent(),
    );
  }

  Widget btnCheckInActive(String activeCheckIn, DataInvite dataInvite) {
    switch (activeCheckIn) {
      case 'wa':
        {
          return Row(
            children: <Widget>[
              OutlineButton.icon(
                onPressed: () async {
                  ApprovedPopup(dataInvite, '1');
                },
                icon: Icon(Icons.playlist_add_check),
                label: Text("ເຂົ້າຮ່ວມ"),
              ),
              OutlineButton.icon(
                onPressed: () {
                  CancelPopup(dataInvite, '0');
                },
                icon: Icon(Icons.cancel),
                label: Text("ປະຕິເສດ"),
              ),
            ],
          );
        }
      case 'ac':
        {
          return OutlineButton.icon(
            onPressed: (activeCheckIn != 'ac') ? null : () => scan(),
            icon: Icon(
              Icons.playlist_add_check,
              color: Colors.indigo,
            ),
            label: Text(
              "Check In",
              style: TextStyle(color: Colors.indigo),
            ),
          );
        }
      case 'aco':
        {
          return OutlineButton.icon(
            onPressed: (activeCheckIn != 'aco') ? null : () => scan(),
            icon: Icon(
              Icons.playlist_add_check,
              color: Colors.orange,
            ),
            label: Text(
              "Check Out",
              style: TextStyle(color: Colors.orange),
            ),
          );
        }

      case 'ep':
        {
          return OutlineButton.icon(
            onPressed: null,
            icon: Icon(Icons.error_outline),
            label: Text("ກາຍກຳນົດ"),
          );
        }
      default:
        {
          //statements;
          return OutlineButton.icon(
            onPressed: null,
            icon: Icon(Icons.error_outline),
            label: Text(" "),
          );
        }
        break;
    }
  }

  Future<void> CancelPopup(DataInvite dataInvite, String status) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'ທ່ານຕ້ອງການປະຕິເສດການເຂົ້າຮ່ວມ ${dataInvite.title}',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'NotoSansLaoUI-Regular',
                fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(dataInvite.detail),
                Text(' ຜູ້ເຊີນເຂົ້າຮ່ວມ : ' + dataInvite.inviteBy),
              ],
            ),
          ),
          actions: <Widget>[
            OutlineButton.icon(
              onPressed: () async {
                Navigator.pop(context);
                await pr.show();
                Response<Map> r =
                    await _eventServices.approvedInvite(dataInvite.aiID, '0');
                _handleRefresh().whenComplete(() {
                  pr.hide();
                });
              },
              icon: Icon(
                Icons.cancel,
                color: Colors.orange,
              ),
              label: Text(
                'ປະຕິເສດ',
                style: TextStyle(color: Colors.orange),
              ),
            ),
            OutlineButton.icon(
              onPressed: () async {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
              label: Text(
                "ຍົກເລີກ",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> ApprovedPopup(DataInvite dataInvite, String status) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'ທ່ານຕ້ອງການປະຕິເສດການເຂົ້າຮ່ວມ ${dataInvite.title}',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'NotoSansLaoUI-Regular',
                fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(dataInvite.detail),
                Text(
                  ' ຜູ້ເຊີນເຂົ້າຮ່ວມ : ' + dataInvite.inviteBy,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'NotoSansLaoUI-Regular',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            OutlineButton.icon(
              onPressed: () async {
                Navigator.pop(context);
                await pr.show();
                Response<Map> r = await _eventServices.approvedInvite(
                    dataInvite.aiID, status);
                _handleRefresh().whenComplete(() {
                  pr.hide();
                });
              },
              icon: Icon(Icons.check),
              label: Text(
                'ເຂົ້າຮ່ວມ',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'NotoSansLaoUI-Regular',
                    fontWeight: FontWeight.bold),
              ),
            ),
            OutlineButton.icon(
              onPressed: () async {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
              label: Text(
                "ຍົກເລີກ",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontFamily: 'NotoSansLaoUI-Regular',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  Future scan() async {
    try {
      var barcode = await BarcodeScanner.scan();
      await pr.show();
      _eventServices.QRCodeAllCheckIn(barcode.toString()).then((res) {
        Fluttertoast.showToast(
                msg: res.info,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM)
            .whenComplete(() {
          pr.hide();
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

  Future<Null> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    setState(() {
      // ResultdataInvite = eventClass.loadInviteEvent(widget.apiToken, widget.empID);
    });
  }
}
