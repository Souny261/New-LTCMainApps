import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ltcmainapp/Leave/Pages/leaveType.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showBottonSheet(context) {
  showCupertinoModalBottomSheet(
    context: context,
    builder: (context, scrollController) {
      return Material(
        child: CupertinoPageScaffold(
          child: Container(
              height: MediaQuery.of(context).size.height / 1.5,
              child: LeaveTypePage()),
          navigationBar: CupertinoNavigationBar(
            transitionBetweenRoutes: false,
            //leading: Container(),
            backgroundColor: Colors.red[800],
            middle: Text(
              'ກະລຸນາເລືອກປະເພດການລາ',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'NotoSansLaoUI-Regular',
              ),
            ),
            automaticallyImplyLeading: false,
            trailing: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.cancel_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      );
    },
  );
}
