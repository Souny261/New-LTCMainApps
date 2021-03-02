import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ltcmainapp/Home/Models/homeModel.dart';
import 'package:ltcmainapp/Home/Widget/EventWidget.dart';
import 'package:ltcmainapp/Home/Widget/leaveList.dart';
import 'package:ltcmainapp/LtcEvent/Controller/EventModel.dart';

class SlideTapHomeWidget extends StatefulWidget {
  List<EventModel> eventModel;
  List<LeaveProfileData> leaveProfileData;
  bool loading;
  SlideTapHomeWidget({this.eventModel, this.leaveProfileData, this.loading});
  @override
  _SlideTapHomeWidgetState createState() => _SlideTapHomeWidgetState();
}

class _SlideTapHomeWidgetState extends State<SlideTapHomeWidget> {
  int _current = 0;
  var tap = ["1", "2"];
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.red[800],
                      size: 20,
                    ),
                  ),
                  TextSpan(
                    text: "ປະຫວັດການລາພັກ",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: _current == 0 ? Colors.black : Colors.white,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: tap.map((url) {
                int index = tap.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _current == index ? Colors.red[800] : Colors.red[100],
                  ),
                );
              }).toList(),
            ),
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "New Event",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                      color: _current == 1 ? Colors.black : Colors.white,
                      fontWeight:
                          _current == 1 ? FontWeight.bold : FontWeight.normal,
                      fontFamily: 'NotoSansLaoUI-Regular',
                    ),
                  ),
                  WidgetSpan(
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.red[800],
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.red[800],
          height: 0,
        ),
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1.0,
            //enlargeCenterPage: true,
            enableInfiniteScroll: false,
            height: MediaQuery.of(context).size.height / 2.7,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: [
            Container(
              child: LeaveListview(
                leaveProfileData: widget.leaveProfileData,
                loading: widget.loading,
              ),
            ),
            Container(
              child: EventWidget(evenList: widget.eventModel),
            )
          ],
        ),
      ],
    );
  }
}
