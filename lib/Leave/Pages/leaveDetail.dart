import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ltcmainapp/Leave/Controllers/leaveService.dart';
import 'package:ltcmainapp/Leave/Models/leaveModels.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:ltcmainapp/Leave/Controllers/getImageEmployee.dart'
    as ImageProfile;
import 'package:shimmer/shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class LeaveDetail extends StatefulWidget {
  String requestID;
  String typeLeave;
  String apiToken;
  String waitingApprove;
  String granEmpID;
  int grantID;
  bool nextApprove;

  LeaveDetail(
      {this.requestID,
      this.typeLeave,
      this.apiToken,
      this.waitingApprove,
      this.granEmpID,
      this.grantID,
      this.nextApprove});

  @override
  _LeaveDetailState createState() => _LeaveDetailState();
}

class _LeaveDetailState extends State<LeaveDetail>
    with SingleTickerProviderStateMixin {
  final LeaveService leave = LeaveService();
  final TextStyle whiteText = TextStyle(color: Colors.white);
  ScrollController scrollController;
  ProgressDialog pr;
  String requestID = "";
  String startDateTime = "";
  String endDateTime = "";
  String typeName = ".............";
  String leaveType = ".............";
  String detail = ".............";
  String statusType = ".............";
  String resStatus = ".............";
  String empName = "";
  String empPosition = "";
  String empID = "";
  String RequestEmpID = "";

  ///bool nextApprove = false;

  List dataWaiting = [];

  ModelLeaveDetail modelLeaveDetail;

  String startTime = ".............";
  String endTime = ".............";
  String ShowDate = ".............";
  var UserImage;
  var loading = true;

  //var cm = false;

  bool isSwitched = true;

  ///Future<ModelEmployeeApproved> modelEmployeeApproved;

  setData() {
    print("${widget.requestID},${widget.typeLeave}");
    leave.LeaveDetail(widget.requestID, widget.typeLeave, true)
        .whenComplete(() {
      setState(() {
        loading = false;
      });
    }).then((result) {
      setState(() {
        modelLeaveDetail = result;
        requestID = modelLeaveDetail.requestID; //result.requestID;
        typeName = modelLeaveDetail.typeName;
        startDateTime = DateFormat("dd/MM/yyyy")
            .format(DateTime.parse(modelLeaveDetail.startDateTime));
        endDateTime = DateFormat("dd/MM/yyyy")
            .format(DateTime.parse(modelLeaveDetail.endDateTime));
        if (startDateTime != endDateTime) {
          ShowDate = DateFormat("dd")
                  .format(DateTime.parse(modelLeaveDetail.startDateTime)) +
              "-" +
              DateFormat("dd/MM/yyyy")
                  .format(DateTime.parse(modelLeaveDetail.endDateTime));
        } else {
          ShowDate = DateFormat("dd/MM/yyyy")
              .format(DateTime.parse(modelLeaveDetail.endDateTime));
        }
        startTime = DateFormat("hh:mm")
            .format(DateTime.parse(modelLeaveDetail.startDateTime));
        endTime = DateFormat("hh:mm")
            .format(DateTime.parse(modelLeaveDetail.endDateTime));
        leaveType = modelLeaveDetail.leaveType;
        detail = modelLeaveDetail.detail;
        statusType = modelLeaveDetail.statusType;
        resStatus = modelLeaveDetail.resStatus;
        empName = modelLeaveDetail.empName;
        empPosition = modelLeaveDetail.empPosition;
        empID = modelLeaveDetail.empID;
        dataWaiting = modelLeaveDetail.waitDetail; //// List
        RequestEmpID = modelLeaveDetail.empID;
        UserImage = ImageProfile.ImageProfile(
          apiToken: widget.apiToken,
          empID: modelLeaveDetail.empID,
        );
      });
    });
  }

  @override
  void initState() {
    setData();
    //print(widget.nextApprove);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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

    return Material(
      child: SlidingUpPanel(
        backdropEnabled: true,
        panel: Center(
          heightFactor: MediaQuery.of(context).size.height,
          child: widget.waitingApprove == 'appr'
              ? formApprove(dataWaiting, widget.granEmpID, widget.nextApprove,
                  empID) // ໄປຫາແບບຟອມອະນຸມັດ
              : waitApproveDetail(
                  dataWaiting, widget.nextApprove), // ເບິ່ງລາຍລະອຽດທຳມະດາ
        ),
        body: Scaffold(
          body: loading == true
              ? Shimmer.fromColors(
                  highlightColor: Colors.white,
                  baseColor: Colors.red,
                  child: details(dataWaiting),
                )
              : details(dataWaiting),
        ),
      ),
    );
  }

  Widget details(waitDetail) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.red[800],
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Spacer(),
                  Text(
                    "ປະເພດການລາ : ${typeName}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 90,
                              minHeight: 100,
                              maxWidth: 90,
                              maxHeight: 100,
                            ),
                            child: InkWell(
                              child: UserImage,
                              onTap: () {
                                showCupertinoModalBottomSheet(
                                  context: context,
                                  builder: (context, scrollController) {
                                    return Material(
                                      child: CupertinoPageScaffold(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.6,
                                          child:
                                              waitApproveDetail(waitDetail, ''),
                                        ),
                                        navigationBar: CupertinoNavigationBar(
                                          transitionBetweenRoutes: false,
                                          middle: Text(
                                            'ລາຍລະອຽດການອະນຸມັດ',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily:
                                                  'NotoSansLaoUI-Regular',
                                            ),
                                          ),
                                          backgroundColor: Colors.red[800],
                                          automaticallyImplyLeading: false,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Text(
                            empName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSansLaoUI-Regular',
                            ),
                          ),
                          Text(
                            empPosition,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSansLaoUI-Regular',
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Colors.red[800],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Text(
                        "ວັນທີ ${ShowDate} ເວລາ ${startTime} ຫາ ${endTime}",
                        style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.red[800],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width),
                      padding: new EdgeInsets.all(10.0),
                      child: Text(
                        "ເຫດຜົນການລາ : ${detail}",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'NotoSansLaoUI-Regular',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.redAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Approve Detail ///
  Widget waitApproveDetail(waitDetail, nextApprove) {
    if (waitDetail == null) {
      return Center(
        child: Text("No Data"),
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.redAccent,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "ອະນຸມັດ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                  Spacer(),
                  Text(
                    typeName,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              child: Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, index) {
                var data = waitDetail[index];
                return ListTile(
                  enabled: true,
                  dense: true,
                  isThreeLine: true,
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 40,
                      minHeight: 90,
                      maxWidth: 50,
                      maxHeight: 100,
                    ),
                    child: ImageProfile.ImageProfile(
                      apiToken: widget.apiToken,
                      empID: data.BempID,
                    ),
                  ),
                  title: Text(
                    data.bfullName,
                    style: TextStyle(
                        color: Colors.indigo,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  subtitle: GestureDetector(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 2,
                        ),
                        Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "ລາຍລະອຽດ : ${data.detail}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.deepPurple,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'NotoSansLaoUI-Regular'),
                              ),
                            ),
                            Align(
                              child: Text(
                                "ສະຖານະ : ${data.statusText}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: data.sendDate == null
                                        ? Colors.deepOrange
                                        : Colors.deepPurple,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'NotoSansLaoUI-Regular'),
                              ),
                            ),
                            Align(
                              child: Text(
                                data.reason != null
                                    ? "ສະຖານະ : ${data.reason}"
                                    : '',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.deepPurple,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'NotoSansLaoUI-Regular'),
                              ),
                            ),
                            Align(
                              child: Text(
                                data.sendDate != null
                                    ? "ອະນຸມັດວັນທີ : ${data.sendDate}"
                                    : '',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: data.sendDate != null
                                        ? Colors.blue[600]
                                        : Colors.deepOrange,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'NotoSansLaoUI-Regular'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black12,
                );
              },
              itemCount: waitDetail.length,
            ),
          ))
        ],
      );
    }
  }

  /// Approve Detail ///

  final _commend = TextEditingController();

  /// ລໍຖ້າອະນຸມັດການລາພັກ ///
  Widget formApprove(waitDetail, granEmpID, nextApprove, requestByEmpID) {
    print("$waitDetail, $granEmpID, $nextApprove, $requestByEmpID");
    var nextGranEmpID;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.redAccent,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "ລໍຖາອະນຸມັດ ຈາກທ່ານ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                  Spacer(),
                  Text(
                    typeName,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Column(
            children: <Widget>[
              nextApprove == true
                  ? Container(
                      height: MediaQuery.of(context).size.height / 4,
                      child: FutureBuilder(
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.length == 0) {
                              return Center(
                                child: FadeAnimatedTextKit(
                                    text: [
                                      "ບໍ່ພົບ",
                                      "ລາຍການລໍຖ້າອະນຸມັດ",
                                    ],
                                    textStyle: TextStyle(
                                        fontSize: 30.0,
                                        fontFamily: "NotoSansLaoUI-Regular"),
                                    textAlign: TextAlign.start,
                                    alignment: AlignmentDirectional
                                        .topStart // or Alignment.topLeft
                                    ),
                              );
                            }
                            return ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  ModelEmployeeApproved resData =
                                      snapshot.data[index];
                                  nextGranEmpID = resData.employeeID;
                                  return ListTile(
                                    enabled: true,
                                    dense: true,
                                    isThreeLine: true,
                                    title: Column(
                                      children: <Widget>[
                                        Center(
                                          child: Text(
                                            "ອະນຸມັດຂັ້ນຕໍ່ໄປ",
                                            style: TextStyle(
                                                color: Colors.blue[600],
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ),
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            minWidth: 90,
                                            minHeight: 100,
                                            maxWidth: 90,
                                            maxHeight: 100,
                                          ),
                                          child: ImageProfile.ImageProfile(
                                            apiToken: widget.apiToken,
                                            empID:
                                                resData.employeeID.toString(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: GestureDetector(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            resData.fullName,
                                            style: TextStyle(
                                                color: Colors.indigo,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            "${resData.positionName} / ${resData.depName}",
                                            style: TextStyle(
                                                color: Colors.indigo,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            resData.tel,
                                            style: TextStyle(
                                                color: Colors.indigo,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                        ],
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
                            return Center(
                              child: FadeAnimatedTextKit(
                                  text: [
                                    "ບໍ່ພົບ",
                                    "ລາຍການລໍຖ້າອະນຸມັດ",
                                  ],
                                  textStyle: TextStyle(
                                      fontSize: 30.0,
                                      fontFamily: "NotoSansLaoUI-Regular"),
                                  textAlign: TextAlign.start,
                                  alignment: AlignmentDirectional
                                      .topStart // or Alignment.topLeft
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
                        future: leave.getEmployeeApproved(
                            granEmpID, requestByEmpID, '2'),
                      ),
                    )
                  : Center(
                      child: Text(
                        "ລໍຖ້າການອະນຸມັດຈາກທ່ານ",
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 18.0,
                            fontFamily: "NotoSansLaoUI-Regular"),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "ສະຖານະ: ${isSwitched == true ? 'ອະນຸມັດ' : 'ບໍ່ອະນຸມັດ'}",
                      style: TextStyle(
                          color: isSwitched == true
                              ? Colors.blue[600]
                              : Colors.deepOrange[600],
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  FlutterSwitch(
                    height: 25.0,
                    width: 40.0,
                    padding: 0.0,
                    toggleSize: 20.0,
                    borderRadius: 20.0,
                    activeColor: Colors.deepOrange,
                    value: isSwitched,
                    onToggle: (val) {
                      setState(() {
                        isSwitched = val;
                      });
                    },
                  ),
                ],
              ),
              isSwitched == false
                  /// ບໍ່ອະນຸມັດ
                  ? TextFormField(
                      controller: _commend,
                      decoration:
                          InputDecoration(hintText: "ເຫດຜົນທີ່ບໍ່ອະນຸມັດ"),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    )
                  : Container(),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: RaisedButton.icon(
                    color: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 120),
                    onPressed: () {
                      pr.show();
                      var requestID = widget.requestID;
                      var granID = widget.grantID;
                      var typeLeave = widget.typeLeave;
                      var status =
                          isSwitched; // ສະຖານະການອະນຸມັດ  true ອະນຸມັດ  / false ບໍ່ອະນຸມັດ
                      var typeQuery, gntStatus;
                      if (status == true) {
                        gntStatus = 1;
                      } else {
                        gntStatus = 2;
                      }
                      if (widget.nextApprove == true) {
                        print(widget.nextApprove);
                        typeQuery = "true";
                        leave
                            .getNextApproveLeave(widget.granEmpID)
                            .then((value) {
                          print(" grantID: ${value[0].employeeID}");
                          leave
                              .approveLeave(
                                  granID.toString(),
                                  typeLeave,
                                  requestID.toString(),
                                  value[0].employeeID.toString(),
                                  granEmpID.toString(),
                                  typeQuery.toString(),
                                  _commend.text,
                                  gntStatus.toString())
                              .whenComplete(() {
                            pr.hide();
                            AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                headerAnimationLoop: false,
                                dialogType: DialogType.SUCCES, dismissOnTouchOutside: false,
                                title: 'ການອະນຸມັດສຳເລັດ',
                                desc: '',
                                btnOkIcon: Icons.check_circle,
                                btnOkOnPress: () {
                                  Navigator.pop(context);
                                },
                                onDissmissCallback: () {
                                  print("object");
                                })
                              ..show();
                          });
                        });
                      } else {
                        print(widget.nextApprove);
                        typeQuery = "false";
                        leave
                            .approveLeave(
                                granID.toString(),
                                typeLeave,
                                requestID.toString(),
                                '',
                                granEmpID.toString(),
                                typeQuery.toString(),
                                _commend.text,
                                gntStatus.toString())
                            .whenComplete(() {
                          pr.hide();
                          AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              headerAnimationLoop: false, dismissOnTouchOutside: false,
                              dialogType: DialogType.SUCCES,
                              title: 'ການອະນຸມັດສຳເລັດ',
                              desc: '',
                              btnOkIcon: Icons.check_circle,
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
                    icon: Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                    ),
                    label: Text(
                      "ບັນທຶກ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontFamily: "NotoSansLaoUI-Regular",
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
