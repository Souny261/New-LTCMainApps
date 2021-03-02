import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:ltcmainapp/Leave/Controllers/getImageEmployee.dart';
import 'package:ltcmainapp/Leave/Controllers/leaveService.dart';
import 'package:ltcmainapp/Leave/Pages/leaveDetail.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LeaveUserWaitApprove extends StatefulWidget {
  String empID;
  String apiToken;
  String ThisYear;

  LeaveUserWaitApprove({this.empID, this.apiToken, this.ThisYear});

  @override
  _HomeLeaveWaitApproveState createState() => _HomeLeaveWaitApproveState();
}

class _HomeLeaveWaitApproveState extends State<LeaveUserWaitApprove>
    with SingleTickerProviderStateMixin {
  final LeaveService leave = LeaveService();
  final TextStyle whiteText = TextStyle(color: Colors.white);
  String thisYear = DateFormat("yyyy").format(DateTime.now());

  bool load = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<ResultLeaveWaiting> resultLeaveWaiting;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: loadListWaitingApproved(),
        onRefresh: _handleRefresh,
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    setState(() {
      load = true;
    });
  }

  Widget loadListWaitingApproved() {
    return FutureBuilder(
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
                      fontSize: 30.0, fontFamily: "NotoSansLaoUI-Regular"),
                  textAlign: TextAlign.start,
                  alignment:
                      AlignmentDirectional.topStart // or Alignment.topLeft
                  ),
            );
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                ResultLeaveWaiting resultLeaveWaiting = snapshot.data[index];
                var leaveTypeName = resultLeaveWaiting.leaveTypeName;
                var requestEmpID = resultLeaveWaiting.empID;
                var granEmpID = resultLeaveWaiting.grantEmpID; //
                var startDate = resultLeaveWaiting.startDate;
                var endDate = resultLeaveWaiting.endDate;
                var resTime = resultLeaveWaiting.resTime;
                var typeLeave = resultLeaveWaiting.typeLeave; // L / P
                var detailLeave = resultLeaveWaiting.detail;
                var requestID = resultLeaveWaiting.requestID;
                var nextApprove = resultLeaveWaiting
                    .nextApprove; // true have next / false don't have
                var granID = resultLeaveWaiting.granID;
                var RequestEmpImage = ImageProfile(
                  apiToken: '',
                  empID: requestEmpID.toString(),
                );
                return leaveTypeName == "Null"
                    ? Container(
                        child: Column(
                          children: [
                            Icon(
                              Icons.cancel,
                              color: Colors.red[800],
                              size: 45,
                            ),
                            Text("ບໍ່ມີຂໍ້ມູນຂາລາພັກຫາທ່ານ ",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: "NotoSansLaoUI-Regular",
                                    fontSize: 20))
                          ],
                        ),
                      )
                    : ListTile(
                        dense: false,
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 50,
                            minHeight: 90,
                            maxWidth: 50,
                            maxHeight: 100,
                          ),
                          child: RequestEmpImage,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              leaveTypeName,
                              style: TextStyle(
                                  fontFamily: "NotoSansLaoUI-Regular"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              typeLeave,
                              style: TextStyle(
                                  color: Colors.red,
                                  wordSpacing: 10.0,
                                  fontFamily: "NotoSansLaoUI-Regular",
                                  fontSize: 12),
                            ),
                            Spacer(),
                          ],
                        ),
                        subtitle: Column(
                          children: <Widget>[
                            Text(
                              "ເຫດຜົນ : ${detailLeave} ",
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: "NotoSansLaoUI-Regular",
                              ),
                            ),
                            Text(
                              resTime,
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: "NotoSansLaoUI-Regular",
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.navigate_next,
                          size: 25,
                        ),
                        onTap: () {
                          // print("$requestID,$typeLeave,$granEmpID,$nextApprove,$granID");
                          showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context, scrollController) {
                              return Material(
                                child: CupertinoPageScaffold(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    child: LeaveDetail(
                                      requestID: requestID.toString(),
                                      typeLeave: typeLeave,
                                      waitingApprove: 'appr',
                                      granEmpID: granEmpID.toString(),
                                      nextApprove: nextApprove,
                                      grantID: granID,
                                    ),
                                  ),
                                  navigationBar: CupertinoNavigationBar(
                                    transitionBetweenRoutes: false,
                                    middle: Text(
                                      'ລາຍລະອຽດການລາພັກ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'NotoSansLaoUI-Regular',
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
                    fontSize: 30.0, fontFamily: "NotoSansLaoUI-Regular"),
                textAlign: TextAlign.start,
                alignment: AlignmentDirectional.topStart // or Alignment.topLeft
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
      future: leave.leaveWaitApproved(widget.empID, load),
    );
  }

  Widget waitApproveDetail(waitDetail) {
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
                    "typeName",
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
                  contentPadding: EdgeInsets.all(5.0),
                  isThreeLine: true,
                  title: Column(
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 90,
                          minHeight: 100,
                          maxWidth: 90,
                          maxHeight: 100,
                        ),
                        child: ImageProfile(
                          apiToken: widget.apiToken,
                          empID: data.BempID,
                        ),
                      ),
                    ],
                  ),
                  subtitle: GestureDetector(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          data.bfullName,
                          style: TextStyle(
                              color: Colors.indigo,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
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
                                    fontSize: 12,
                                    color: Colors.deepPurple,
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
                                    fontSize: 12,
                                    color: Colors.deepPurple,
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
}
