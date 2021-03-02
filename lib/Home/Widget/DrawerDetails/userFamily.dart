import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltcmainapp/Home/Controller/drawerService.dart';
import 'package:ltcmainapp/Home/Models/drawerModel.dart';

class UserFamily extends StatefulWidget {
  @override
  _UserFamilyState createState() => _UserFamilyState();
}

class _UserFamilyState extends State<UserFamily>
    with SingleTickerProviderStateMixin {
  Animation<double> scaleAnimation;
  AnimationController controller;
  DrawerService _drawerService = new DrawerService();
  List<Family> _family = List<Family>();

  void _populateNewsArticles() {
    _drawerService.getUserFamily().then((newsLeave) => {
          setState(() => {_family = newsLeave})
        });
  }

  @override
  void initState() {
    _populateNewsArticles();
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
                                        "ຂໍ້ມູນພໍ່ ແລະ ແມ່",
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
                          child: ListView.builder(
                              itemCount: _family.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    _dady(context),
                                    _mumy(context),
                                  ],
                                );
                              })),
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

  Container _dady(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      height: 240.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 40.0, left: 10.0, right: 10.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    _family[0].dadyName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text(
                              DateFormat("dd/MM/yy").format(DateTime.parse(
                                _family[0].dadyBirth,
                              )),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("ວ/ດ/ປ ເກີດ".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'NotoSansLaoUI-Regular',
                                )),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              _family[0].dadyOccupation,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NotoSansLaoUI-Regular',
                              ),
                            ),
                            subtitle: Text("ອາຊີບ".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'NotoSansLaoUI-Regular',
                                )),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              _family[0].dadyStatus,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("ສະຖານະ".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'NotoSansLaoUI-Regular',
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(
                      "https://media.istockphoto.com/vectors/happy-parents-cute-cartoon-concept-illustration-of-a-couple-holding-vector-id1136773847?b=1&k=6&m=1136773847&s=612x612&w=0&h=rDI8aOAk_H01FpplZupINUgjnLmuuiFnTAaTGnvy24Y="),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _mumy(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      height: 240.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 40.0, left: 10.0, right: 10.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    _family[0].mumyName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text(
                              DateFormat("dd/MM/yy").format(DateTime.parse(
                                _family[0].mumyBirth,
                              )),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("ວ/ດ/ປ ເກີດ".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'NotoSansLaoUI-Regular',
                                )),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              _family[0].mumyOccupation,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NotoSansLaoUI-Regular',
                              ),
                            ),
                            subtitle: Text("ອາຊີບ".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'NotoSansLaoUI-Regular',
                                )),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              _family[0].mumyStatus,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("ສະຖານະ".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'NotoSansLaoUI-Regular',
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(
                      "https://media.istockphoto.com/vectors/happy-parents-cute-cartoon-concept-illustration-of-a-couple-holding-vector-id1136773847?b=1&k=6&m=1136773847&s=612x612&w=0&h=rDI8aOAk_H01FpplZupINUgjnLmuuiFnTAaTGnvy24Y="),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
