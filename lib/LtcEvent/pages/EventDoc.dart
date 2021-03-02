import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:ltcmainapp/LtcEvent/Controller/EventServices.dart';

class EventDocPage extends StatefulWidget {
  String url;
  EventDocPage(this.url);
  @override
  _EventDocPageState createState() => _EventDocPageState();
}

class _EventDocPageState extends State<EventDocPage> {
  String localPath;
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  ApiServiceProvider apiServiceProvider = new ApiServiceProvider();

  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiServiceProvider
        .loadPDF(
            widget.url)
        .then((value) {
      setState(() {
        localPath = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          localPath != null
              ? PDFView(
                  filePath: localPath,
                  enableSwipe: true,
                  autoSpacing: false,
                  pageFling: true,
                  pageSnap: true,
                  defaultPage: currentPage,
                  fitPolicy: FitPolicy.BOTH,
                  preventLinkNavigation:
                      false, // if set to true the link is handled in flutter
                  onRender: (_pages) {
                    setState(() {
                      pages = _pages;
                      isReady = true;
                    });
                  },

                  onViewCreated: (PDFViewController pdfViewController) {
                    _controller.complete(pdfViewController);
                  },
                  onLinkHandler: (String uri) {
                    print('goto uri: $uri');
                  },
                  onPageChanged: (int page, int total) {
                    print('page change: $page/$total');
                    setState(() {
                      currentPage = page;
                    });
                  },
                )
              : Container(),
          errorMessage.isEmpty
              ? !isReady
                  ? Center(
                      child: Image.asset(
                        "assets/r.gif",
                        height: 50.0,
                        width: 50.0,
                      ),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                ),
          Positioned(
            top: 25,
            left: 8.0,
            right: 8,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white38,
                    child: IconButton(
                        padding: EdgeInsets.only(left: 8),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.red[800],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: 45,
                          decoration: BoxDecoration(
                              color: Colors.red[800],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0),
                              )),
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            pages.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Container(
                          width: 45,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red[800]),
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                              )),
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            (currentPage + 1).toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
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
