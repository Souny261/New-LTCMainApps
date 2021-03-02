import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ltcmainapp/Events/Content/viewFile.dart';
import 'package:ltcmainapp/Events/Controller/eventService.dart';
import 'package:ltcmainapp/Events/Models/eventModel.dart';

class EventDetailContent extends StatefulWidget {
  final DataInvite dataInvite;
  String empID;
  String apiToken;

  EventDetailContent({Key key, this.dataInvite, this.empID, this.apiToken})
      : super(key: key);

  @override
  _HomeDetailContentState createState() =>
      _HomeDetailContentState(this.dataInvite);
}

class _HomeDetailContentState extends State<EventDetailContent>
    with SingleTickerProviderStateMixin {
  final DataInvite dataInvite;

  _HomeDetailContentState(this.dataInvite);

  String Token = '';
  final EventServices eventClass = new EventServices();

  String apiToken = "";
  List listFile = new List();
  var showFile;
  loadData() {
    List tempList = new List();
    var aclistData = dataInvite.acListFile;
    for (int i = 0; i < aclistData.length; i++) {
      tempList.add(aclistData[i]);
    }
    setState(() {
      listFile.addAll(tempList);
      eventClass.InviteOpened(dataInvite.inviteID);
      eventClass.loadInviteEvent();
    });

    //print(dataInvite.activeCheckIn);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(
          child: Text(
            dataInvite.inviteCode,
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'NotoSansLaoUI-Regular',
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SizedBox(
        child: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 5,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            dataInvite.detail,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSansLaoUI-Regular',
                            ),
                          ),
                          Divider(
                            height: 1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "ສະຖານທີ : ${dataInvite.room}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'NotoSansLaoUI-Regular',
                          ),
                        ),
                      ),
                    ),
                    //getListEventFile(),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: listFile.map((a) {
                      var fileID = a['fileID'];
                      var fileType = a['fileType'];
                      var status = a['status'];
                      var FileName = a['FileName'];
                      var fileSize = a['fileSize'];
                      //(status == 1) ? dataInvite.activeCheckIn
                      if (status == '1') {
                        if (dataInvite.activeCheckIn == 'aco' ||
                            dataInvite.activeCheckIn == 'ac' ||
                            dataInvite.activeCheckIn == 'exp') {
                          setState(() {
                            showFile = true;
                          });
                        } else {
                          setState(() {
                            showFile = true;
                          });
                        }
                      } else {
                        setState(() {
                          showFile = true;
                        });
                      }
                      return OutlineButton.icon(
                        onPressed: (showFile == false)
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => viewFile(
                                      dataInvite: dataInvite,
                                      fileID: fileID,
                                      FileName: FileName,
                                      type: 'ev',
                                    ),
                                  ),
                                  // dataInvite: dataInvite, fileID: fileID,
                                );
                              },
                        icon: Icon(Icons.attach_file),
                        label: Text(
                          FileName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'NotoSansLaoUI-Regular',
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              //Text(listFile[0])
            ],
          ),
        ),
      ),
    );
  }
}
