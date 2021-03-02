import 'package:flutter/material.dart';
import 'package:ltcmainapp/Home/Controller/drawerService.dart';
import 'package:ltcmainapp/Home/Models/homeModel.dart';

class UserDetailPage extends StatefulWidget {
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage>
    with SingleTickerProviderStateMixin {
  Animation<double> scaleAnimation;
  AnimationController controller;
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
  void getData() {
    _drawerService.getUserData().then((value) {
      setState(() {
        laoName = value.fullNameLa;
        enName = value.fullNameEn;
        dateOfbirth = value.dateBirth;
        empType = value.empTypeName;
        tel = value.tel;
        dateWork = value.dateWork;
        mail = value.email;
        position = value.positionName;
        section = value.sectionName;
      });
    });
  }

  @override
  void initState() {
    getData();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var itemData = [
      {"title": "ຊື່ ແລະ ນາມສະກຸນ", "subtitle": laoName},
      {"title": "ວັນເດືອນປີເກີດ", "subtitle": dateOfbirth},
      {"title": "ເບີໂທ", "subtitle": tel},
      {"title": "Email", "subtitle": mail},
      {"title": "ວັນທີ່ເລີ່ມວຽກ", "subtitle": dateWork},
      {"title": "ຕຳແໜ່ງ", "subtitle": position},
      {"title": "ສູນ", "subtitle": section},
      {"title": "ປະເພດພະນັກງານ", "subtitle": empType},
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 1.2,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 15,
                            color: Colors.red[800],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "ຂໍ້ມູນມູນສ່ວນຕົວ",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                               
                                          fontFamily: 'NotoSansLaoUI-Regular',
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: itemData.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 0,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                      width: 8,
                                      decoration: BoxDecoration(
                                          color: Colors.red[800],
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8))),
                                      padding: EdgeInsets.only(
                                          left: 0,
                                          top: 10,
                                          bottom: 70,
                                          right: 20),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            itemData[index]['title'],
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily:
                                                  'NotoSansLaoUI-Regular',
                                            ),
                                          ),
                                          Text(
                                            itemData[index]['subtitle'],
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontFamily:
                                                  'NotoSansLaoUI-Regular',
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget makeListitle(String title, String subtitle, Widget icon) {
    return ListTile(
      contentPadding: EdgeInsets.only(bottom: 0, top: 0),
      leading: icon,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.grey,
          fontFamily: 'NotoSansLaoUI-Regular',
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'NotoSansLaoUI-Regular',
        ),
      ),
    );
  }
}
