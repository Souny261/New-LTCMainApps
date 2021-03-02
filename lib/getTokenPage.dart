import 'dart:async';
import 'dart:math';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ltcmainapp/Controller/sharedata.dart';
import 'package:ltcmainapp/Home/homePage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Leave/Controllers/leaveService.dart';

class SpritePainter extends CustomPainter {
  final Animation<double> _animation;
  SpritePainter(this._animation) : super(repaint: _animation);
  void circle(Canvas canvas, Rect rect, double value) {
    double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    Color color = new Color.fromRGBO(255, 0, 0, opacity);
    double size = rect.width / 2;
    double area = size * size;
    double radius = sqrt(area * value / 4);
    final Paint paint = new Paint()..color = color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = new Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(SpritePainter oldDelegate) {
    return true;
  }
}

class SpriteDemo extends StatefulWidget {
  @override
  SpriteDemoState createState() => new SpriteDemoState();
}

class SpriteDemoState extends State<SpriteDemo>
    with SingleTickerProviderStateMixin {
  List<ResultLeaveWaiting> waitApprove;
  bool isLoading;
  Timer _timer;
  int _start = 10;
  LeaveService service = new LeaveService();
  var loading = true;
  ProgressDialog pr;
  AnimationController _controller;
  ShareData shareData = new ShareData();
  Future callToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    shareData.saveApiToken(pref.getString("apiToken")).whenComplete(() {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      print("Loding token is finished");
      pref.remove("commentProvider");
    });
  }

  void startTimer() {
    int _start = 20;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (_start < 1) {
        timer.cancel();
        Flushbar(
          mainButton: FlatButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
            },
            child: Icon(
              Icons.refresh,
              size: 30,
              color: Colors.white,
            ),
          ),
          messageText: Text(
            "ກວດສອບການເຊື່ອມຕໍ່",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
                fontFamily: 'NotoSansLaoUI-Regular',
                color: Colors.white),
          ),
          icon: Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.red[800],
          ),
          leftBarIndicatorColor: Colors.red[800],
        )..show(context);
      } else {
        _start = _start - 1;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
    );
    callToken();
    _startAnimation();
    startTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.stop();
    _controller.reset();
    _controller.repeat(
      period: Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: new CustomPaint(
              painter: new SpritePainter(_controller),
              child: new SizedBox(
                width: 200.0,
                height: 200.0,
                child: IconButton(
                  onPressed: () async {},
                  icon: Icon(
                    Icons.person_pin,
                    color: Colors.white,
                    size: 45,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
