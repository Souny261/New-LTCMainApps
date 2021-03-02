import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltcmainapp/LtcEvent/Controller/EventModel.dart';
import 'package:ltcmainapp/LtcEvent/Controller/data.dart';
import 'package:ltcmainapp/LtcEvent/Provider/ProviderFunction.dart';
import 'package:ltcmainapp/LtcEvent/Widgets/FromAddData.dart';
import 'package:ltcmainapp/LtcEvent/pages/CommentDetail.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class WorkingProcessWidget extends StatefulWidget {
  EventModel eventModel;
  WorkingProcessWidget(this.eventModel);
  @override
  _WorkingProcessWidgetState createState() => _WorkingProcessWidgetState();
}

class _WorkingProcessWidgetState extends State<WorkingProcessWidget> {
  final PageController pageController =
      PageController(initialPage: 1, keepPage: true);
  int pageIx = 1;
  String now =
      DateFormat("dd").format(DateTime.parse(DateTime.now().toString()));
  Future addDataToPro() async {
    for (var i = 0; i < widget.eventModel.listFormChoice.length; i++) {
      var val;
      for (var j = 0;
          j < widget.eventModel.listFormChoice[i].empAnswers.length;
          j++) {
        val = widget.eventModel.listFormChoice[i].empAnswers[j].comment;
        Provider.of<WorkProcessProvider>(context, listen: false).addTaskInList(
            listAttr:
                widget.eventModel.listFormChoice[i].empAnswers[j].listAttr,
            comment: val,
            time: widget.eventModel.listFormChoice[i].empAnswers[j].commentTime,
            id: widget.eventModel.listFormChoice[i].choiceID.toString(),
            leght: 1);
        // print(
        //     widget.eventModel.listFormChoice[i].empAnswers[j].listAttr[j].url);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    addDataToPro().whenComplete(() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("commentProvider", "haved");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Timeline.builder(
        itemCount: widget.eventModel.listFormChoice.length,
        physics: ClampingScrollPhysics(),
        position: TimelinePosition.Left,
        itemBuilder: (BuildContext context, int index) {
          WorkProcess data = widget.eventModel.listFormChoice[index];

          return TimelineModel(
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<WorkProcessProvider>(
                      builder: (context, comment, child) {
                    return Column(
                      children: [
                        ExpansionTile(
                          children: comment.commentList
                              .map((e) => data.choiceID != int.parse(e.id)
                                  ? Container()
                                  : ExpansionTile(
                                      leading: Icon(
                                        Icons.mark_chat_read,
                                        size: 18,
                                        color: Colors.red[800],
                                      ),
                                      title: Align(
                                        alignment: Alignment(-1.5, 0),
                                        child: Text(
                                          e.comment == null ? 'nuu' : e.comment,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'NotoSansLaoUI-Regular',
                                          ),
                                        ),
                                      ),
                                      subtitle: e.commentTime == null
                                          ? Text("null")
                                          : Align(
                                              alignment: Alignment(-1.5, 0),
                                              child: Text(DateFormat("H:mm:ss")
                                                  .format(DateTime.parse(
                                                e.commentTime,
                                              ))),
                                            ),
                                      children: [
                                        e.listAttr.length > 2
                                            ? GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              Comment(
                                                                listAttr:
                                                                    e.listAttr,
                                                                comment:
                                                                    e.comment,
                                                              )));
                                                },
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                          height: 100,
                                                          child: image(
                                                            e.listAttr[0].url,
                                                          )),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        height: 100,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              e.listAttr[1].url,
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    color: Colors
                                                                        .white54,
                                                                    child: Center(
                                                                        child: Text(
                                                                      "+ ${e.listAttr.length - 2}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            40,
                                                                        fontFamily:
                                                                            'NotoSansLaoUI-Regular',
                                                                      ),
                                                                    )),
                                                                  )),
                                                          placeholder: (context,
                                                                  url) =>
                                                              CircularProgressIndicator(),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              Comment(
                                                                listAttr:
                                                                    e.listAttr,
                                                                comment:
                                                                    e.comment,
                                                              )));
                                                },
                                                child: Row(
                                                  children: e.listAttr
                                                      .map(
                                                        (e) => Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              height: 100,
                                                              child: image(
                                                                e.url,
                                                              )),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              )
                                      ],
                                    ))
                              .toList(),
                          title: Text(
                            data.choiceName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'NotoSansLaoUI-Regular',
                            ),
                          ),
                        ),
                        now !=
                                DateFormat("dd").format(
                                    DateTime.parse(widget.eventModel.inDate))
                            ? Container()
                            : FlatButton(
                                onPressed: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (_) =>
                                        FromAddData(widget.eventModel, data),
                                  );
                                },
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.mode_comment,
                                          color: Colors.green,
                                          size: 18,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'ສະແດງຄຳຄິດເຫັນ',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15,
                                          color: Colors.green,
                                          fontFamily: 'NotoSansLaoUI-Regular',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                      ],
                    );
                  }),
                ),
              ),
              position: TimelineItemPosition.left,
              isFirst: index == 0,
              isLast: index == widget.eventModel.listFormChoice.length,
              //iconBackground: doodle.iconBackground,

              icon: Icon(
                Icons.check_circle,
                //color: doodle.status == true ? Colors.green : Colors.grey,
                color: Colors.green,
                size: 50,
              ));
        },
      ),
    );
  }

  Widget image(url) {
    return Container(
      child: CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Container(
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
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
