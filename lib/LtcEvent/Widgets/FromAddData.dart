import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ltcmainapp/LtcEvent/Controller/EventModel.dart';
import 'package:ltcmainapp/LtcEvent/Controller/EventServices.dart';
import 'package:ltcmainapp/LtcEvent/Controller/data.dart';
import 'package:ltcmainapp/LtcEvent/Provider/ProviderFunction.dart';
import 'package:mime/mime.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FromAddData extends StatefulWidget {
  final EventModel eventModel;
  WorkProcess listChioce;
  FromAddData(this.eventModel, this.listChioce);
  @override
  _FromAddDataState createState() => _FromAddDataState();
}

class _FromAddDataState extends State<FromAddData>
    with SingleTickerProviderStateMixin {
  int _current = 0;
  ProgressDialog pr;
  List data = [];
  List dataSendImg = [];
  final comment = new TextEditingController();
  ApiServiceProvider eventService = new ApiServiceProvider();
  final picker = ImagePicker();
  Animation<double> scaleAnimation;
  AnimationController controller;
  File img;

  Future addCommentToPro(
      {String commet,
      String chioceID,
      List<Attract> listAttr,
      String time}) async {
    Provider.of<WorkProcessProvider>(context, listen: false).addTaskInList(
        listAttr: listAttr,
        comment: commet,
        time: time,
        id: chioceID,
        leght: 0);
  }

  Future getImage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String empID = pref.getString("empID");

    try {
      final pickedFile = await picker.getImage(
          source: ImageSource.camera,
          imageQuality: 50,
          maxHeight: 480,
          maxWidth: 640);
      var file = File(pickedFile.path);
      var size = file.lengthSync();
      String fileName = file.path.split('/').last;
      final fileType = lookupMimeType(fileName);
      final fileDataType = fileType.split('/').last;
      if (pickedFile.path.isEmpty) {
        print("NO Image");
      } else {
        final bytes = Io.File(pickedFile.path).readAsBytesSync();
        var b64 = base64Encode(bytes);
        //print(b64);
        setState(() {
          img = File(pickedFile.path);
          data.add(File(pickedFile.path));
          dataSendImg.add({
            "fileData": b64,
            "fileType": fileType,
            "fileSize": size,
            "fileName": fileName,
            "dataType": fileDataType,
            "createBy": empID
          });
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: Image.asset(
          "assets/r.gif",
          height: 100.0,
          width: 100.0,
        ),
        message: 'ກະລຸນາລໍຖ້າ',
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0))),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            maxLines: 4,
                            cursorColor: Colors.red,
                            controller: comment,
                            textInputAction: TextInputAction.go,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(
                                  fontFamily: 'NotoSansLaoUI-Regular',
                                  fontSize: 20),
                              labelText: 'ພີມຄຳຄິດເຫັນຂອງທ່ານ...',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.attach_file,
                                        color: Colors.red[800],
                                        size: 20,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "ແນບຮູບພາບ",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'NotoSansLaoUI-Regular',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              img != null
                                  ? GestureDetector(
                                      onTap: () {
                                        getImage();
                                      },
                                      child: RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(
                                                Icons.add_circle,
                                                color: Colors.green,
                                                size: 20,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "ເພີ້ມຮູບ",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontFamily:
                                                    'NotoSansLaoUI-Regular',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                        img == null
                            ? Center(
                                child: GestureDetector(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white70, width: 1),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(Icons.camera_alt,
                                          size: 100, color: Colors.red[800]),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: MediaQuery.of(context).size.height / 2,
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Flexible(
                                      child: CarouselSlider(
                                        options: CarouselOptions(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2,
                                            aspectRatio: 2.0,
                                            enlargeCenterPage: true,
                                            enlargeStrategy:
                                                CenterPageEnlargeStrategy
                                                    .height,
                                            enableInfiniteScroll: false,
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                _current = index;
                                              });
                                            }),
                                        items: data.map((i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                child: Container(
                                                  margin: EdgeInsets.all(5.0),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      child: Stack(
                                                        children: <Widget>[
                                                          Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  1.5,
                                                              child: Image.file(
                                                                  i,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  width:
                                                                      1000.0)),
                                                          Positioned(
                                                            bottom: 0.0,
                                                            left: 0.0,
                                                            right: 0.0,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Color
                                                                        .fromARGB(
                                                                            200,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    Color
                                                                        .fromARGB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0)
                                                                  ],
                                                                  begin: Alignment
                                                                      .bottomCenter,
                                                                  end: Alignment
                                                                      .topCenter,
                                                                ),
                                                              ),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          10.0,
                                                                      horizontal:
                                                                          20.0),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                              );
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: data.map((url) {
                                        int index = data.indexOf(url);
                                        return Container(
                                          width: 8.0,
                                          height: 8.0,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 2.0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _current == index
                                                ? Colors.red[800]
                                                : Colors.red[100],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                if (comment.text.isEmpty) {
                                  AwesomeDialog(
                                      context: context,
                                      animType: AnimType.SCALE,
                                      headerAnimationLoop: false,
                                      dialogType: DialogType.INFO,
                                      title: 'ກະລຸນາເພີ້ມຂໍ້ມູນ',
                                      desc: '',
                                      btnOkIcon: Icons.check_circle,
                                      btnOkColor: Colors.green,
                                      btnOkOnPress: () {},
                                      onDissmissCallback: () {})
                                    ..show();
                                } else if (img == null) {
                                  AwesomeDialog(
                                      context: context,
                                      animType: AnimType.SCALE,
                                      headerAnimationLoop: false,
                                      dialogType: DialogType.INFO,
                                      title: 'ກະລຸນາເລືອກຮູບພາບ',
                                      desc: '',
                                      btnOkIcon: Icons.check_circle,
                                      btnOkColor: Colors.green,
                                      btnOkOnPress: () {},
                                      onDissmissCallback: () {
                                        print("object");
                                      })
                                    ..show();
                                } else {
                                  // List<Attract> list = [
                                  //   Attract(
                                  //       url:
                                  //           "https://static.toiimg.com/photo/72975551.cms",
                                  //       createTime: "2021-01-28 09:32:37"),
                                  //   Attract(
                                  //       url:
                                  //           "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8c3VucmlzZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80",
                                  //       createTime: "2021-01-28 09:32:37"),
                                  // ];
                                  // addCommentToPro(
                                  //         comment.text,
                                  //         widget.listChioce.choiceID.toString(),
                                  //         list)
                                  //     .whenComplete(() {
                                  //   AwesomeDialog(
                                  //       context: context,
                                  //       animType: AnimType.SCALE,
                                  //       headerAnimationLoop: false,
                                  //       dialogType: DialogType.SUCCES,
                                  //       title: 'ບັນທຶກສຳເລັດ',
                                  //       desc: '',
                                  //       btnOkIcon: Icons.check_circle,
                                  //       btnOkColor: Colors.green,
                                  //       btnOkOnPress: () {},
                                  //       onDissmissCallback: () {
                                  //         Navigator.pop(context);
                                  //       })
                                  //     ..show();
                                  // });
                                  //print(dataSendImg);

                                  pr.show();
                                  AddCommentModel addCommentModel;
                                  eventService
                                      .inserComment(
                                          comment.text,
                                          widget.listChioce.choiceID.toString(),
                                          widget.eventModel.fmID.toString(),
                                          widget.eventModel.formInviteID
                                              .toString(),
                                          dataSendImg)
                                      .then((value) {
                                    print("comment: ${value.comment}");
                                    addCommentToPro(
                                        commet: value.comment,
                                        time: value.commentTime,
                                        listAttr: value.listAttr,
                                        chioceID: value.choiceID.toString());
                                  }).whenComplete(() {
                                    pr.hide();
                                    AwesomeDialog(
                                        context: context,
                                        animType: AnimType.SCALE,
                                        headerAnimationLoop: false,
                                        dialogType: DialogType.SUCCES,
                                        title: 'ບັນທຶກສຳເລັດ',
                                        desc: '',
                                        btnOkIcon: Icons.check_circle,
                                        btnOkColor: Colors.green,
                                        btnOkOnPress: () {},
                                        onDissmissCallback: () {
                                          Navigator.pop(context);
                                        })
                                      ..show();
                                  });
                                }
                              },
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.save,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "ບັນທຶກ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: 'NotoSansLaoUI-Regular',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.red[800],
                                        size: 20,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "ປິດ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: 'NotoSansLaoUI-Regular',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
