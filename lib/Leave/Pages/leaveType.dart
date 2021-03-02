import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:ltcmainapp/Leave/Controllers/leaveService.dart';
import 'package:ltcmainapp/Leave/Models/leaveModels.dart';
import 'package:ltcmainapp/Leave/Pages/leaveRequest.dart';

class LeaveTypePage extends StatefulWidget {
  @override
  _LeaveTypePageState createState() => _LeaveTypePageState();
}

class _LeaveTypePageState extends State<LeaveTypePage> {
  List<EmpApproveLeave> approved;
  List<LeaveForm> leaveForm;
  final LeaveService leave = LeaveService();
  void setData() {
    leave.getLeaveForm().then((value) {
      setState(() {
        approved = value.approved;
        leaveForm = value.leaveForm;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: leaveForm == null
          ? Center(
              child: Image.asset(
                "assets/r.gif",
                height: 70.0,
                width: 70.0,
              ),
            )
          : ListView.builder(
              itemCount: leaveForm.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0,
                  child: ListTile(
                    onTap: () {
                      if (leaveForm[index].canLeaveTime == 0) {
                        makeAlert("ທ່ານບໍ່ສາມາດລາພັກໄດ້");
                      } else if (leaveForm[index].action == false) {
                        makeAlert(
                            "ການລາພັກຂອງທ່ານຕ້ອງໄດ້ຮັບການອະນຸມັດກ່ອນທ່ານຈື່ງສາມາດລາຄັ້ງຕໍ່ໄປໄດ້!\n");
                      } else {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LeaveRequest(
                                          leaveForm: leaveForm[index],
                                          approved: approved[0],
                                        )))
                            .whenComplete(() => Navigator.pop(context));
                      }
                    },
                    leading: leaveForm[index].canLeaveTime == 0
                        ? CircleAvatar(
                            backgroundColor: Colors.red[800],
                            radius: 25,
                            child: Icon(
                              Icons.cancel_schedule_send,
                              color: Colors.white,
                              size: 30,
                            ),
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.red[800],
                            radius: 25,
                            child: Icon(
                              Icons.feedback,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                    title: Text(
                      leaveForm[index].leaveName,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'NotoSansLaoUI-Regular',
                      ),
                    ),
                    subtitle: leaveForm[index].canLeaveTime == 0
                        ? Text(
                            leaveForm[index].leaveTimeDetail +
                                " (ທ່ານໃຊ້ວັນລາໝົດແລ້ວ)",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.red[800],
                              fontFamily: 'NotoSansLaoUI-Regular',
                            ),
                          )
                        : Text(
                            leaveForm[index].leaveTimeDetail,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'NotoSansLaoUI-Regular',
                            ),
                          ),
                  ),
                );
              },
            ),
    );
  }

  void makeAlert(title) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.TOPSLIDE, dismissOnTouchOutside: false,
        headerAnimationLoop: false,
        title: 'ຜິດພາດ',
        desc: title,
        btnOkOnPress: () {
          FocusScope.of(context).unfocus();
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red[800])
      ..show();
  }
}
