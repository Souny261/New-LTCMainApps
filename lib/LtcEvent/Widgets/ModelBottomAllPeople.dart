import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ltcmainapp/LtcEvent/Controller/EventModel.dart';

class PeopleInMeeting extends StatefulWidget {
  List<Users> usersList;
  PeopleInMeeting(this.usersList);
  @override
  _PeopleInMeetingState createState() => _PeopleInMeetingState();
}

class _PeopleInMeetingState extends State<PeopleInMeeting> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "ເຂົ້າຮ່ວມກອງປະຊຸມທັງໝົດ ",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                          color: Colors.black,
                          fontFamily: 'NotoSansLaoUI-Regular',
                        ),
                      ),
                      TextSpan(
                        text: widget.usersList.length.toString(),
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoSansLaoUI-Regular',
                        ),
                      ),
                      TextSpan(
                        text: " ຄົນ",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                          color: Colors.black,
                          fontFamily: 'NotoSansLaoUI-Regular',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
                child: Container(
              child: ListView.builder(
                  itemCount: widget.usersList.length,
                  itemBuilder: (context, index) {
                    var data = widget.usersList[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.white,
                          child: CachedNetworkImage(
                            imageUrl: data.image,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        title: Text(
                          data.fullName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black,
                            fontFamily: 'NotoSansLaoUI-Regular',
                          ),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: data.positionName,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: 'NotoSansLaoUI-Regular',
                                ),
                              ),
                              WidgetSpan(
                                child: Icon(
                                  Icons.more_vert,
                                  color: Colors.red[800],
                                  size: 18,
                                ),
                              ),
                              TextSpan(
                                text: data.depNam,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: 'NotoSansLaoUI-Regular',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ))
          ],
        ),
      ),
    );
  }
}
