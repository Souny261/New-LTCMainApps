import 'package:flutter/material.dart';
import 'package:ltcmainapp/getTokenPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Authentication/login.dart';

class checkPage extends StatefulWidget {
  final String empIDNo;
  const checkPage({Key key, this.empIDNo}) : super(key: key);
  @override
  State createState() => new CheckPageState();
}

class CheckPageState extends State<checkPage>
    with SingleTickerProviderStateMixin {
  final empIDNo = TextEditingController();
  String Token = '';
  String nameKey = "Token";

  //Widget _defaultHome = new LoginPage();
  String _status = 'no-action';

  setData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      Token = pref.getString("apiToken");
    });
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  getPages() {
    if (Token == null) {
      return LoginPage();
    } else if (Token.isEmpty) {
      return LoginPage();
    } else if (Token.isNotEmpty) {
      // return HomePage();
      return SpriteDemo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return getPages();
  }
}
