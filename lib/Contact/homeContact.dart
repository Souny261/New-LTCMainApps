import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ltcmainapp/Contact/Controller/contactService.dart';
import 'package:ltcmainapp/Contact/Model/contactModels.dart';
import 'package:ltcmainapp/Contact/Widgets/scaech.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Widgets/empListView.dart';

class HomeContact extends StatefulWidget {
  String empID, apiToken;
  HomeContact({this.empID, this.apiToken});
  @override
  _HomeContactState createState() => _HomeContactState();
}

class _HomeContactState extends State<HomeContact> {
  List<EmpData> _empData = List<EmpData>();
  var childCount = 0;
  ContactServices _service = new ContactServices();
  bool isLoading = true;
  final empID = TextEditingController();
  Icon cusIcon;
  Widget appBarr;
  var refresh;
  bool _show = true;
  int wt = 1000;
  var filter;
  final List<String> list = List.generate(10, (index) => "Text $index");
  void _populateNewsArticles() {
    _service.contactEmployees("").then((newsEmployee) => {
          setState(() => {_empData = newsEmployee})
        });
  }

  setData() {
    cusIcon = Icon(Icons.search);
    appBarr = Text(" ");
    refresh = widget.empID;
    if (refresh == widget.empID) {
      setState(() {
        _show = true;
      });
    }
  }

  @override
  void initState() {
    setData();
    super.initState();
    _populateNewsArticles();
  }

  @override
  Widget build(BuildContext context) {
    Timer timer = Timer(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.red[800],
      appBar: AppBar(
          elevation: 0,
          actions: [
            _show == true
                ? new IconButton(
                    icon: cusIcon,
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: Search(list, widget.apiToken));
                    },
                  )
                : new Container()
          ],
          backgroundColor: Colors.red[800],
          title: Center(
            child: Text("Contact",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          )),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: isLoading
                ? Center(
                    child: Image.asset(
                      "assets/r.gif",
                      height: 100.0,
                      width: 100.0,
                    ),
                  )
                : listEmp(timer),
          )),
    );
  }

  Widget listEmp(timer) {
    timer.cancel();
    return ListView.builder(
        itemCount: _empData.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 1.0,
            shadowColor: Colors.red,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://img.icons8.com/bubbles/2x/user-male.png",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      /* leading: Container(
                                    child: ImageProfile.ImageProfile(
                                      apiToken: widget.apiToken,
                                      empID: emp.employeeID.toString(),
                                    ),
                                  ),*/
                      title: Text(
                        _empData[index].fullName,
                        style: TextStyle(
                            fontFamily: 'NotoSansLaoUI-Regular',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(_empData[index].tel),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launch("tel://" + _empData[index].tel);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.red[800],
                      child: Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
