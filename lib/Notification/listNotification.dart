import 'package:flutter/material.dart';
import 'package:ltcmainapp/Controller/sharedata.dart';
import 'Widgets/notiListView.dart';

class ListNofication extends StatefulWidget {
  @override
  _ListNotiPageState createState() => _ListNotiPageState();
}

class _ListNotiPageState extends State<ListNofication> {
  String fullname = "";
  String imageUser = "";
  String empID = "";
  String apiToken = "";
  ShareData shareData = new ShareData();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.red[800],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red[800],
        title: Center(
          child: Text(
            "ແຈ້ງເຕືອນຂອງທ່ານ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: NotiListView(),
      ),
    );
  }
}
