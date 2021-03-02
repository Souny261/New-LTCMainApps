import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nextcloud/nextcloud.dart';

class HomeCloud extends StatefulWidget {
  @override
  _HomecloudPageState createState() => _HomecloudPageState();
}

class _HomecloudPageState extends State<HomeCloud>
    with SingleTickerProviderStateMixin {
  ConNexCloud conNexCloud = new ConNexCloud();

  ListFolder _listFolder;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    conNexCloud.main().then((value) {
      setState(() {
        _listFolder = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.red[800],
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.red[800],
          title: Center(
            child: Text("Contact",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          )),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: FutureBuilder(
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    ListFolder listFolder = snapshot.data[index];
                    return Text(listFolder.path);
                  },
                  itemCount: snapshot.data.length,
                );
              } else {
                return Text("Error");
              }
            },
            future: conNexCloud.main(),
          )),
    );
  }
}

class ConNexCloud {
  Future main() async {
    try {
      final client = NextCloudClient(
          'ltc-cloud.laotel.com', 'phonepaseuth', 'N@Y@59969959N@Y');
      return listFiles(client);
    } on RequestException catch (e, stacktrace) {
      print(e.cause);
      print(e.toString());
      print(stacktrace);
    }
  }

  Future<List<ListFolder>> listFiles(NextCloudClient client) async {
    final files = await client.webDav.ls('/');
    List tempList = new List();
    List test = new List();
    for (final file in files) {
      var path = file.name;
      var listFolder = {'path': path};
      tempList.add(listFolder);
    }
    //print(tempList);
    test.addAll(tempList);
    return test.map<ListFolder>((json) => ListFolder.fromJson(json)).toList();
  }
}

class ListFolder {
  var path;

  ListFolder({this.path});

  ListFolder.fromJson(Map<String, dynamic> json) {
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    return data;
  }
}
