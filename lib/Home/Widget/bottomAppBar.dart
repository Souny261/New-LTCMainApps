import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ltcmainapp/Authentication/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottonAppBarr extends StatefulWidget {
  String version;
  BottonAppBarr({this.version});
  @override
  _BottonAppBarrState createState() => _BottonAppBarrState();
}
class _BottonAppBarrState extends State<BottonAppBarr> {
  String nameKey = "Token";
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Colors.white,
      notchMargin: 4.0,
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              widget.version,
              style: TextStyle(
                  color: Colors.red[800], fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: Icon(
                Icons.exit_to_app,
                size: 30.0,
                color: Colors.red[800],
              ),
              onPressed: () {
                logoutApps();
              },
            ),
          ),
        ],
      ),
    );
  }

  void logoutApps() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            'ທ່ານຕ້ອງການ Logout ?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'NotoSansLaoUI-Regular',
            ),
          ),
          content: Text(
            'ທ່ານຈະກັບສູ່ໜ້າ Login',
            style: TextStyle(
              fontFamily: 'NotoSansLaoUI-Regular',
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                Navigator.pop(context);
                pref.remove("apiToken");
                pref.remove(nameKey);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Icon(
                    Icons.exit_to_app,
                    size: 30.0,
                    color: Colors.red[800],
                  ),
                  Text(
                    'ອອກຈາກລະບົບ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NotoSansLaoUI-Regular',
                        color: Colors.red[800]),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
