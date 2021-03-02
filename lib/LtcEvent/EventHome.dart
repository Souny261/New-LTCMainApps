import 'package:flutter/material.dart';
import 'package:ltcmainapp/LtcEvent/Controller/EventModel.dart';
import 'package:ltcmainapp/LtcEvent/Controller/EventServices.dart';
import 'package:ltcmainapp/LtcEvent/Widgets/EventSilde.dart';
import 'Widgets/EventWidget.dart';

class NewEventHomePage extends StatefulWidget {
  List<EventModel> evenList;
  List<EventModel> eventNew;
  NewEventHomePage({this.evenList, this.eventNew});
  @override
  _NewEventHomePageState createState() => _NewEventHomePageState();
}

class _NewEventHomePageState extends State<NewEventHomePage> {
  ApiServiceProvider event = new ApiServiceProvider();
  List<EventModel> evenList;

  Future callData() {
    if (widget.evenList == null) {
      event.getEvent().then((value) {
        setState(() {
          evenList = value;
        });
      });
    } else {
      setState(() {
        evenList = widget.evenList;
      });
    }
  }

  @override
  void initState() {
    callData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
              size: 45,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.red[800],
        elevation: 0,
        title: Center(
            child: Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Text("Event"),
        )),
      ),
      body: Column(
        children: [
          header(
              icon: Icon(
                Icons.new_releases,
                color: Colors.red[800],
                size: 18,
              ),
              title: "ລາຍການສຳລັບມື້ນີ້",
              count: widget.eventNew.length.toString()),
          widget.eventNew.isEmpty
              ? Container(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Container(
                      child: Text(
                        "ບໍ່ພົບຂໍ້ມູນ",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[800],
                          fontSize: 15,
                          fontFamily: 'NotoSansLaoUI-Regular',
                        ),
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Container(
                    child: EventSlide(evenList: widget.eventNew),
                  ),
                ),
          Divider(
            height: 8,
            color: Colors.black,
          ),
          evenList == null
              ? Container()
              : header(
                  title: "ປະຫວັດ",
                  count: evenList.length.toString(),
                  icon: Icon(
                    Icons.history,
                    color: Colors.red[800],
                    size: 18,
                  )),
          evenList == null
              ? Container()
              : Expanded(
                  child: Container(
                    //child: newEventlist(evenList: evenList, context: context),

                    child: EventSlide(evenList: evenList),
                  ),
                ),
          //eventList(evenList)
        ],
      ),
    );
  }
}
