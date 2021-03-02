import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ltcmainapp/Contact/Controller/contactService.dart';
import 'package:ltcmainapp/Contact/Model/contactModels.dart';
import 'package:url_launcher/url_launcher.dart';

class EmpListView extends StatefulWidget {
  Timer timer;
  String apiToken, seach;
  EmpListView({this.apiToken, this.seach, this.timer});
  @override
  _EmpListViewState createState() => _EmpListViewState();
}

class _EmpListViewState extends State<EmpListView> {
  List<EmpData> _empData = List<EmpData>();
  ContactServices _service = new ContactServices();
  void _populateNewsArticles() {
    _service.contactEmployees("").then((newsEmployee) => {
          setState(() => {_empData = newsEmployee})
        });
  }

  @override
  void initState() {
    super.initState();
    _populateNewsArticles();
  }

  @override
  Widget build(BuildContext context) {
    widget.timer.cancel();
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
