import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltcmainapp/Controller/sharedata.dart';
import 'package:ltcmainapp/FingerPrintHistory/Bloc/bloc/conversatoin_bloc.dart';
import 'package:ltcmainapp/FingerPrintHistory/Bloc/events/set_message.dart';
import 'package:ltcmainapp/FingerPrintHistory/Controller/fingerService.dart';
import 'package:ltcmainapp/FingerPrintHistory/DB/database_provider.dart';
import 'package:ltcmainapp/FingerPrintHistory/Models/fingerModels.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SumaryFingerPrint extends StatefulWidget {
  String viewDate;
  ScrollController homeFinger;
  String empID, apiToken;
  SumaryFingerPrint(
      {this.viewDate, this.homeFinger, this.empID, this.apiToken});
  @override
  _SumaryFingerPrintState createState() => _SumaryFingerPrintState();
}

class _SumaryFingerPrintState extends State<SumaryFingerPrint> {
  DateTime _dateTime = DateTime.now();
  FingerService service = new FingerService();
  DioCacheManager _dioCacheManager;
  ShareData _shareData = new ShareData();
  CounterBloc counterBloc = CounterBloc();
  int selected = 0;
  ProgressDialog pr;
  @override
  void initState() {
    super.initState();
    service
        .saveDataToSqlite(widget.viewDate, widget.apiToken, context)
        .whenComplete(() async {
      counterBloc.incrementCounter.add(2);
    });
    DatabaseProvider.db.getFingerBloc().then(
      (mesList) {
        BlocProvider.of<FingerBloc>(context).add(SetFinger(mesList));
      },
    );
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
    return StreamBuilder<int>(
        stream: counterBloc.pressedCount,
        builder: (context, snapshot) {
          if (snapshot.data == 1) {
            return Center(
              child: Image.asset(
                "assets/r.gif",
                height: 80.0,
                width: 80.0,
              ),
            );
          } else {
            return sumFingerList();
          }
        });
  }

  Widget sumFingerList() {
    return BlocConsumer<FingerBloc, List<SumFingerModels>>(
      builder: (context, foodList) {
        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            SumFingerModels finger = foodList[index];
            return Container(
              child: GestureDetector(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12),
                            )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  color: Colors.red[800],
                                ),
                                Text(
                                  finger.dateTime,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            var data;
                            pr.show();
                            service
                                .sumFingerPrint(finger.dateTime)
                                .then((value) {
                              data = value;
                              print("data:" + data);
                            }).whenComplete(() {
                              pr.hide();
                              if (data == 'N') {
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.SUCCES,
                                    animType: AnimType.TOPSLIDE,
                                    headerAnimationLoop: false, dismissOnTouchOutside: false,
                                    title: 'ແຈ້ງເຕືອນ',
                                    desc:
                                        'ວັນທີ ${finger.dateTime} ກຳລັງຄິດຄີດໄລ່ ລໍຖ້າການແຈ້ງເຕືອນ',
                                    btnOkOnPress: () {},
                                    btnOkIcon: Icons.check,
                                    btnOkColor: Colors.green)
                                  ..show();
                              } else if (data == 'Y') {
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.SUCCES,
                                    animType: AnimType.TOPSLIDE,
                                    headerAnimationLoop: false, dismissOnTouchOutside: false,
                                    title: 'ແຈ້ງເຕືອນ',
                                    desc:
                                        'ວັນທີ ${finger.dateTime} ໄດ້ຄິດໄລ່ສຳເລັດແລ້ວ',
                                    btnOkOnPress: () {},
                                    btnOkIcon: Icons.check,
                                    btnOkColor: Colors.green)
                                  ..show();
                              } else {
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.SUCCES,
                                    animType: AnimType.TOPSLIDE,
                                    headerAnimationLoop: false, dismissOnTouchOutside: false,
                                    title: 'ແຈ້ງເຕືອນ',
                                    desc:
                                        'ວັນທີ ${finger.dateTime} ຍັງບໍມີຂໍ້ມູ',
                                    btnOkOnPress: () {},
                                    btnOkIcon: Icons.check,
                                    btnOkColor: Colors.green)
                                  ..show();
                              }
                            });

                            // SumFingerModels food = SumFingerModels(
                            //     dateTime: finger.dateTime,
                            //     Finger: index.toString(),
                            //     inTime: "0",
                            //     outTime: "00",
                            //     leaveCut: "00",
                            //     leaveNormal: "0",
                            //     leavePerson: "0",
                            //     OnDay: "0000");
                            // DatabaseProvider.db.update(food).then(
                            //       (storedFood) =>
                            //           BlocProvider.of<FingerBloc>(context).add(
                            //         UpdateSum(index, food),
                            //       ),
                            //     );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                right: 8, left: 8, bottom: 5, top: 5),
                            decoration: BoxDecoration(
                                color: Colors.red[800],
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10))),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.white,
                                ),
                                Text("ຄຳນວນ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'NotoSansLaoUI-Regular')),
                              ],
                            ),
                          ),
                        )
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
                                "ເວລາຈ້ຳລາຍນີ້ວມື:",
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
                            finger.Finger,
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
                            finger.inTime,
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
                            finger.outTime,
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
                            finger.leaveCut,
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
                            finger.leaveNormal,
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
                            finger.leavePerson,
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
                                finger.OnDay,
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
          itemCount: foodList.length,
          separatorBuilder: (BuildContext context, int index) =>
              Divider(color: Colors.black),
        );
      },
      listener: (BuildContext context, foodList) {},
    );
  }
}
