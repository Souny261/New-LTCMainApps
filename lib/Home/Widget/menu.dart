import 'package:flutter/material.dart';
import 'package:ltcmainapp/Leave/leaveHomeNormalUsers.dart';
import 'package:ltcmainapp/LtcEvent/Controller/EventModel.dart';
import 'package:ltcmainapp/Rountes/router.dart';

class Menu extends StatefulWidget {
  String empID, apiToken, leaveWaitApp;
  List<EventModel> evenList;
  List<EventModel> eventModel;
  Menu(
      {this.apiToken,
      this.empID,
      this.leaveWaitApp,
      this.evenList,
      this.eventModel});
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  RouterApp _router = new RouterApp();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        _router.homeFingerPrint(widget.empID, widget.apiToken));
                  },
                  child: makeBottom(image: "assets/menu/history.png"),
                ),
                GestureDetector(
                  onTap: () async {
                    // Navigator.of(context).push(_router.leaveRouter());
                    if (widget.leaveWaitApp == "false") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => LeaveHomePageNormalUsers()));
                    } else {
                      Navigator.of(context).push(_router.leaveRouter());
                    }
                  },
                  child: makeBottom(image: "assets/menu/leave11.png"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(_router.eventMeettingRouter(
                        evenList: widget.evenList,
                        eventNew: widget.eventModel));
                  },
                  child: makeBottom(image: "assets/menu/event1.png"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        _router.homeContact(widget.empID, widget.apiToken));

                    /* Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeContact(
                          empID: widget.empID,
                          apiToken: widget.apiToken,
                        ),
                      ),
                    );*/
                  },
                  child: makeBottom(image: "assets/menu/call1.png"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget makeBottom({image}) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      height: MediaQuery.of(context).size.height / 11,
      padding: EdgeInsets.all(5),
      //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: Colors.red[800], width: 2),
      ),
      child: Image.asset(image),
    );
  }
}
