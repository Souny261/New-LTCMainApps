import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  String url;
  WebViewPage(this.url);
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool isLoading;

  Timer _timer;
  int _start = 10;

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

  @override
  void initState() {
    super.initState();
    isLoading = true;
    startTimer();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  checkingOutOverTime() {
    if (_start == 0) {
      return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.network_check_rounded,
              size: 50,
              color: Colors.red[800],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "ກະລຸນາເຊື່ອມຕໍ່ WIFI ທີ່ທີມງານກະກຽມໃຫ້ແລ້ວລອງອີກຄັ້ງ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'NotoSansLaoUI-Regular',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  color: Colors.green,
                  height: 45,
                  onPressed: () async {
                    startTimer();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => super.widget));
                  },
                  elevation: 5,
                  splashColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("ລອງໃໝ່",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoSansLaoUI-Regular',
                          color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (_) {
                if (_start == 0) {
                  setState(() {
                    isLoading = true;
                    print(isLoading);
                  });
                } else {
                  setState(() {
                    isLoading = false;
                    print(isLoading);
                  });
                }
              },
            ),
          ),
          isLoading
              ? Center(
                  child: checkingOutOverTime(),
                )
              : Container(),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 32, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Colors.white,
                    child: Icon(
                      Icons.cancel,
                      size: 35,
                      color: Colors.red[800],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
