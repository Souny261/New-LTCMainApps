import 'package:flutter/material.dart';
import 'package:ltcmainapp/Home/Controller/drawerService.dart';
import 'package:ltcmainapp/Home/Models/drawerModel.dart';

class UserEducationPage extends StatefulWidget {
  @override
  _UserEducationPageState createState() => _UserEducationPageState();
}

class _UserEducationPageState extends State<UserEducationPage>
    with SingleTickerProviderStateMixin {
  Animation<double> scaleAnimation;
  AnimationController controller;
  DrawerService _drawerService = new DrawerService();
  List<UserEducation1> userEducation = List<UserEducation1>();

  void _populateNewsArticles() {
    _drawerService.getUserEducation().then((newsLeave) => {
          setState(() => {userEducation = newsLeave})
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
                                        Icons.school,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(
                                          "ຂໍ້ມູນການສືກສາ",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                    
                                            fontFamily: 'NotoSansLaoUI-Regular',
                                          ),
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
                            itemCount: userEducation.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 0,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
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
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Icon(
                                                  Icons.date_range,
                                                  color: Colors.red[800],
                                                  size: 15,
                                                ),
                                              ),
                                              Text(
                                                userEducation[index]
                                                        .startStudy
                                                        .toString() +
                                                    ' ຫາ ' +
                                                    userEducation[index]
                                                        .endStudy
                                                        .toString(),
                                                style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      'NotoSansLaoUI-Regular',
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Icon(
                                                  Icons.school,
                                                  color: Colors.red[800],
                                                  size: 15,
                                                ),
                                              ),
                                              Text(
                                                userEducation[index].schoolName,
                                                style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontFamily:
                                                      'NotoSansLaoUI-Regular',
                                                ),
                                              ),
                                            ],
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
}
