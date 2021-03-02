import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltcmainapp/Controller/sharedata.dart';
import 'package:ltcmainapp/FingerPrintHistory/Controller/fingerService.dart';
import 'package:ltcmainapp/FingerPrintHistory/Widgets/BottomAppBar.dart';
import 'package:ltcmainapp/FingerPrintHistory/Widgets/FloatingActionButton.dart';
import 'package:ltcmainapp/FingerPrintHistory/Widgets/ShowTimeTosceach.dart';
import 'package:ltcmainapp/FingerPrintHistory/pages/history.dart' as history;
import 'package:ltcmainapp/FingerPrintHistory/pages/sumaryFinger.dart'
    as sumaryFinger;
import 'package:ltcmainapp/FingerPrintHistory/pages/sumaryFinger.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:progress_dialog/progress_dialog.dart';

class HomeFingerPrinTPage extends StatefulWidget {
  String empID, apiToken;

  HomeFingerPrinTPage({this.empID, this.apiToken});

  @override
  _HomeFingerPrinTPageState createState() => _HomeFingerPrinTPageState();
}

class _HomeFingerPrinTPageState extends State<HomeFingerPrinTPage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;
  TabController _tabController;
  ProgressDialog pr;
  String newApiToken = "";
  ShareData _shareData = new ShareData();
  FingerService service = new FingerService();
  String dateMonth = DateFormat('MM/yyyy').format(DateTime.now());

  void getNewApiToken() {
    _shareData.saveApiToken(widget.apiToken).then((value) {
      setState(() {
        newApiToken = value.response;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollViewController = ScrollController();
    getNewApiToken();
    _tabController = TabController(vsync: this, length: 2);

    super.initState();
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.red[800],
                title: Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Center(
                    child: Text(
                      "ການມາວຽກຂອງທ່ານ",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'NotoSansLaoUI-Regular',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showCupertinoModalBottomSheet(
                        context: context,
                        builder: (context, scrollController) {
                          return Material(
                            child: CupertinoPageScaffold(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                                child: ShowMonthToSceachData(
                                  empID: widget.empID,
                                  apiToken: newApiToken,
                                ),
                              ),
                              navigationBar: CupertinoNavigationBar(
                                transitionBetweenRoutes: false,
                                //leading: Container(),
                                middle: Text(
                                  'ເບິ່ງຂໍ້ມູນ ເດືອນທີ່ທ່ານຕ້ອງການ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'NotoSansLaoUI-Regular',
                                  ),
                                ),
                                backgroundColor: Colors.red[800],
                                automaticallyImplyLeading: false,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
                pinned: true,
                floating: true,
                forceElevated: boxIsScrolled,
                bottom: TabBar(
                  isScrollable: false,
                  controller: _tabController,
                  tabs: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "ປະຈຳວັນ",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'NotoSansLaoUI-Regular',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // ແຈ້ງ ການຕ່າງໆ
                    Text(
                      "ສັງລວມ",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'NotoSansLaoUI-Regular',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              history.historyFinger(
                loading: _scrollViewController,
                empID: widget.empID,
              ),
              Material(
                child: SumaryFingerPrint(
                  viewDate: dateMonth,
                  apiToken: newApiToken,
                  empID: widget.empID,
                ),
              )
            ],
          ),
        ),
        // bottomNavigationBar: BottomAppBarWidget(widget.empID, widget.apiToken),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton:
            FloatingActionButtonWidget(widget.empID, newApiToken, dateMonth));
  }


}
