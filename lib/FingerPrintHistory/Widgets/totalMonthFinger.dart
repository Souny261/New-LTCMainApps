import 'package:flutter/material.dart';
import 'package:ltcmainapp/FingerPrintHistory/Controller/fingerService.dart';
import 'package:shimmer/shimmer.dart';

class TotalMonth extends StatefulWidget {
  String date, empID, apiToken;
  TotalMonth({this.date, this.empID, this.apiToken});
  @override
  _TotalMonthState createState() => _TotalMonthState();
}

class _TotalMonthState extends State<TotalMonth>
    with SingleTickerProviderStateMixin {
  var loading = true;
  FingerService service = new FingerService();
  AnimationController controller;
  Animation<double> scaleAnimation;
  String SystemTotalTime,
      CountDay,
      TotalInMonth,
      TotalLeave,
      TotalPerLeave,
      TotalCutLeav,
      GetTotalThisMonth,
      TextDetail,
      UseTimeForEmployee;
  callData() {
    service.getTotalFinger(widget.date).then((value) {
      setState(() {
        SystemTotalTime = value.SystemTotalTime;
        TotalInMonth = value.TotalInMonth;
        TotalLeave = value.TotalLeave;
        TotalPerLeave = value.TotalPerLeave;
        TotalCutLeav = value.TotalCutLeave;
        GetTotalThisMonth = value.GetTotalThisMonth;
        TextDetail = value.TextDetail;
        UseTimeForEmployee = value.UseTimeForEmployee;
        CountDay = value.CountDay;
      });
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    callData();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return showTotal();
  }

  Widget showTotal() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 1.7,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: ListView(
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 15,
                                color: Colors.redAccent[700],
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.turned_in,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "ຂໍ້ມູນປະຈຳເດືອນ " + widget.date,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'NotoSansLaoUI-Regular',
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                  right: 8,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.forward,
                                  color: Colors.red[800],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                loading == true
                                    ? Shimmer.fromColors(
                                        highlightColor: Colors.white,
                                        baseColor: Colors.red[100],
                                        enabled: loading,
                                        child: Text(
                                          "  # # # # # # # # # # # # ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'NotoSansLaoUI-Regular',
                                          ),
                                        ),
                                      )
                                    : Text(
                                        SystemTotalTime.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'NotoSansLaoUI-Regular',
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.forward,
                                  color: Colors.red[800],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                loading == true
                                    ? Shimmer.fromColors(
                                        highlightColor: Colors.white,
                                        baseColor: Colors.red[100],
                                        enabled: loading,
                                        child: Text(
                                          "  # # # # # # # # # # # # ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'NotoSansLaoUI-Regular',
                                          ),
                                        ),
                                      )
                                    : Text(
                                        CountDay.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'NotoSansLaoUI-Regular',
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.forward,
                                  color: Colors.red[800],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                loading == true
                                    ? Shimmer.fromColors(
                                        highlightColor: Colors.white,
                                        baseColor: Colors.red[100],
                                        enabled: loading,
                                        child: Text(
                                          "  # # # # # # # # # # # # ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'NotoSansLaoUI-Regular',
                                          ),
                                        ),
                                      )
                                    : Text(
                                        TotalInMonth.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'NotoSansLaoUI-Regular',
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.forward,
                                  color: Colors.red[800],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                loading == true
                                    ? Shimmer.fromColors(
                                        highlightColor: Colors.white,
                                        baseColor: Colors.red[100],
                                        enabled: loading,
                                        child: Text(
                                          "  # # # # # # # # # # # # ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'NotoSansLaoUI-Regular',
                                          ),
                                        ),
                                      )
                                    : Text(
                                        TotalLeave.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'NotoSansLaoUI-Regular',
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.forward,
                                  color: Colors.red[800],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                loading == true
                                    ? Shimmer.fromColors(
                                        highlightColor: Colors.white,
                                        baseColor: Colors.red[100],
                                        enabled: loading,
                                        child: Text(
                                          "  # # # # # # # # # # # # ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'NotoSansLaoUI-Regular',
                                          ),
                                        ),
                                      )
                                    : Text(
                                        TotalPerLeave.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'NotoSansLaoUI-Regular',
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.forward,
                                  color: Colors.red[800],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                loading == true
                                    ? Shimmer.fromColors(
                                        highlightColor: Colors.white,
                                        baseColor: Colors.red[100],
                                        enabled: loading,
                                        child: Text(
                                          "  # # # # # # # # # # # # ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'NotoSansLaoUI-Regular',
                                          ),
                                        ),
                                      )
                                    : Text(
                                        TotalCutLeav.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'NotoSansLaoUI-Regular',
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.forward,
                                  color: Colors.red[800],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                loading == true
                                    ? Shimmer.fromColors(
                                        highlightColor: Colors.white,
                                        baseColor: Colors.red[100],
                                        enabled: loading,
                                        child: Text(
                                          "  # # # # # # # # # # # # ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'NotoSansLaoUI-Regular',
                                          ),
                                        ),
                                      )
                                    : Text(
                                        GetTotalThisMonth.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'NotoSansLaoUI-Regular',
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.forward,
                                  color: Colors.red[800],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                loading == true
                                    ? Shimmer.fromColors(
                                        highlightColor: Colors.white,
                                        baseColor: Colors.red[100],
                                        enabled: loading,
                                        child: Text(
                                          "  # # # # # # # # # # # # ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'NotoSansLaoUI-Regular',
                                          ),
                                        ),
                                      )
                                    : Text(
                                        TextDetail.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'NotoSansLaoUI-Regular',
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.red[800],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: loading == true
                                ? Shimmer.fromColors(
                                    highlightColor: Colors.white,
                                    baseColor: Colors.red[100],
                                    enabled: loading,
                                    child: Text(
                                      "  # # # # # # # # # # # # ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'NotoSansLaoUI-Regular',
                                      ),
                                    ),
                                  )
                                : Text(
                                    UseTimeForEmployee.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'NotoSansLaoUI-Regular',
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget shimerAnimation() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Material(
          color: Colors.white,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.7,
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                child: Text("data")),
          ),
        ),
      ),
    );
  }
}
