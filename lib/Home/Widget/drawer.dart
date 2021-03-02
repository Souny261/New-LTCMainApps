import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ltcmainapp/Controller/sharedata.dart';
import 'package:ltcmainapp/Home/Controller/drawerService.dart';
import 'package:ltcmainapp/Home/Models/drawerModel.dart';
import 'package:ltcmainapp/Home/Widget/DrawerDetails/Certificate.dart';
import 'package:ltcmainapp/Home/Widget/DrawerDetails/child.dart';
import 'package:ltcmainapp/Home/Widget/DrawerDetails/resetID.dart';
import 'package:ltcmainapp/Home/Widget/DrawerDetails/specialGroup.dart';
import 'package:ltcmainapp/Home/Widget/DrawerDetails/trianing.dart';
import 'package:ltcmainapp/Home/Widget/DrawerDetails/userEducation.dart';
import 'package:ltcmainapp/Home/Widget/DrawerDetails/userFamily.dart';
import 'package:ltcmainapp/Home/Widget/DrawerDetails/workHistory.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'DrawerDetails/userDetail.dart';
import 'package:ltcmainapp/Leave/Controllers/getImageEmployee.dart'
    as ImageProfile;

class NavDrawer extends StatefulWidget {
  String imageUser, fullname, empID, apiToken;
  NavDrawer(this.fullname, this.imageUser, this.empID, this.apiToken);
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final ShareData shareData = ShareData();
  DrawerService _drawerService = new DrawerService();
  String laoName = "",
      enName = "",
      dateOfbirth = "",
      empType = "",
      tel = "",
      dateWork = "",
      mail = "",
      position = "",
      section = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3.5,
            width: double.infinity,
            child: DrawerHeader(
              child: Column(
                children: [
                  Material(
                    elevation: 5.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      radius: 45.0,
                      child: ImageProfile.ImageProfile(
                        apiToken: widget.apiToken,
                        empID: widget.empID,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  Text(
                    widget.fullname,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.red[800],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => UserDetailPage(),
                    );
                  },
                  title: Text(
                    "ຂໍ້ມູນສ່ວນຕົວ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                  leading: Icon(Icons.person, color: Colors.red[800]),

                  //trailing: Icon(Icons.ac_unit),
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => UserEducationPage(),
                    );
                  },
                  title: Text(
                    "ການສືກສາ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                  leading: Icon(Icons.school, color: Colors.red[800]),
                ),
                ExpansionTile(
                  title: Text(
                    "ຄອບຄົວ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                  leading: Icon(Icons.people, color: Colors.red[800]),
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => UserFamily(),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50, bottom: 5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_right,
                              color: Colors.red[800],
                            ),
                            Text(
                              "ຂໍ້ມູນພໍ່ ແລະ ແມ່",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NotoSansLaoUI-Regular',
                              ),
                            ),
                            SizedBox()
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => ChildPages(),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50, bottom: 8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_right,
                              color: Colors.red[800],
                            ),
                            Text(
                              "ຂໍ້ມູນລູກ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NotoSansLaoUI-Regular',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  //trailing: Icon(Icons.ac_unit),
                ),
                /*   ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => SpecialGroupPages(),
                    );
                  },
                  title: Text(
                    "ການຈັດຕັ້ງ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                  leading: Icon(
                    Icons.group_work,
                    color: Colors.red[800],
                  ),

                  //trailing: Icon(Icons.ac_unit),
                ), */
                ListTile(
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => WorkingHistory(),
                    );
                  },
                  title: Text(
                    "ປະຫວັດການເຮັດວຽກ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                  leading: Icon(Icons.work, color: Colors.red[800]),

                  //trailing: Icon(Icons.ac_unit),
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => TrianingPage(),
                    );
                  },
                  title: Text(
                    "ການຝືກອົບຮົມ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                  leading: Icon(Icons.edit, color: Colors.red[800]),
                  //trailing: Icon(Icons.ac_unit),
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => CertifercatePage(),
                    );
                  },
                  title: Text(
                    "ໃບຍ້ອງຍໍ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                  leading: Icon(Icons.credit_card, color: Colors.red[800]),
                  //trailing: Icon(Icons.ac_unit),
                ),
                Divider(
                  color: Colors.red[800],
                ),
                ListTile(
                  onTap: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.INFO,
                      animType: AnimType.SCALE,
                      title: "ຕິດຕໍ່ Admin",
                      desc: '',
                      btnOkIcon: Icons.call, dismissOnTouchOutside: false,
                      btnOkText: 'ໂທ',
                      btnCancelText: 'ປິດ',
                      btnCancelIcon: Icons.cancel,
                      btnOkOnPress: () {
                        launch("tel://02059959959");
                      },
                      btnCancelOnPress: () {},
                    )..show();
                  },
                  title: Text(
                    "ຕິດຕໍ່ Admin",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                  leading: Icon(
                    Icons.call,
                    color: Colors.green,
                  ),
                  //trailing: Icon(Icons.ac_unit),
                ),
                ListTile(
                  title: Text(
                    "ຄຳຄິດເຫັນ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                  leading: Icon(
                    Icons.comment,
                    color: Colors.green,
                  ),
                  //trailing: Icon(Icons.ac_unit),
                ),
                widget.empID == "3671" || widget.empID == "2106"
                    ? ListTile(
                        onTap: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => ResetID(),
                          );
                        },
                        title: Text(
                          "Reset Password",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'NotoSansLaoUI-Regular',
                          ),
                        ),
                        leading: Icon(
                          Icons.vpn_key,
                          color: Colors.green,
                        ),
                        //trailing: Icon(Icons.ac_unit),
                      )
                    : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget makeSubText(String title, String detail) {
    return Text(
      "- $title: $detail",
      style: TextStyle(
        fontSize: 15,
        fontFamily: 'NotoSansLaoUI-Regular',
      ),
    );
  }
}
