import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltcmainapp/Leave/Controllers/getImageEmployee.dart'
    as ImageProfile;
import 'package:ltcmainapp/Leave/Controllers/leaveService.dart';
import 'package:ltcmainapp/Leave/Models/leaveModels.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LeaveRequest extends StatefulWidget {
  EmpApproveLeave approved;
  LeaveForm leaveForm;
  LeaveRequest({this.approved, this.leaveForm});
  @override
  _LeaveRequestState createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  double _height;
  double _width;
  var day = "0";
  final detailLeave = new TextEditingController();
  DateTime _startdateTime;
  DateTime _enddateTime;
  TextEditingController _timeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  String _hour, _minute, _time;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String _setTime, _setDate;
  ProgressDialog pr;
  final LeaveService leaveService = LeaveService();
  bool succ = false;

  Future<Null> _selectTime(BuildContext context, typeSelected) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) if (typeSelected == "0") {
      if (picked.hour < 8 || picked.hour > 17) {
        makeAlert(
            "ທ່ານສາມາດລາພັກໄດ້ຕັ້ງແຕ່ເວລາ 8 ໂມງຫາ 17 ໂມງ ເທົ່ານັ້ນ... \n ກະລຸນາເລືອກອີກຄັ້ງ");
      } else {
        setState(() {
          selectedTime = picked;
          _hour = selectedTime.hour.toString();
          _minute = selectedTime.minute.toString();
          _time = _hour + ' : ' + _minute;
          _timeController.text = _time;
          _timeController.text = formatDate(
              DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
              [HH, ':', nn, ' ໂມງ']).toString();
          _endTimeController.text = formatDate(
              DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
              ['17', ':', '00', ' ໂມງ']).toString();
        });
      }
    } else {
      var sDay = int.parse(DateFormat('dd').format(_startdateTime));
      var eDay = int.parse(DateFormat('dd').format(_enddateTime));
      var sTime = int.parse(
          _timeController.text.substring(0, _timeController.text.length - 7));

      if (sDay == eDay) {
        if (picked.hour < 8 || picked.hour > 17) {
          makeAlert(
              "ທ່ານສາມາດລາພັກໄດ້ຕັ້ງແຕ່ເວລາ 8 ໂມງຫາ 17 ໂມງ ເທົ່ານັ້ນ... \n ກະລຸນາເລືອກອີກຄັ້ງ");
        } else if (sTime > picked.hour) {
          makeAlert("ທ່ານເລືອກເວລາບໍ່ຖືກຕ້ອງ ເວລາສີ້ນສຸດຕ້ອງຫຼາຍກວ່າ");
        } else {
          setState(() {
            selectedTime = picked;
            _hour = selectedTime.hour.toString();
            _minute = selectedTime.minute.toString();
            _time = _hour + ' : ' + _minute;
            _endTimeController.text = _time;
            _endTimeController.text = formatDate(
                DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
                [HH, ':', nn, ' ໂມງ']).toString();
          });
        }
      } else {
        if (picked.hour < 8 || picked.hour > 17) {
          makeAlert(
              "ທ່ານສາມາດລາພັກໄດ້ຕັ້ງແຕ່ເວລາ 8 ໂມງຫາ 17 ໂມງ ເທົ່ານັ້ນ... \n ກະລຸນາເລືອກອີກຄັ້ງ");
        } else {
          setState(() {
            selectedTime = picked;
            _hour = selectedTime.hour.toString();
            _minute = selectedTime.minute.toString();
            _time = _hour + ' : ' + _minute;
            _endTimeController.text = _time;
            _endTimeController.text = formatDate(
                DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
                [HH, ':', nn, ' ໂມງ']).toString();
          });
        }
      }
    }
  }

  @override
  void initState() {
    _startdateTime = DateTime.now();
    _enddateTime = DateTime.now();
    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        ["08", ':', "00", ' ໂມງ']).toString();
    _endTimeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        ["17", ':', "00", ' ໂມງ']).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hieght = MediaQuery.of(context).size.height;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    var limit = widget.leaveForm.timeLimit / 8;
    var use = widget.leaveForm.canLeaveTime == null
        ? 0.0
        : widget.leaveForm.canLeaveTime / 8;
    var can = widget.leaveForm.leaveTime / 8;

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
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: succ ? Colors.green : Colors.red[800],
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.chevron_left,
              size: 45,
            ),
          ),
          title: succ
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Text("ການດຳເນີນງານສຳເລັດ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: 'NotoSansLaoUI-Regular',
                            color: Colors.white)),
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Text("ປ້ອນຂໍ້ມູນການລາພັກ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: 'NotoSansLaoUI-Regular',
                            color: Colors.white)),
                  ),
                ),
        ),
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 6,
              width: double.infinity,
              color: succ ? Colors.green : Colors.red[800],
              child: Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("ປະເພດ:",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'NotoSansLaoUI-Regular',
                                color: Colors.white)),
                        Text(widget.leaveForm.leaveName,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'NotoSansLaoUI-Regular',
                                color: Colors.white)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("ເວລາກຳນົດ:",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'NotoSansLaoUI-Regular',
                                color: Colors.white)),
                        Text(limit.toStringAsFixed(0).toString() + " ວັນ",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'NotoSansLaoUI-Regular',
                                color: Colors.white)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("ເວລາທີ່ລາໄປ:",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'NotoSansLaoUI-Regular',
                                color: Colors.white)),
                        Text(can.toStringAsFixed(0).toString() + " ວັນ",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'NotoSansLaoUI-Regular',
                                color: Colors.white)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("ສາມາດລາໄດ້:",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'NotoSansLaoUI-Regular',
                                color: Colors.white)),
                        Text(use.toStringAsFixed(0).toString() + " ວັນ",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'NotoSansLaoUI-Regular',
                                color: Colors.white)),
                      ],
                    )
                  ],
                ),
              ),
            ),
            makeInput(
                label: "ເຫດຜົນການລາພັກ",
                icons: Icon(Icons.edit, color: Colors.white)),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: succ ? Colors.green : Colors.red[800],
                    child: Icon(
                      Icons.date_range,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text("ກະລຸນາເລືອກວັນທິ:",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'NotoSansLaoUI-Regular',
                      )),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: makeDatePicker(
                        'ເລີ່ມຕົ້ນ',
                        _startdateTime == null
                            ? DateFormat('dd/MM/yyyy').format(DateTime.now())
                            : DateFormat('dd/MM/yyyy').format(_startdateTime),
                        "0")),
                Expanded(
                    child: makeDatePicker(
                        'ສິ້ນສຸດ',
                        _enddateTime == null
                            ? DateFormat('dd/MM/yyyy').format(DateTime.now())
                            : DateFormat('dd/MM/yyyy').format(_enddateTime),
                        "1")),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: succ ? Colors.green : Colors.red[800],
                    child: Icon(
                      Icons.timer,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text("ກະລຸນາເວລາ:",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'NotoSansLaoUI-Regular',
                      )),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(child: makeStartDateSelect('ເລີ່ມຕົ້ນ')),
                Expanded(child: makeEndDateSelect('ສິ້ນສຸດ')),
              ],
            ),
            Divider(
              color: Colors.red[800],
            ),
            Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: ListTile(
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 60,
                      minHeight: 60,
                      maxWidth: 60,
                      maxHeight: 60,
                    ),
                    child: ImageProfile.ImageProfile(
                      empID: widget.approved.employeeID.toString(),
                    ),
                  ),
                  title: Text("ຜູ້ອະນຸມົດ:",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'NotoSansLaoUI-Regular',
                      )),
                  subtitle: Text(widget.approved.fullName,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'NotoSansLaoUI-Regular',
                      )),
                )),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.white,
          notchMargin: 4.0,
          child: succ
              ? Container(
                  height: MediaQuery.of(context).size.height / 14,
                  color: Colors.green,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "ເບີ່ງປະຫວັດການລາ",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'NotoSansLaoUI-Regular',
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height / 14,
                  color: Colors.red[800],
                  child: InkWell(
                    onTap: () {
                      pr.show();
                      var leave = widget.leaveForm;
                      var sTime = _timeController.text
                          .substring(0, _timeController.text.length - 4);
                      var eTime = _endTimeController.text
                          .substring(0, _endTimeController.text.length - 4);
                      var startDate = DateFormat('yyyy-MM-dd $sTime:00')
                          .format(_startdateTime);
                      var endDate = DateFormat('yyyy-MM-dd $eTime:00')
                          .format(_enddateTime);
                      // var totalDay = day.substring(0, day.length - 15);
                      if (detailLeave.text.isEmpty) {
                        makeAlert("ກະລຸນາປ້ອນຂໍ້ມູນ ( ເຫດຜົນການລາພັກ )");
                      } else if (_timeController.text ==
                          _endTimeController.text) {
                        makeAlert("ກະລຸນາເລືອກ ( ເວລາການລາພັກ )");
                      } else {
                        // print("$startDate $endDate");
                        leaveService
                            .requstLeave(
                          leave.typeLeave,
                          leave.leaveID.toString(),
                          detailLeave.text,
                          startDate,
                          endDate,
                          widget.approved.employeeID.toString(),
                        )
                            .then((value) {
                          if (value == "Y") {
                            makeSeccAlert();
                          } else {
                            AwesomeDialog(
                                context: context,
                                dialogType: DialogType.ERROR,
                                animType: AnimType.TOPSLIDE, dismissOnTouchOutside: false,
                                headerAnimationLoop: false,
                                title: 'ຜິດພາດ',
                                desc: 'ເກີດຂໍ້ຜິດພາດ',
                                btnOkOnPress: () {
                                  FocusScope.of(context).unfocus();
                                  pr.hide();
                                },
                                btnOkIcon: Icons.cancel,
                                btnOkColor: Colors.red[800])
                              ..show();
                          }
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "ບັນທືກ",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'NotoSansLaoUI-Regular',
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
        ));
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

  Widget makeDatePicker(label, date, index) {
    return Container(
      padding: EdgeInsets.only(top: 3, left: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        minWidth: double.infinity,
        color: Colors.white,
        height: 45,
        onPressed: () async {
          if (index == "0") {
            showDatePicker(
                    builder: (BuildContext context, Widget child) {
                      return Theme(
                        data: ThemeData.dark().copyWith(
                          colorScheme: ColorScheme.dark(
                            primary: Colors.red[800],
                            onPrimary: Colors.white,
                            surface: Colors.red[800],
                            onSurface: Colors.white,
                          ),
                          dialogBackgroundColor: Colors.black,
                        ),
                        child: child,
                      );
                    },
                    cancelText: 'ຍົກເລີກ',
                    confirmText: 'ຕົກລົງ',
                    helpText: 'ກະລຸນາເລືອກວັນທີການລາພັກ',
                    context: context,
                    selectableDayPredicate: (DateTime val) =>
                        val.weekday == 6 || val.weekday == 7 ? false : true,
                    initialDate: _startdateTime == null
                        ? DateTime.now()
                        : _startdateTime,
                    firstDate: DateTime.now().subtract(Duration(days: 1)),
                    lastDate: DateTime(2030))
                .then((date) {
              if (date == null) {
                setState(() {
                  _startdateTime = DateTime.now();
                });
              } else {
                setState(() {
                  _startdateTime = date;
                  _enddateTime = date;
                });
              }
            }).whenComplete(() {
              // _selectTime(context, "0");
            });
          } else {
            showDatePicker(
                    builder: (BuildContext context, Widget child) {
                      return Theme(
                        data: ThemeData.dark().copyWith(
                          colorScheme: ColorScheme.dark(
                            primary: Colors.red[800],
                            onPrimary: Colors.white,
                            surface: Colors.red[800],
                            onSurface: Colors.white,
                          ),
                          dialogBackgroundColor: Colors.black,
                        ),
                        child: child,
                      );
                    },
                    selectableDayPredicate: (DateTime val) =>
                        val.weekday == 6 || val.weekday == 7 ? false : true,
                    context: context,
                    initialDate:
                        _enddateTime == null ? DateTime.now() : _enddateTime,
                    firstDate: DateTime.now().subtract(Duration(days: 1)),
                    lastDate: DateTime(2030))
                .then((date) {
              var sYear = int.parse(DateFormat('yyyy').format(_startdateTime));
              var sMonth = int.parse(DateFormat('MM').format(_startdateTime));
              var sDay = int.parse(DateFormat('dd').format(_startdateTime));
              var eYear = int.parse(DateFormat('yyyy').format(date));
              var eMonth = int.parse(DateFormat('MM').format(date));
              var eDay = int.parse(DateFormat('dd').format(date));

              if (date == null) {
                setState(() {
                  _enddateTime = DateTime.now();
                });
              } else {
                if (sYear > eYear) {
                  makeAlert(
                      "ທ່ານເລືອກວັນທີບໍ່ຖືກຕ້ອງ \n ວັນທີສີ້ນສຸດຕ້ອງຫຼາຍກວ່າ (ປີ)");
                } else {
                  if (sMonth > eMonth) {
                    makeAlert(
                        "ທ່ານເລືອກວັນທີບໍ່ຖືກຕ້ອງ \n ວັນທີສີ້ນສຸດຕ້ອງຫຼາຍກວ່າ (ເດືອນ)");
                  } else {
                    if (sDay > eDay) {
                      makeAlert(
                          "ທ່ານເລືອກວັນທີບໍ່ຖືກຕ້ອງ \n ວັນທີສີ້ນສຸດຕ້ອງຫຼາຍກວ່າ (ວັນທີ)");
                    } else {
                      setState(() {
                        _enddateTime = date;
                      });
                    }
                  }
                }
              }
            }).whenComplete(() {
              // _selectTime(context, "1");
            });
          }
        },
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'NotoSansLaoUI-Regular',
                      color: Colors.black)),
              Divider(
                height: 2,
                color: Colors.red[800],
              ),
              Text(date,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                      color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeStartDateSelect(label) {
    return Container(
      padding: EdgeInsets.only(top: 3, left: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        minWidth: double.infinity,
        color: Colors.white,
        elevation: 0,
        height: 45,
        onPressed: () async {},
        splashColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'NotoSansLaoUI-Regular',
                      color: Colors.black)),
              Divider(
                height: 2,
              ),
              InkWell(
                onTap: () {
                  _selectTime(context, "0");
                },
                child: Container(
                  margin: EdgeInsets.only(top: 8),
                  width: _width / 1.7,
                  height: _height / 14,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: TextFormField(
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'NotoSansLaoUI-Regular',
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    onSaved: (String val) {
                      _setTime = val;
                    },
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: _timeController,
                    decoration: InputDecoration(
                        disabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.all(5)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeEndDateSelect(label) {
    return Container(
      padding: EdgeInsets.only(top: 3, left: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        minWidth: double.infinity,
        color: Colors.white,
        elevation: 0,
        height: 45,
        onPressed: () async {},
        splashColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'NotoSansLaoUI-Regular',
                      color: Colors.black)),
              Divider(
                height: 2,
              ),

              InkWell(
                onTap: () {
                  _selectTime(context, "1");
                },
                child: Container(
                  margin: EdgeInsets.only(top: 8),
                  width: _width / 1.7,
                  height: _height / 14,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: TextFormField(
                    style: TextStyle(
                        fontFamily: 'NotoSansLaoUI-Regular',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    onSaved: (String val) {
                      _setTime = val;
                    },
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: _endTimeController,
                    decoration: InputDecoration(
                        disabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        // labelText: 'Time',
                        contentPadding: EdgeInsets.all(5)),
                  ),
                ),
              ),
              // DropdownButton(
              //   style: TextStyle(fontSize: 15, color: Colors.black),
              //   value: _currentEndDate,
              //   items: _dropDownMenuEndDate,
              //   onChanged: changedDropDownEndDate,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, Icon icons}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 2.0,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: TextField(
          cursorHeight: 20,
          textAlign: TextAlign.center,
          cursorColor: Colors.red,
          controller: detailLeave,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              hintText: label,
              hintStyle: TextStyle(
                fontFamily: 'NotoSansLaoUI-Regular',
              ),
              prefixIcon: Container(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  margin: const EdgeInsets.only(right: 8.0),
                  decoration: BoxDecoration(
                      color: succ ? Colors.green : Colors.red[800],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                        topRight: Radius.circular(20.0),
                      )),
                  child: icons),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
        ),
      ),
    );
  }

  void makeSeccAlert() {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.TOPSLIDE, dismissOnTouchOutside: false,
        headerAnimationLoop: false,
        title: 'ສຳເລັັດ',
        desc: "ການຂໍລາພັກຂອງທ່ານສຳເລັດ ລໍຖ້າການອະນຸມັດ",
        btnOkOnPress: () {
          pr.hide();
          FocusScope.of(context).unfocus();
          setState(() {
            succ = true;
          });
        },
        btnOkIcon: Icons.check,
        btnOkColor: Colors.greenAccent[600])
      ..show();
  }
}
