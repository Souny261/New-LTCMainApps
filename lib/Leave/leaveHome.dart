import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ltcmainapp/Controller/provider.dart';
import 'package:ltcmainapp/Leave/Controllers/leaveService.dart';
import 'package:ltcmainapp/Leave/Pages/leaveHistory.dart';
import 'package:ltcmainapp/Leave/Pages/leaveType.dart';
import 'package:ltcmainapp/Leave/Widgets/bottomSheet.dart';
import 'package:ltcmainapp/Rountes/router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'Pages/leaveWaitApprove.dart';

class LeaveHomePage extends StatefulWidget {
  @override
  _LeaveHomePageState createState() => _LeaveHomePageState();
}

class _LeaveHomePageState extends State<LeaveHomePage>
    with TickerProviderStateMixin {
  RouterApp _router = new RouterApp();
  TabController tabController;
  ScrollController scrollViewController;
  Animation<double> _animation;
  AnimationController _animationController;
  LeaveService service = new LeaveService();
  @override
  void initState() {
    super.initState();
    // String provider = context.watch<Counter>().count;
    scrollViewController = ScrollController();
    tabController = TabController(vsync: this, length: 2);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );
//easeInOut
    final curvedAnimation =
        CurvedAnimation(curve: Curves.bounceIn, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  void dispose() {
    super.dispose();
    scrollViewController.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
          physics: NeverScrollableScrollPhysics(),
          controller: scrollViewController,
          headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.red[800],
                title: Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Center(
                    child: Text(
                      "ການລາພັກຂອງທ່ານ",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'NotoSansLaoUI-Regular',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                pinned: true,
                floating: true,
                forceElevated: boxIsScrolled,
                bottom: TabBar(
                  isScrollable: false,
                  controller: tabController,
                  tabs: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "ປະຫວັດການລາພັກ",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'NotoSansLaoUI-Regular',
                        ),
                      ),
                    ),
                    // ແຈ້ງ ການຕ່າງໆ
                    Text(
                      "ລາຍການລໍຖ້າອະນຸມັດ",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'NotoSansLaoUI-Regular',
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: tabController,
            children: <Widget>[
              Container(
                child: LeaveHistoryPage("", ""),
              ),
              Container(
                child: LeaveUserWaitApprove(),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        //Init Floating Action Bubble

        //

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[800],
          elevation: 0,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
          tooltip: 'ລາຍລະອຽດ',
          onPressed: () {
            // Navigator.of(context).push(_router.getLeaveRouter());
            // Navigator.push(context,
            //     MaterialWithModalsPageRoute(builder: (_) => LeaveTypePage()));
            showBottonSheet(context);
          },
        ));
  }

}
