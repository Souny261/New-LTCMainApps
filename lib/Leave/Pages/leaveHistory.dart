import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltcmainapp/Leave/Controllers/leaveService.dart';
import 'package:ltcmainapp/Leave/Widgets/listHistoryLeave.dart';

class LeaveHistoryPage extends StatefulWidget {
  String empID, apiToken;
  LeaveHistoryPage(this.empID, this.apiToken);
  @override
  _LeaveHistoryPageState createState() => _LeaveHistoryPageState();
}

class _LeaveHistoryPageState extends State<LeaveHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: ListHistoryLeave(widget.empID),
    );
  }
}
