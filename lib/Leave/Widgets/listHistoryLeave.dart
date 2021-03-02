import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltcmainapp/Leave/Controllers/leaveService.dart';
import 'package:ltcmainapp/Leave/Models/leaveModels.dart';
import 'package:ltcmainapp/Leave/Pages/leaveDetail.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ListHistoryLeave extends StatelessWidget {
 String filter;
ListHistoryLeave(this.filter);
  @override
  Widget build(BuildContext context) {
   
    DateTime _dateTime = DateTime.now();
    var year = DateFormat("yyyy").format(_dateTime);
    LeaveService leaveService = new LeaveService();
    return FutureBuilder(
      future: leaveService.getleaveDataHistory(year, false),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemBuilder: (BuildContext context, index) {
              LeaveDataModels dataLeave = snapshot.data[index];
              var status = dataLeave.statusVal;
              Color leaveColor =
                  status == 1 ? Colors.blue[700] : Colors.red[800];
              var startDate = DateFormat("dd/MM/yyyy")
                  .format(DateTime.parse(dataLeave.startDateTime));
              var endDate = DateFormat("dd/MM/yyyy")
                  .format(DateTime.parse(dataLeave.endDateTime));
              var showDate;
              if (startDate != endDate) {
                var Start = DateFormat("dd")
                    .format(DateTime.parse(dataLeave.startDateTime));
                var End = DateFormat("dd/MM/yyyy")
                    .format(DateTime.parse(dataLeave.endDateTime));
                showDate = Text(
                  "ວັນທີ ${Start}-${End}",
                  style: TextStyle(
                      fontSize: 14,
                      color: leaveColor,
                      fontFamily: 'NotoSansLaoUI-Regular',
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                );
              }
              if (startDate == endDate) {
                showDate = Text(
                  "ວັນທີ ${startDate} ",
                  style: TextStyle(
                      fontSize: 14,
                      color: leaveColor,
                      fontFamily: 'NotoSansLaoUI-Regular',
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                );
              }
              var showTime = Text(
                "ເວລາ ${DateFormat("hh:mm").format(DateTime.parse(dataLeave.startDateTime))} ຫາ ${DateFormat("hh:mm").format(DateTime.parse(dataLeave.endDateTime))}",
                style: TextStyle(
                    fontSize: 14,
                    color: leaveColor,
                    fontFamily: 'NotoSansLaoUI-Regular',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              );
              return filter == null || filter == ""
                  ? GestureDetector(
                      onTap: () {
                        showCupertinoModalBottomSheet(
                          context: context,
                          builder: (context, dynamic) {
                            return Material(
                              child: CupertinoPageScaffold(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .7,
                                  child: LeaveDetail(
                                    requestID: dataLeave.requestID.toString(),
                                    typeLeave: dataLeave.leaveType.toString(),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 5,
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              CircleAvatar(
                                foregroundColor: leaveColor,
                                radius: 30,
                                child: status == 1
                                    ? showImages("assets/png/leaveApproved.png",
                                        leaveColor)
                                    : showImages(
                                        "assets/png/leaveWaitApprove.png",
                                        leaveColor),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      dataLeave.typeName,
                                      style: TextStyle(
                                          color: leaveColor,
                                          fontFamily: 'NotoSansLaoUI-Regular',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.date_range,
                                          color: leaveColor,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        showDate
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.timer,
                                          color: leaveColor,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        showTime
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          '"${dataLeave.detail}"',
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              fontFamily:
                                                  'NotoSansLaoUI-Regular',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : dataLeave.typeName.toLowerCase().contains(
                            filter.toLowerCase(),
                          )
                      ? GestureDetector(
                          onTap: () {
                            showCupertinoModalBottomSheet(
                              context: context,
                              builder: (context, dynamic) {
                                return Material(
                                  child: CupertinoPageScaffold(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .7,
                                      child: LeaveDetail(
                                        requestID:
                                            dataLeave.requestID.toString(),
                                        typeLeave:
                                            dataLeave.leaveType.toString(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 5,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  CircleAvatar(
                                    foregroundColor: leaveColor,
                                    radius: 30,
                                    child: status == 1
                                        ? showImages(
                                            "assets/png/leaveApproved.png",
                                            leaveColor)
                                        : showImages(
                                            "assets/png/leaveWaitApprove.png",
                                            leaveColor),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          dataLeave.typeName,
                                          style: TextStyle(
                                              color: leaveColor,
                                              fontFamily:
                                                  'NotoSansLaoUI-Regular',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.date_range,
                                              color: leaveColor,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            showDate
                                          ],
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.timer,
                                              color: leaveColor,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            showTime
                                          ],
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              '"${dataLeave.detail}"',
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  fontFamily:
                                                      'NotoSansLaoUI-Regular',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container();
            },
            itemCount: snapshot.data.length,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Image.asset(
              "assets/r.gif",
              height: 100.0,
              width: 100.0,
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
    );
  }

  Widget showImages(path, color) {
    return new Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(width: 3, color: color),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset(
          path,
          color: color,
        ),
      ),
    );
  }
}
