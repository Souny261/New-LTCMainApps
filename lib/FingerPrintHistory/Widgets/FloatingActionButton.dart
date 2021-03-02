import 'package:flutter/material.dart';
import 'package:ltcmainapp/FingerPrintHistory/Widgets/totalMonthFinger.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:progress_dialog/progress_dialog.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  String empID, apiToken, date;
  FloatingActionButtonWidget(this.empID, this.apiToken, this.date);
  @override
  Widget build(BuildContext context) {
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

    return FloatingActionButton(
      backgroundColor: Colors.red[800],
      elevation: 0,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.add_to_photos,
            color: Colors.white,
          ),
        ),
      ),
      tooltip: 'ລາຍລະອຽດ',
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => TotalMonth(
            empID: empID,
            apiToken: apiToken,
            date: date,
          ),
        );
      },
    );
  }
}
