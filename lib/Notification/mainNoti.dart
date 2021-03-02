import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class MainNotiPage extends StatefulWidget {
  @override
  _MainNotiPageState createState() => _MainNotiPageState();
}

class _MainNotiPageState extends State<MainNotiPage> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        automaticallyImplyLeading: true,
        title: Text(
          "",
          style: TextStyle(
              fontFamily: 'NotoSansLaoUI-Regular', fontWeight: FontWeight.bold),
        ),
      ),
      withLocalUrl: true,
      allowFileURLs: true,
      hidden: true,
      appCacheEnabled: true,
      withLocalStorage: true,
      url:
          "https://hr.laotel.com/approved.php?u=dHhKL3lYRmdxZ0t2eG1McUk4bEtpUT09",
      withJavascript: true,
    );
  }
}
