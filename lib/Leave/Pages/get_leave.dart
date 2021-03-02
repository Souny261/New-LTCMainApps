// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:ltcmainapp/Leave/Controllers/leaveService.dart';
// import 'package:date_format/date_format.dart';
// import 'package:ltcmainapp/Leave/Models/leaveModels.dart';
// import 'package:progress_dialog/progress_dialog.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class GetLeavePage extends StatefulWidget {
//   @override
//   _GetLeavePageState createState() => _GetLeavePageState();
// }

// class _GetLeavePageState extends State<GetLeavePage> {
//   double _height;
//   double _width;
//   ProgressDialog pr;
//   List _leaveType = [
//     "ລາກິດທຸລະສ່ວນຕົວ (ຕັດເງິນ)",
//     "ລາເຈັບ (ຕັດເງິນ)",
//     "ລາກິດທຸລະຕ່າງປະເທດ (ຕັດເງິນ)",
//     "ລາເກີດລູກ",
//     "ພັກປະຈຳປີ",
//     "ລາປ່ວຍດ່ວນ"
//   ];
//   final detailLeave = new TextEditingController();
//   String _setTime, _setDate;

//   DateTime _startdateTime;
//   DateTime _enddateTime;

//   List<DropdownMenuItem<String>> _dropDownMenuItems;

//   String _currentCity;
//   String leaveId;
//   final LeaveService leave = LeaveService();
//   String _hour, _minute, _time;
//   TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
//   TextEditingController _timeController = TextEditingController();
//   TextEditingController _endTimeController = TextEditingController();

//   List<EmpApproveLeave> approved;
//   List<LeaveForm> leaveForm;

//   void setData() {
//     leave.getLeaveForm().then((value) {
//       setState(() {
//         approved = value.approved;
//         leaveForm = value.leaveForm;
//       });
//     });
//   }

//   Future<Null> _selectTime(BuildContext context, typeSelected) async {
//     final TimeOfDay picked = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//     );
//     if (picked != null) if (typeSelected == "0") {
//       setState(() {
//         selectedTime = picked;
//         _hour = selectedTime.hour.toString();
//         _minute = selectedTime.minute.toString();
//         _time = _hour + ' : ' + _minute;
//         _timeController.text = _time;
//         _timeController.text = formatDate(
//             DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
//             [HH, ':', nn, ' ໂມງ']).toString();
//       });
//     } else {
//       setState(() {
//         selectedTime = picked;
//         _hour = selectedTime.hour.toString();
//         _minute = selectedTime.minute.toString();
//         _time = _hour + ' : ' + _minute;
//         _endTimeController.text = _time;
//         _endTimeController.text = formatDate(
//             DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
//             [HH, ':', nn, ' ໂມງ']).toString();
//       });
//     }
//   }

//   String approvePerson, approvePersonID, approvePersonIDNo;

//   void getData() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     String empID = pref.getString("empID");
//     leave.getNextApproveLeave(empID).then((value) {
//       setState(() {
//         approvePersonID = value[0].employeeID.toString();
//         approvePerson = value[0].fullName;
//         approvePersonIDNo = value[0].employeeIDNo;
//       });
//     });
//   }

//   @override
//   void initState() {
//     setData();
//     _dropDownMenuItems = getDropDownMenuItems();
//     _currentCity = _dropDownMenuItems[0].value;
//     leaveId = "2";
//     getData();
//     _timeController.text = formatDate(
//         DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
//         [HH, ':', nn, ' ໂມງ']).toString();
//     _endTimeController.text = formatDate(
//         DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
//         [HH, ':', nn, ' ໂມງ']).toString();
//     _startdateTime = DateTime.now();
//     _enddateTime = DateTime.now();
//     super.initState();
//   }

//   List<DropdownMenuItem<String>> getDropDownMenuItems() {
//     List<DropdownMenuItem<String>> items = new List();
//     for (String city in _leaveType) {
//       items.add(new DropdownMenuItem(
//           value: city,
//           child: new Text(
//             city,
//             style: TextStyle(
//                 fontFamily: 'NotoSansLaoUI-Regular',
//                 fontSize: 18,
//                 fontStyle: FontStyle.italic,
//                 fontWeight: FontWeight.bold),
//           )));
//     }
//     return items;
//   }

//   @override
//   Widget build(BuildContext context) {
//     pr = new ProgressDialog(context,
//         type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
//     pr.style(
//         borderRadius: 10.0,
//         backgroundColor: Colors.white,
//         progressWidget: Image.asset(
//           "assets/r.gif",
//           height: 100.0,
//           width: 100.0,
//         ),
//         elevation: 10.0,
//         insetAnimCurve: Curves.easeInOut,
//         progress: 0.0,
//         maxProgress: 100.0,
//         progressTextStyle: TextStyle(
//             color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
//         messageTextStyle: TextStyle(
//             color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
//     double hieght = MediaQuery.of(context).size.height;
//     _height = MediaQuery.of(context).size.height;
//     _width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Stack(
//         children: [
//           Center(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 50),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "ການຂໍລາພັກ",
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontFamily: 'NotoSansLaoUI-Regular',
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "ເພີ້ມຂໍ້ມູນການລາພັກຂອງທ່ານ",
//                           style: TextStyle(
//                               fontSize: 15,
//                               fontFamily: 'NotoSansLaoUI-Regular',
//                               color: Colors.grey,
//                               fontStyle: FontStyle.italic),
//                         ),
//                       ],
//                     ),
//                     Divider(),
//                     makeComboBox(),
//                     makeComboBoxApprove(),
//                     Row(
//                       children: [
//                         Expanded(
//                             child: makeDatePicker(
//                                 'ວັນທີເລີ່ມຕົ້ນ',
//                                 _startdateTime == null
//                                     ? DateFormat('dd/MM/yyyy')
//                                         .format(DateTime.now())
//                                     : DateFormat('dd/MM/yyyy')
//                                         .format(_startdateTime),
//                                 "0")),
//                         Expanded(
//                             child: makeDatePicker(
//                                 'ວັນທີສິ້ນສຸດ',
//                                 _enddateTime == null
//                                     ? DateFormat('dd/MM/yyyy')
//                                         .format(DateTime.now())
//                                     : DateFormat('dd/MM/yyyy')
//                                         .format(_enddateTime),
//                                 "1")),
//                       ],
//                     ),
//                     makeTotalDay(),
//                     Row(
//                       children: [
//                         Expanded(child: makeStartDateSelect('ວັນທີເລີ່ມຕົ້ນ')),
//                         Expanded(child: makeEndDateSelect('ວັນທີສິ້ນສຸດ')),
//                       ],
//                     ),
//                     makeInput(
//                         label: "ເຫດຜົນການລາພັກ",
//                         icons: Icon(Icons.edit, color: Colors.white)),
//                     makeButton()
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(top: 20),
//             child: IconButton(
//               icon: Icon(
//                 Icons.cancel_outlined,
//                 size: 35,
//                 color: Colors.red[800],
//               ),
//               onPressed: () {
//                 print(leaveForm[0].leaveName);
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget makeInput({label, Icon icons}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 5),
//       child: Material(
//         elevation: 2.0,
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//         child: TextField(
//           cursorHeight: 20,
//           textAlign: TextAlign.center,
//           cursorColor: Colors.red,
//           controller: detailLeave,
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           keyboardType: TextInputType.text,
//           decoration: InputDecoration(
//               hintText: label,
//               hintStyle: TextStyle(
//                 fontFamily: 'NotoSansLaoUI-Regular',
//               ),
//               prefixIcon: Container(
//                   padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
//                   margin: const EdgeInsets.only(right: 8.0),
//                   decoration: BoxDecoration(
//                       color: Colors.red[700],
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(10.0),
//                         bottomLeft: Radius.circular(10.0),
//                         topRight: Radius.circular(20.0),
//                       )),
//                   child: icons),
//               border: InputBorder.none,
//               contentPadding:
//                   EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
//         ),
//       ),
//     );
//   }

//   Widget makeButton() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 13),
//       child: Container(
//         padding: EdgeInsets.only(top: 3, left: 3),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: MaterialButton(
//           minWidth: double.infinity,
//           color: Colors.red[800],
//           height: 45,
//           onPressed: () async {
//             var sdate = DateFormat('dd').format(_startdateTime);
//             var edate = DateFormat('dd').format(_enddateTime);
//             String string = _timeController.text;
//             String string1 = _endTimeController.text;
//             var startTime = string.substring(0, string.length - 7);
//             var endTime = string1.substring(0, string1.length - 7);
//             int sDateInt = int.parse(sdate);
//             int eDateInt = int.parse(edate);
//             int startTimeInt = int.parse(startTime);
//             int endTimeInt = int.parse(endTime);
//             if (startTimeInt > endTimeInt || startTimeInt == endTimeInt) {
//               makeAlert(
//                   'ທ່ານເລືອກ ( ເວລາ ) ບໍ່ຖືກຕ້ອງ! \n ເວລາເລີ່ມຕົ້ນຕ້ອງໜ້ອຍກ່ວາເລວາສີ້ນສຸດ');
//             } else if (startTimeInt < 8 || endTimeInt > 17) {
//               makeAlert(
//                   'ທ່ານເລືອກ ( ເວລາ ) ບໍ່ຖືກຕ້ອງ! \n ທ່ານສາມາດລາໄດ້ແຕ່ 8:00 ໂມງ ຫາ 17:00 ໂມງເທົ່ານັ້ນ');
//             } else if (sDateInt > eDateInt) {
//               makeAlert(
//                   'ທ່ານເລືອກ ວັນທີບໍ່ຖືກຕ້ອງ ! \n ວັນທີເລີ່ມຕົ້ນຕ້ອງໜ້ອຍກວ່າວັນທີ່ສີ້ນສຸດ');
//             } else if (detailLeave.text.isEmpty) {
//               makeAlert('ກະລຸນາປ້ອນເຫດຜົນການລາພັກຂອງທ່ານ');
//             } else {
//               submitLeave();
//             }
//           },
//           elevation: 5,
//           splashColor: Colors.white,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           child: Text("ຢືນຍັນ",
//               style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'NotoSansLaoUI-Regular',
//                   color: Colors.white)),
//         ),
//       ),
//     );
//   }

//   void changedDropDownItem(String selectedCity) {
//     if (selectedCity == "ລາກິດທຸລະສ່ວນຕົວ (ຕັດເງິນ)") {
//       setState(() {
//         _currentCity = selectedCity;
//         leaveId = "2";
//       });
//     } else if (selectedCity == "ລາເຈັບ (ຕັດເງິນ)") {
//       setState(() {
//         _currentCity = selectedCity;
//         leaveId = "1";
//       });
//     } else if (selectedCity == "ລາກິດທຸລະຕ່າງປະເທດ (ຕັດເງິນ)") {
//       setState(() {
//         _currentCity = selectedCity;
//         leaveId = "5";
//       });
//     } else if (selectedCity == "ລາເກີດລູກ") {
//       setState(() {
//         _currentCity = selectedCity;
//         leaveId = "3";
//       });
//     } else if (selectedCity == "ພັກປະຈຳປີ") {
//       setState(() {
//         _currentCity = selectedCity;
//         leaveId = "4";
//       });
//     } else if (selectedCity == "ລາປ່ວຍດ່ວນ") {
//       setState(() {
//         _currentCity = selectedCity;
//         leaveId = "6";
//       });
//     }
//   }

//   Widget getApprovePerson() {
//     return Text(
//       approvePerson == null ? "ກະລຸນາລໍຖ້າ..." : approvePerson,
//       textAlign: TextAlign.start,
//       style: TextStyle(
//         fontSize: 18,
//         color: Colors.black,
//         fontWeight: FontWeight.bold,
//         fontStyle: FontStyle.italic,
//         fontFamily: 'NotoSansLaoUI-Regular',
//       ),
//     );
//   }

//   Widget makeComboBox({label, Icon icons}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text("ປະເພດຂໍລາພັກ:",
//                 style: TextStyle(
//                     fontSize: 15,
//                     fontFamily: 'NotoSansLaoUI-Regular',
//                     color: Colors.black)),
//           ),
//           Material(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             child: new DropdownButton(
//               style: TextStyle(fontSize: 15, color: Colors.black),
//               value: _currentCity,
//               items: _dropDownMenuItems,
//               onChanged: changedDropDownItem,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget makeComboBoxApprove({label, Icon icons}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//       child: Row(
//         children: [
//           Text("ຜູ້ໃຫ້ອະນຸມັດ:",
//               style: TextStyle(
//                   fontSize: 15,
//                   fontFamily: 'NotoSansLaoUI-Regular',
//                   color: Colors.black)),
//           SizedBox(
//             width: 20,
//           ),
//           Material(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             color: Colors.white,
//             child: getApprovePerson(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget makeDatePicker(label, date, index) {
//     return Container(
//       padding: EdgeInsets.only(top: 3, left: 3),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: MaterialButton(
//         minWidth: double.infinity,
//         color: Colors.white,
//         height: 45,
//         onPressed: () async {
//           if (index == "0") {
//             showDatePicker(
//                     context: context,
//                     initialDate: _startdateTime == null
//                         ? DateTime.now()
//                         : _startdateTime,
//                     firstDate: DateTime(2020),
//                     lastDate: DateTime(2030))
//                 .then((date) {
//               if (date == null) {
//                 setState(() {
//                   _startdateTime = DateTime.now();
//                 });
//               } else {
//                 setState(() {
//                   _startdateTime = date;
//                 });
//               }
//             }).whenComplete(() {
//               _selectTime(context, "0");
//             });
//           } else {
//             showDatePicker(
//                     context: context,
//                     initialDate:
//                         _enddateTime == null ? DateTime.now() : _enddateTime,
//                     firstDate: DateTime(2020),
//                     lastDate: DateTime(2030))
//                 .then((date) {
//               if (date == null) {
//                 setState(() {
//                   _enddateTime = DateTime.now();
//                 });
//               } else {
//                 setState(() {
//                   _enddateTime = date;
//                 });
//               }
//             }).whenComplete(() {
//               _selectTime(context, "1");
//             });
//           }
//         },
//         elevation: 0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Text(label,
//                   style: TextStyle(
//                       fontSize: 15,
//                       fontFamily: 'NotoSansLaoUI-Regular',
//                       color: Colors.black)),
//               Divider(
//                 height: 2,
//               ),
//               Text(date,
//                   style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'NotoSansLaoUI-Regular',
//                       color: Colors.black)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget makeTotalDay() {
//     var sdate = DateFormat('yyyy-MM-dd').format(_startdateTime);
//     var edate = DateFormat('yyyy-MM-dd').format(_enddateTime);
//     String string = _timeController.text;
//     String string1 = _endTimeController.text;
//     var sTime = string.substring(0, string.length - 4);
//     var eTime = string1.substring(0, string1.length - 4);
//     //value
//     var startDateTime = sdate + ' ' + sTime + ':00';
//     var endDateTime = edate + ' ' + eTime + ':00';
//     DateTime date1 = DateTime.parse(startDateTime);
//     DateTime date2 = DateTime.parse(endDateTime);
//     final days = date2.difference(date1).inDays + 1;
//     return Container(
//       padding: EdgeInsets.only(top: 3, left: 3),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: MaterialButton(
//         minWidth: double.infinity,
//         color: Colors.white,
//         height: 45,
//         elevation: 0,
//         onPressed: () async {},
//         splashColor: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         child: Text(days.toString() + " ມື້",
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.red[800],
//               fontFamily: 'NotoSansLaoUI-Regular',
//             )),
//       ),
//     );
//   }

//   Widget makeStartDateSelect(label) {
//     return Container(
//       padding: EdgeInsets.only(top: 3, left: 3),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: MaterialButton(
//         minWidth: double.infinity,
//         color: Colors.white,
//         elevation: 0,
//         height: 45,
//         onPressed: () async {},
//         splashColor: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Text(label,
//                   style: TextStyle(
//                       fontSize: 15,
//                       fontFamily: 'NotoSansLaoUI-Regular',
//                       color: Colors.black)),
//               Divider(
//                 height: 2,
//               ),

//               InkWell(
//                 onTap: () {
//                   _selectTime(context, "0");
//                 },
//                 child: Container(
//                   margin: EdgeInsets.only(top: 8),
//                   width: _width / 1.7,
//                   height: _height / 9,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(color: Colors.grey[200]),
//                   child: TextFormField(
//                     style: TextStyle(
//                       fontSize: 25,
//                       fontFamily: 'NotoSansLaoUI-Regular',
//                     ),
//                     textAlign: TextAlign.center,
//                     onSaved: (String val) {
//                       _setTime = val;
//                     },
//                     enabled: false,
//                     keyboardType: TextInputType.text,
//                     controller: _timeController,
//                     decoration: InputDecoration(
//                         disabledBorder:
//                             UnderlineInputBorder(borderSide: BorderSide.none),
//                         // labelText: 'Time',
//                         contentPadding: EdgeInsets.all(5)),
//                   ),
//                 ),
//               ),

//               // DropdownButton(
//               //   style: TextStyle(fontSize: 15, color: Colors.black),
//               //   value: _currentStartDate,
//               //   items: _dropDownMenuStartDate,
//               //   onChanged: changedDropDownStartDate,
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget makeEndDateSelect(label) {
//     return Container(
//       padding: EdgeInsets.only(top: 3, left: 3),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: MaterialButton(
//         minWidth: double.infinity,
//         color: Colors.white,
//         elevation: 0,
//         height: 45,
//         onPressed: () async {},
//         splashColor: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Text(label,
//                   style: TextStyle(
//                       fontSize: 15,
//                       fontFamily: 'NotoSansLaoUI-Regular',
//                       color: Colors.black)),
//               Divider(
//                 height: 2,
//               ),

//               InkWell(
//                 onTap: () {
//                   _selectTime(context, "1");
//                 },
//                 child: Container(
//                   margin: EdgeInsets.only(top: 8),
//                   width: _width / 1.7,
//                   height: _height / 9,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(color: Colors.grey[200]),
//                   child: TextFormField(
//                     style: TextStyle(
//                         fontFamily: 'NotoSansLaoUI-Regular', fontSize: 25),
//                     textAlign: TextAlign.center,
//                     onSaved: (String val) {
//                       _setTime = val;
//                     },
//                     enabled: false,
//                     keyboardType: TextInputType.text,
//                     controller: _endTimeController,
//                     decoration: InputDecoration(
//                         disabledBorder:
//                             UnderlineInputBorder(borderSide: BorderSide.none),
//                         // labelText: 'Time',
//                         contentPadding: EdgeInsets.all(5)),
//                   ),
//                 ),
//               ),
//               // DropdownButton(
//               //   style: TextStyle(fontSize: 15, color: Colors.black),
//               //   value: _currentEndDate,
//               //   items: _dropDownMenuEndDate,
//               //   onChanged: changedDropDownEndDate,
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void makeAlert(title) {
//     AwesomeDialog(
//         context: context,
//         dialogType: DialogType.ERROR,
//         animType: AnimType.TOPSLIDE,
//         headerAnimationLoop: false,
//         title: 'ແຈ້ງເຕືອນ',
//         desc: title,
//         btnOkOnPress: () {
//           FocusScope.of(context).unfocus();
//         },
//         btnOkIcon: Icons.cancel,
//         btnOkColor: Colors.red[800])
//       ..show();
//   }

//   void makeSeccAlert() {
//     AwesomeDialog(
//         context: context,
//         dialogType: DialogType.SUCCES,
//         animType: AnimType.TOPSLIDE,
//         headerAnimationLoop: false,
//         title: 'ສຳເລັັດ',
//         desc: "ການຂໍລາພັກຂອງທ່ານສຳເລັດ ລໍຖ້າການອະນຸມັດ",
//         btnOkOnPress: () {
//           FocusScope.of(context).unfocus();
//           Navigator.pop(context);
//         },
//         btnOkIcon: Icons.check,
//         btnOkColor: Colors.greenAccent[600])
//       ..show();
//   }



// }
