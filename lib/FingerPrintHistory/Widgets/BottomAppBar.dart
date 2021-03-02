import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltcmainapp/FingerPrintHistory/Controller/fingerService.dart';
import 'package:ltcmainapp/FingerPrintHistory/Widgets/ShowTimeTosceach.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:progress_dialog/progress_dialog.dart';

class BottomAppBarWidget extends StatelessWidget {
  String empID, apiToken;
  BottomAppBarWidget(this.empID, this.apiToken);
  @override
  Widget build(BuildContext context) {
    FingerService fingerService = new FingerService();
    ProgressDialog pr;
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

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Colors.white,
      notchMargin: 4.0,
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                "ຂໍ້ມູນ " + DateFormat('MM/yyyy').format(DateTime.now()),
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSansLaoUI-Regular',
                ),
              ),
            ),
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
                icon: Icon(
                  Icons.search,
                  size: 30.0,
                  color: Colors.red[800],
                ),
                onPressed: () {
                  showCupertinoModalBottomSheet(
                    context: context,
                    builder: (context, scrollController) {
                      return Material(
                        child: CupertinoPageScaffold(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 2.5,
                            child: ShowMonthToSceachData(
                              empID: empID,
                              apiToken: apiToken,
                            ),
                          ),
                          navigationBar: CupertinoNavigationBar(
                            transitionBetweenRoutes: false,
                            //leading: Container(),
                            middle: Text(
                              'ເບິ່ງຂໍ້ມູນ ເດືອນທີ່ທ່ານຕ້ອງການ',
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
                }),
          ),
        ],
      ),
    );
  }
}
