import 'package:flutter/material.dart';
import 'package:ltcmainapp/Controller/sharedata.dart';
import 'package:ltcmainapp/FingerPrintHistory/Controller/fingerService.dart';
import 'package:ltcmainapp/FingerPrintHistory/Models/fingerModels.dart';

class SceachSumaryFinger extends StatefulWidget {
  String date, empID, apiToken;
  SceachSumaryFinger({this.date, this.empID, this.apiToken});
  @override
  _SceachSumaryFingerState createState() => _SceachSumaryFingerState();
}

class _SceachSumaryFingerState extends State<SceachSumaryFinger> {
  FingerService service = new FingerService();
  ShareData _shareData = new ShareData();
  String newApiToken = "";

  @override
  Widget build(BuildContext context) {
    return Material(child: getListFingerPrint());
  }

  Widget getListFingerPrint() {
    return FutureBuilder(
      future: service.getSearchMomthFingerList(widget.date),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return Center(child: Text("ບໍ່ພົບຂໍ້ມູນ"));
          }
          return ListView.separated(
              shrinkWrap: true,
              //physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(3.0),
              itemBuilder: (context, index) {
                FingerList fingerList = snapshot.data[index];
                return Container(
                  child: GestureDetector(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(
                              Icons.date_range,
                              color: Colors.red[800],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Card(
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  decoration: BoxDecoration(
                                      color: Colors.red[800],
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(12),
                                      )),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        fingerList.This,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.fingerprint,
                                    color: Colors.red[800],
                                  ),
                                  Text(
                                    "ເວລາຈ້ຳລາຍນີ້ວມື: ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'NotoSansLaoUI-Regular'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                fingerList.Finger,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'NotoSansLaoUI-Regular'),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.forward,
                                    color: Colors.red[800],
                                  ),
                                  Text("ເວລາເຂົ້າວຽກ: ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'NotoSansLaoUI-Regular',
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                fingerList.inTime,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'NotoSansLaoUI-Regular'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.forward,
                                    color: Colors.red[800],
                                  ),
                                  Text("ເວລາອອກວຽກ: ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'NotoSansLaoUI-Regular',
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                fingerList.outTime,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'NotoSansLaoUI-Regular'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.forward,
                                    color: Colors.red[800],
                                  ),
                                  Text("ລາຕັດ: ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'NotoSansLaoUI-Regular',
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                fingerList.LeaveCut,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'NotoSansLaoUI-Regular'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.forward,
                                    color: Colors.red[800],
                                  ),
                                  Text(
                                    "ລາບໍ່ຕັດ: ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'NotoSansLaoUI-Regular'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                fingerList.LeaveNormal,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'NotoSansLaoUI-Regular'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.forward,
                                    color: Colors.red[800],
                                  ),
                                  Text(
                                    "ກິດທຸລະຫ້ອງການ:",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'NotoSansLaoUI-Regular'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                fingerList.Person,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'NotoSansLaoUI-Regular'),
                              ),
                            ),
                          ],
                        ),
                        Card(
                          shadowColor: Colors.red[800],
                          elevation: 5.0,
                          child: Container(
                            color: Colors.red[800],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, top: 5, bottom: 5),
                                  child: Text(
                                    "ລວມພາຍໃນມື້: ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white,
                                        fontFamily: 'NotoSansLaoUI-Regular'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    fingerList.OnDay,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
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
}
