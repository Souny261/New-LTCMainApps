import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:ltcmainapp/Events/Models/eventModel.dart';

class viewFile extends StatefulWidget {
  final DataInvite dataInvite;
  String fileID;
  String FileName;
  String type;
  viewFile({this.dataInvite, this.fileID, this.FileName, this.type});
  @override
  _viewFileState createState() => _viewFileState();
}

class _viewFileState extends State<viewFile> {
  String selectedUrl = 'https://edoc.laotel.com/viewFile.php?';
  createURL() {
    setState(() {
      selectedUrl += 'type=ev&&fileID=' + widget.fileID;
    });
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    //createURL();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          widget.FileName,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'NotoSansLaoUI-Regular',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      withLocalUrl: true,
      allowFileURLs: false,
      hidden: true,
      appCacheEnabled: false,
      withLocalStorage: false,
      url: selectedUrl + 'type=' + widget.type + '&&fileID=' + widget.fileID,
      withJavascript: true,
    );
  }
}
