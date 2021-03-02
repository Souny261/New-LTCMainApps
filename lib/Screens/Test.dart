import 'package:flutter/material.dart';
import 'package:ltcmainapp/Controller/provider.dart';
import 'package:provider/provider.dart';




class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}
class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<TodoModel>(
        builder: (context, todo, child) {
          return ListView.builder(
              itemCount: todo.leaveWaitList.length,
              itemBuilder: (context, index) {
                return Container(
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 8),
                    title: Text(
                      todo.leaveWaitList[index].detail,
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      todo.leaveWaitList[index].startDate,
                      style: TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.check_circle,
                      color: Colors.greenAccent,
                    ),
                  ),
                  margin: EdgeInsets.only(bottom: 8, left: 16, right: 16),
                );
              });
        },
      ),
    );
  }
}
