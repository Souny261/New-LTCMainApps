import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ltcmainapp/Notification/Controllers/service.dart';

class NotiDetail extends StatefulWidget {
  int nid;
  String title;
  NotiDetail(this.nid, this.title);
  @override
  _NotiDetailState createState() => _NotiDetailState();
}

class _NotiDetailState extends State<NotiDetail> {
  ServiceNoti service = new ServiceNoti();

  String header, body, footer, bgImage, createBy, createDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service.getNotiContent(widget.nid.toString()).then((value) {
      setState(() {
        header = value.header;
        body = value.body;
        footer = value.footer;
        bgImage = value.bgImage;
        createBy = value.createBy;
        createDate = value.createDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'NotoSansLaoUI-Regular',
          ),
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.person,
                    size: 15,
                  ),
                  Text(
                    createBy == null ? '...' : createBy,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.date_range,
                    size: 15,
                  ),
                  Text(
                    createDate == null ? '...' : createDate,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
      body: header == null
          ? Center(
              child: Image.asset(
                "assets/r.gif",
                height: 80.0,
                width: 80.0,
              ),
            )
          : Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                image: new NetworkImage(bgImage),
                fit: BoxFit.cover,
              )),
              child: Stack(
                children: [
                  ListView(
                    children: [_headerWEB(), _bodyWEB(), _footerWEB()],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _headerWEB() {
    return Html(
      data: """
       ${header}
      """,
      backgroundColor: Colors.white70,
      onLinkTap: (url) {},
      onImageTap: (src) {},
    );
  }

  Widget _bodyWEB() {
    return Html(
      data: """
       ${body}
      """,
      backgroundColor: Colors.white70,
      onLinkTap: (url) {},
      onImageTap: (src) {},
    );
  }

  Widget _footerWEB() {
    return Html(
      data: """
       ${footer}
      """,
      //Optional parameters:
      backgroundColor: Colors.white70,
      onLinkTap: (url) {
        // open url in a webview
      },

      onImageTap: (src) {
        // Display the image in large form.
      },
    );
  }
}
