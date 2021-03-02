import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ltcmainapp/Contact/Controller/contactService.dart';
import 'package:ltcmainapp/Contact/Model/contactModels.dart';
import 'package:url_launcher/url_launcher.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";
  // ສະແດງຜົນ
  @override
  Widget buildResults(BuildContext context) {
    print(query);
    return ShowdataEmployee(query, selectedResult, apiToken);
  }

  final List<String> listExample;
  String apiToken;
  Search(this.listExample, this.apiToken);
  List<String> recentList = [
    "ຫ້ອງການຕິດຕັ້ງ-ສ້ອມແປງ",
    "ບໍລິຫານ",
    "ການເງິນ",
    "ໂທລະສັບມືຖື",
    "ວິເຄາະລະບົບຂໍ້ມູນ-ຂ່າວສານ",
    "ໂທລະສັບຕັ້ງໂຕະ ແລະ ອິນເຕີເນັດ",
    "ໄອທີ",
    "ບໍລິການລູກຄ້າທົ່ວໄປ",
    "ກວດກາພາຍໃນ",
    "ການຕະຫຼາດ",
    "ພັດທະນາເຄືອຂ່າຍ",
    "ບໍລິການລູກຄ້າອົງກອນ"
  ];
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
            // In the false case
            (element) => element.contains(query),
          ));
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: () {
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}

class ShowdataEmployee extends StatefulWidget {
  String query, selectedResult, apiToken;
  ShowdataEmployee(this.query, this.selectedResult, this.apiToken);
  @override
  _ShowdataEmployeeState createState() => _ShowdataEmployeeState();
}

class _ShowdataEmployeeState extends State<ShowdataEmployee> {
  List<EmpData> _empData = List<EmpData>();
  ContactServices _service = new ContactServices();
  Timer _timer;
  int _start = 5;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  void _populateNewsArticles() {
    _service
        .contactEmployees(
            widget.query == "" ? widget.selectedResult : widget.query)
        .then((newsEmployee) => {
              setState(() => {_empData = newsEmployee})
            });
  }

  @override
  void initState() {
    super.initState();
    _populateNewsArticles();
    startTimer();
  }

  checkingOutOverTime() {
    if (_start == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.cancel,
            size: 100,
            color: Colors.red[800],
          ),
          Text(
            "ບໍ່ພົບຂໍ້ມູນທີ່ທ່ານຄົ້ນຫາ",
            style: TextStyle(
                fontFamily: 'NotoSansLaoUI-Regular',
                fontSize: 15,
                fontWeight: FontWeight.bold),
          )
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/r.gif",
              height: 100.0,
              width: 100.0,
            ),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.query == ""
        ? Container(child: listEmp())
        : Container(child: listEmp());
  }

  Widget listEmp() {
    return _empData.isEmpty
        ? Container(
            child: Center(child: checkingOutOverTime()),
          )
        : ListView.builder(
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
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
