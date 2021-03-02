import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltcmainapp/FingerPrintHistory/Controller/fingerService.dart';
import 'package:ltcmainapp/FingerPrintHistory/Models/fingerModels.dart';
import 'package:ltcmainapp/FingerPrintHistory/Widgets/totalMonthFinger.dart';
import 'package:ltcmainapp/FingerPrintHistory/pages/scaechSumary.dart';
import 'package:ltcmainapp/FingerPrintHistory/pages/sumaryFinger.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ShowMonthToSceachData extends StatefulWidget {
  String empID, apiToken;
  ShowMonthToSceachData({this.empID, this.apiToken});
  @override
  _ShowMonthToSceachDataState createState() => _ShowMonthToSceachDataState();
}

class _ShowMonthToSceachDataState extends State<ShowMonthToSceachData> {
  FingerService service = new FingerService();
  List<FingerListMonth> _dateTime = List<FingerListMonth>();
  int selected = 0;
  String dateTimeSceach;
  var years = DateFormat('yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Center(
        child: GestureDetector(
          onTap: () {
            if (selected == 0) {
              dateTimeSceach = "01/$years";
              showBottonSheet(dateTimeSceach, widget.empID, widget.apiToken);
            } else if (selected == 1) {
              dateTimeSceach = "02/$years";
              showBottonSheet(dateTimeSceach, widget.empID, widget.apiToken);
            } else if (selected == 2) {
              dateTimeSceach = "03/$years";
              showBottonSheet(dateTimeSceach, widget.empID, widget.apiToken);
            } else if (selected == 3) {
              dateTimeSceach = "04/$years";
              showBottonSheet(dateTimeSceach, widget.empID, widget.apiToken);
            } else if (selected == 4) {
              dateTimeSceach = "05/$years";
              showBottonSheet(dateTimeSceach, widget.empID, widget.apiToken);
            } else if (selected == 5) {
              dateTimeSceach = "06/$years";
              showBottonSheet(dateTimeSceach, widget.empID, widget.apiToken);
            } else if (selected == 6) {
              dateTimeSceach = "07/$years";
              showBottonSheet(dateTimeSceach, widget.empID, widget.apiToken);
            } else if (selected == 7) {
              dateTimeSceach = "08/$years";
              showBottonSheet(dateTimeSceach, widget.empID, widget.apiToken);
            } else if (selected == 8) {
              dateTimeSceach = "09/$years";
              showBottonSheet(dateTimeSceach, widget.empID, widget.apiToken);
            } else if (selected == 9) {
              dateTimeSceach = "10/$years";
              showBottonSheet(dateTimeSceach, widget.empID, widget.apiToken);
            } else if (selected == 10) {
              dateTimeSceach = "11/$years";
              showBottonSheet(dateTimeSceach, widget.empID, widget.apiToken);
            } else if (selected == 11) {
              dateTimeSceach = "12/$years";
              showBottonSheet(dateTimeSceach, widget.empID, widget.apiToken);
            }
          },
          child: Container(
            height: 250,
            alignment: Alignment.center,
            width: double.infinity,
            child: CupertinoPicker(
              backgroundColor: Colors.white,
              itemExtent: 50,
              onSelectedItemChanged: (int i) {
                setState(() {
                  selected = i;
                });
              },
              looping: true,
              children: <Widget>[
                Center(
                  child: Text(
                    "ເບີ່ງຂໍ້ມູນເດືອນ: 01/$years",
                    style: TextStyle(
                        fontFamily: 'NotoSansLaoUI-Regular',
                        fontWeight: FontWeight.bold,
                        color: selected == 0 ? Colors.red[800] : Colors.green),
                  ),
                ),
                Center(
                  child: Text(
                    "ເບີ່ງຂໍ້ມູນເດືອນ: 02/$years",
                    style: TextStyle(
                        fontFamily: 'NotoSansLaoUI-Regular',
                        fontWeight: FontWeight.bold,
                        color: selected == 1 ? Colors.red[800] : Colors.green),
                  ),
                ),
                Center(
                  child: Text(
                    "ເບີ່ງຂໍ້ມູນເດືອນ: 03/$years",
                    style: TextStyle(
                        fontFamily: 'NotoSansLaoUI-Regular',
                        fontWeight: FontWeight.bold,
                        color: selected == 2 ? Colors.red[800] : Colors.green),
                  ),
                ),
                Center(
                  child: Text(
                    "ເບີ່ງຂໍ້ມູນເດືອນ: 04/$years",
                    style: TextStyle(
                        fontFamily: 'NotoSansLaoUI-Regular',
                        fontWeight: FontWeight.bold,
                        color: selected == 3 ? Colors.red[800] : Colors.green),
                  ),
                ),
                Center(
                  child: Text(
                    "ເບີ່ງຂໍ້ມູນເດືອນ: 05/$years",
                    style: TextStyle(
                        fontFamily: 'NotoSansLaoUI-Regular',
                        fontWeight: FontWeight.bold,
                        color: selected == 4 ? Colors.red[800] : Colors.green),
                  ),
                ),
                Center(
                  child: Text(
                    "ເບີ່ງຂໍ້ມູນເດືອນ: 06/$years",
                    style: TextStyle(
                        fontFamily: 'NotoSansLaoUI-Regular',
                        fontWeight: FontWeight.bold,
                        color: selected == 5 ? Colors.red[800] : Colors.green),
                  ),
                ),
                Center(
                  child: Text(
                    "ເບີ່ງຂໍ້ມູນເດືອນ: 07/$years",
                    style: TextStyle(
                        fontFamily: 'NotoSansLaoUI-Regular',
                        fontWeight: FontWeight.bold,
                        color: selected == 6 ? Colors.red[800] : Colors.green),
                  ),
                ),
                Center(
                  child: Text(
                    "ເບີ່ງຂໍ້ມູນເດືອນ: 08/$years",
                    style: TextStyle(
                        fontFamily: 'NotoSansLaoUI-Regular',
                        fontWeight: FontWeight.bold,
                        color: selected == 7 ? Colors.red[800] : Colors.green),
                  ),
                ),
                Center(
                  child: Text(
                    "ເບີ່ງຂໍ້ມູນເດືອນ: 09/$years",
                    style: TextStyle(
                        fontFamily: 'NotoSansLaoUI-Regular',
                        fontWeight: FontWeight.bold,
                        color: selected == 8 ? Colors.red[800] : Colors.green),
                  ),
                ),
                Center(
                  child: Text(
                    "ເບີ່ງຂໍ້ມູນເດືອນ: 10/$years",
                    style: TextStyle(
                        fontFamily: 'NotoSansLaoUI-Regular',
                        fontWeight: FontWeight.bold,
                        color: selected == 9 ? Colors.red[800] : Colors.green),
                  ),
                ),
                Center(
                  child: Text(
                    "ເບີ່ງຂໍ້ມູນເດືອນ: 11/$years",
                    style: TextStyle(
                        fontFamily: 'NotoSansLaoUI-Regular',
                        fontWeight: FontWeight.bold,
                        color: selected == 10 ? Colors.red[800] : Colors.green),
                  ),
                ),
                Center(
                  child: Text(
                    "ເບີ່ງຂໍ້ມູນເດືອນ: 12/$years",
                    style: TextStyle(
                        fontFamily: 'NotoSansLaoUI-Regular',
                        fontWeight: FontWeight.bold,
                        color: selected == 11 ? Colors.red[800] : Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showBottonSheet(date, empID, apiToken) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context, scrollController) {
        return Material(
          child: CupertinoPageScaffold(
            child: Container(
                height: MediaQuery.of(context).size.height / 1.5,
                child: SceachSumaryFinger(
                  date: date,
                  empID: empID,
                  apiToken: apiToken,
                )),
            navigationBar: CupertinoNavigationBar(
              transitionBetweenRoutes: false,
              //leading: Container(),
              backgroundColor: Colors.red[800],
              middle: Text(
                'ຂໍ້ມູນເດືອນ : $date',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'NotoSansLaoUI-Regular',
                ),
              ),
              automaticallyImplyLeading: false,
              trailing: GestureDetector(
                child: Icon(
                  Icons.fingerprint,
                  color: Colors.white,
                ),
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => TotalMonth(
                      empID: empID,
                      apiToken: apiToken,
                      date: date,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
