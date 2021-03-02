import 'package:flutter/material.dart';
import 'package:ltcmainapp/Home/Controller/drawerService.dart';
import 'package:ltcmainapp/Home/Models/drawerModel.dart';

class CertifercatePage extends StatefulWidget {
  @override
  _CertifercatePageState createState() => _CertifercatePageState();
}

class _CertifercatePageState extends State<CertifercatePage>
    with SingleTickerProviderStateMixin {
  Animation<double> scaleAnimation;
  AnimationController controller;
  DrawerService _drawerService = new DrawerService();
  List<Certificate> _trining = List<Certificate>();
  String dateOrg = "";
  void _populateNewsArticles() {
    _drawerService.getUserCerti().then((newsLeave) => {
          setState(() => {_trining = newsLeave})
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
                        child: _trining.length.toString() == "0"
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cancel,
                                    size: 100,
                                    color: Colors.red[800],
                                  ),
                                  Text(
                                    "ບໍ່ພົບຂໍ້ມູນ",
                                    style: TextStyle(
                                        fontFamily: 'NotoSansLaoUI-Regular',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            : ListView.builder(
                                itemCount: _trining.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 0,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              9,
                                          width: 8,
                                          decoration: BoxDecoration(
                                              color: Colors.red[800],
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(8))),
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: Icon(
                                                      Icons.date_range,
                                                      color: Colors.red[800],
                                                      size: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    _trining[index]
                                                            .hisPraiseDate
                                                            .toString() +
                                                        "|" +
                                                        _trining[index]
                                                            .hisPraiseDetail,
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'NotoSansLaoUI-Regular',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: Icon(
                                                      Icons.work,
                                                      color: Colors.red[800],
                                                      size: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    _trining[index]
                                                        .hisPraiseTitle,
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          'NotoSansLaoUI-Regular',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: Icon(
                                                      Icons.location_on,
                                                      color: Colors.red[800],
                                                      size: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    _trining[index]
                                                        .praiseTypeName,
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
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
