import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltcmainapp/LtcEvent/Controller/EventModel.dart';
import 'package:ltcmainapp/LtcEvent/pages/EventDetailPage.dart';

Widget header({String count, String title, Icon icon}) {
  return Padding(
    padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: icon,
              ),
              TextSpan(
                text: title,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSansLaoUI-Regular',
                ),
              ),
            ],
          ),
        ),
        notiEventCount(count)
      ],
    ),
  );
}

Widget notiEventCount(count) {
  return Container(
    child: Row(
      children: [
        Row(
          children: [
            Icon(Icons.notification_important),
            Text(
              count,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.red[800]),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget newEventlist({List<EventModel> evenList, BuildContext context}) {
  int _current = 0;
  return Column(
    children: [
      CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 1.0,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          onPageChanged: (index, reason) {},
          height: MediaQuery.of(context).size.height / 3,
        ),
        items: evenList
            .map((item) => Builder(
                  builder: (BuildContext context) {
                    return Container(
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            child: Stack(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                EventDetailPage(item)));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                //height: MediaQuery.of(context).size.height / 2.8,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    topRight:
                                                        Radius.circular(10.0),
                                                  ),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: item.eventBG,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Stack(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 0,
                                                        right: 0,
                                                        left: 0,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 8.0,
                                                            horizontal: 16.0,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Colors.white60,
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                item.fmTitle,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18,
                                                                  fontFamily:
                                                                      'NotoSansLaoUI-Regular',
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  RichText(
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        WidgetSpan(
                                                                          child:
                                                                              Icon(
                                                                            Icons.location_on,
                                                                            color:
                                                                                Colors.red[800],
                                                                            size:
                                                                                18,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              item.fmAddress,
                                                                          style:
                                                                              TextStyle(
                                                                            fontStyle:
                                                                                FontStyle.italic,
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                Colors.black,
                                                                            fontFamily:
                                                                                'NotoSansLaoUI-Regular',
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  placeholder: (context, url) =>
                                                      Image.asset(
                                                    "assets/r.gif",
                                                    height: 30.0,
                                                    width: 30.0,
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                          top: 10,
                                          right: 9,
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 45,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red[800],
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                5.0),
                                                        topRight:
                                                            Radius.circular(
                                                                5.0),
                                                      )),
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    DateFormat("MMM")
                                                        .format(DateTime.parse(
                                                      item.inDate,
                                                    )),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 45,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                                5.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                5.0),
                                                      )),
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    DateFormat("dd")
                                                        .format(DateTime.parse(
                                                      item.inDate,
                                                    )),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.red[800],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(200, 0, 0, 0),
                                          Color.fromARGB(0, 0, 0, 0)
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    );
                  },
                ))
            .toList(),

        // GestureDetector(
        //       onTap: () {
        //         Navigator.push(context,
        //             MaterialPageRoute(builder: (_) => EventDetailPage(item)));
        //       },
        //       child: Card(

        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(10.0),
        //         ),
        //         child: Stack(
        //           children: <Widget>[
        //             Column(
        //               children: <Widget>[
        //                 Expanded(
        //                   child: Container(
        //                     //height: MediaQuery.of(context).size.height / 2.8,
        //                     width: double.infinity,
        //                     decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.only(
        //                         topLeft: Radius.circular(10.0),
        //                         topRight: Radius.circular(10.0),
        //                       ),
        //                     ),
        //                     child: CachedNetworkImage(
        //                       imageUrl: item.eventBG,
        //                       imageBuilder: (context, imageProvider) => Stack(
        //                         children: [
        //                           Container(
        //                             decoration: BoxDecoration(
        //                               image: DecorationImage(
        //                                 image: imageProvider,
        //                                 fit: BoxFit.cover,
        //                               ),
        //                             ),
        //                           ),
        //                           Positioned(
        //                             bottom: 0,
        //                             right: 0,
        //                             left: 0,
        //                             child: Container(
        //                               padding: const EdgeInsets.symmetric(
        //                                 vertical: 8.0,
        //                                 horizontal: 16.0,
        //                               ),
        //                               decoration: BoxDecoration(
        //                                 color: Colors.white60,
        //                               ),
        //                               child: Column(
        //                                 mainAxisAlignment:
        //                                     MainAxisAlignment.start,
        //                                 crossAxisAlignment:
        //                                     CrossAxisAlignment.start,
        //                                 children: [
        //                                   Text(
        //                                     item.fmTitle,
        //                                     overflow: TextOverflow.ellipsis,
        //                                     style: TextStyle(
        //                                       fontWeight: FontWeight.bold,
        //                                       fontSize: 18,
        //                                       fontFamily:
        //                                           'NotoSansLaoUI-Regular',
        //                                     ),
        //                                   ),
        //                                   Row(
        //                                     mainAxisAlignment:
        //                                         MainAxisAlignment.end,
        //                                     children: [
        //                                       RichText(
        //                                         text: TextSpan(
        //                                           children: [
        //                                             WidgetSpan(
        //                                               child: Icon(
        //                                                 Icons.location_on,
        //                                                 color: Colors.red[800],
        //                                                 size: 18,
        //                                               ),
        //                                             ),
        //                                             TextSpan(
        //                                               text: item.fmAddress,
        //                                               style: TextStyle(
        //                                                 fontStyle:
        //                                                     FontStyle.italic,
        //                                                 fontSize: 15,
        //                                                 color: Colors.black,
        //                                                 fontFamily:
        //                                                     'NotoSansLaoUI-Regular',
        //                                               ),
        //                                             ),
        //                                           ],
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ],
        //                               ),
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                       placeholder: (context, url) => Image.asset(
        //                         "assets/r.gif",
        //                         height: 30.0,
        //                         width: 30.0,
        //                       ),
        //                       errorWidget: (context, url, error) =>
        //                           Icon(Icons.error),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             Positioned(
        //               top: 10,
        //               right: 9,
        //               child: Container(
        //                 child: Column(
        //                   children: [
        //                     Container(
        //                       width: 45,
        //                       decoration: BoxDecoration(
        //                           color: Colors.red[800],
        //                           borderRadius: BorderRadius.only(
        //                             topLeft: Radius.circular(5.0),
        //                             topRight: Radius.circular(5.0),
        //                           )),
        //                       padding: const EdgeInsets.all(4.0),
        //                       child: Text(
        //                         DateFormat("MMM").format(DateTime.parse(
        //                           item.inDate,
        //                         )),
        //                         textAlign: TextAlign.center,
        //                         style: TextStyle(
        //                           color: Colors.white,
        //                           fontWeight: FontWeight.bold,
        //                           fontSize: 15.0,
        //                         ),
        //                       ),
        //                     ),
        //                     Container(
        //                       width: 45,
        //                       decoration: BoxDecoration(
        //                           color: Colors.white,
        //                           borderRadius: BorderRadius.only(
        //                             bottomLeft: Radius.circular(5.0),
        //                             bottomRight: Radius.circular(5.0),
        //                           )),
        //                       padding: const EdgeInsets.all(4.0),
        //                       child: Text(
        //                         DateFormat("dd").format(DateTime.parse(
        //                           item.inDate,
        //                         )),
        //                         textAlign: TextAlign.center,
        //                         style: TextStyle(
        //                           color: Colors.red[800],
        //                           fontWeight: FontWeight.bold,
        //                           fontSize: 18.0,
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //     ))
        // .toList(),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: evenList.map((url) {
          int index = evenList.indexOf(url);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index ? Colors.red[800] : Colors.red[100],
            ),
          );
        }).toList(),
      ),
    ],
  );
}



Widget eventList(List<EventModel> evenList) {
  String now =
      DateFormat("dd").format(DateTime.parse(DateTime.now().toString()));
  return Expanded(
    child: ListView.builder(
        itemCount: evenList.length,
        itemBuilder: (context, index) {
          return now !=
                  DateFormat("dd")
                      .format(DateTime.parse(evenList[index].inDate))
              ? Container()
              : GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EventDetailPage(evenList[index])));
                    // if (index == 1) {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (_) => WorkOrderPage("img$index")));
                    // } else {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (_) => EventDetailPage("img$index")));
                    // }
                  },
                  child: Card(
                    elevation: 4.0,
                    // color: Colors.red[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              height: 120.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: evenList[index].eventBG,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Image.asset(
                                  "assets/r.gif",
                                  height: 50.0,
                                  width: 50.0,
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                evenList[index].fmTitle,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'NotoSansLaoUI-Regular',
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "By: ${evenList[index].fullName}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'NotoSansLaoUI-Regular',
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                          ],
                        ),
                        Positioned(
                          top: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5.0)),
                            ),
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 15,
                                ),
                                Text(
                                  evenList[index].fmAddress,
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 105,
                          left: 20.0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green[800],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "ໃໝ່",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'NotoSansLaoUI-Regular',
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 9,
                          child: Container(
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
                                    DateFormat("MMM").format(DateTime.parse(
                                      evenList[index].inDate,
                                    )),
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
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5.0),
                                        bottomRight: Radius.circular(5.0),
                                      )),
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    DateFormat("dd").format(DateTime.parse(
                                      evenList[index].inDate,
                                    )),
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
                        )
                      ],
                    ),
                  ),
                );
        }),
  );
}
