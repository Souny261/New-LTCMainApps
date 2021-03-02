import 'package:flutter/material.dart';
import 'package:ltcmainapp/Contact/homeContact.dart';
import 'package:ltcmainapp/Events/eventHome.dart';
import 'package:ltcmainapp/FingerPrintHistory/homeHistory.dart';
import 'package:ltcmainapp/Home/web_view.dart';
import 'package:ltcmainapp/Leave/leaveHome.dart';
import 'package:ltcmainapp/LtcEvent/Controller/EventModel.dart';
import 'package:ltcmainapp/LtcEvent/EventHome.dart';
import 'package:ltcmainapp/Notification/listNotification.dart';
import 'package:ltcmainapp/Notification/mainNoti.dart';
import 'package:ltcmainapp/nextcloud/homeCloud.dart';
import 'package:ltcmainapp/Leave/Pages/get_leave.dart';

class RouterApp {
  homeFingerPrint(String empID, String apiToken) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          HomeFingerPrinTPage(
        empID: empID,
        apiToken: apiToken,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeInCirc;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  homeContact(String empID, String apiToken) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomeContact(
        empID: empID,
        apiToken: apiToken,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeInCirc;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  leaveRouter() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LeaveHomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeIn;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  notiRouter() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MainNotiPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeInCirc;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  eventRouter() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => EventHomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeInCirc;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  listNoficationPage() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ListNofication(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeInToLinear;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  homePageCloud() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomeCloud(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeInCirc;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  webViewRouter(String url) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => WebViewPage(url),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeIn;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  eventMeettingRouter({List<EventModel> evenList, List<EventModel> eventNew}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => NewEventHomePage(
        evenList: evenList,
        eventNew: eventNew,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeIn;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
  // getLeaveRouter() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => GetLeavePage(),
  //        transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       var begin = Offset(1.0, 0.0);
  //       var end = Offset.zero;
  //       var curve = Curves.easeInCirc;
  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }
}
