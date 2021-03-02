// import 'package:flutter/material.dart';

// class ImageWidget extends StatefulWidget {
//   @override
//   _ImageWidgetState createState() => _ImageWidgetState();
// }

// class _ImageWidgetState extends State<ImageWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(



//     );
//   }
// }




// import 'dart:convert';
// import 'dart:io';
// import 'dart:io' as Io;
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:ltcmainapp/Leave/Controllers/leaveService.dart';
// import 'package:ltcmainapp/Ltc_Chat/Bloc/db/database_provider.dart';

// import 'package:ltcmainapp/Ltc_Chat/Controllers/chat_services.dart';
// import 'package:mime/mime.dart';
// import 'package:progress_dialog/progress_dialog.dart';

// class ShowImageWidget extends StatefulWidget {
//   File image;
//   List menber;
//   String title,
//       groupImg,
//       imagePath,
//       fileName,
//       fileType,
//       fileDataType,
//       empID,
//       fullname,
//       roomID,
//       groupID;
//   var size;
//   ShowImageWidget(
//       {this.image,
//       this.title,
//       this.groupImg,
//       this.imagePath,
//       this.fileDataType,
//       this.fileName,
//       this.fileType,
//       this.size,
//       this.empID,
//       this.menber,
//       this.fullname,
//       this.roomID,
//       this.groupID});
//   @override
//   _ShowImageWidgetState createState() => _ShowImageWidgetState();
// }

// class _ShowImageWidgetState extends State<ShowImageWidget> {
//   final referenceDatabase = FirebaseDatabase.instance;
//   ChatServicesMessage service = new ChatServicesMessage();
//   LeaveService services = new LeaveService();


//   final picker = ImagePicker();
//   int _current = 0;
//   ProgressDialog pr;
//   String rerefpk = "0";
//   List data = [];
//   List dataSendImg = [];
//   final sendMessage = new TextEditingController();

  
//   Future getImage() async {
//     try {
//       final pickedFile = await picker.getImage(source: ImageSource.gallery);
//       var file = File(pickedFile.path);
//       var size = file.lengthSync();
//       String fileName = file.path.split('/').last;
//       final fileType = lookupMimeType(fileName);
//       final fileDataType = fileType.split('/').last;
//       setState(() {
//         data.add(File(pickedFile.path));
//         dataSendImg.add({
//           "data": pickedFile.path,
//           "fileType": fileType,
//           "size": size,
//           "fileName": fileName,
//           "fileDataType": fileDataType
//         });
//       });
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   Future createMessage(image, textmessage, profile) async {
//     for (var i = 0; i < widget.menber.length; i++) {
//       if (widget.menber[i]['empID'] != widget.empID) {
//         service.sendMessage(
//             widget.fullname,
//             widget.menber[i]['empID'],
//             textmessage == null
//                 ? "ສົ່ງຮູບພາບຫາທ່ານ/${widget.menber[i]['empID']}"
//                 : textmessage,
//             '2',
//             widget.empID,
//             "1");
//       }
//     }

//     service.createMessages(
//         "${widget.empID}-${DateTime.now().toString()}",
//         textmessage,
//         widget.empID,
//         rerefpk,
//         widget.roomID,
//         widget.groupID,
//         image,
//         profile,
//         context);
//   }

//   @override
//   void initState() {
//     data.add(widget.image);
//     dataSendImg.add({
//       "data": widget.imagePath,
//       "fileType": widget.fileType,
//       "size": widget.size,
//       "fileName": widget.fileName,
//       "fileDataType": widget.fileDataType
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     pr = new ProgressDialog(context,
//         type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
//     pr.style(
//         borderRadius: 10.0,
//         backgroundColor: Colors.white,
//         progressWidget: Image.asset(
//           "assets/r.gif",
//           height: 100.0,
//           width: 100.0,
//         ),
//         message: 'ກຳລັງສົ່ງຮູບ...',
//         elevation: 10.0,
//         insetAnimCurve: Curves.easeInOut,
//         progress: 0.0,
//         maxProgress: 100.0,
//         progressTextStyle: TextStyle(
//             color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
//         messageTextStyle: TextStyle(
//             color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Row(
//           children: [
//             CircleAvatar(
//               radius: 20,
//               backgroundColor: Colors.transparent,
//               child: CachedNetworkImage(
//                 imageUrl: widget.groupImg,
//                 imageBuilder: (context, imageProvider) => Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       image: imageProvider,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 placeholder: (context, url) => CircularProgressIndicator(),
//                 errorWidget: (context, url, error) => Icon(Icons.error),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 15),
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           alignment: Alignment.center,
//           child: Column(
//             children: [
//               Flexible(
//                 child: CarouselSlider(
//                   options: CarouselOptions(
//                       height: MediaQuery.of(context).size.height,
//                       aspectRatio: 2.0,
//                       enlargeCenterPage: true,
//                       enlargeStrategy: CenterPageEnlargeStrategy.height,
//                       enableInfiniteScroll: false,
//                       onPageChanged: (index, reason) {
//                         setState(() {
//                           _current = index;
//                         });
//                       }),
//                   items: data.map((i) {
//                     return Builder(
//                       builder: (BuildContext context) {
//                         return Container(
//                           child: Container(
//                             margin: EdgeInsets.all(5.0),
//                             child: ClipRRect(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(5.0)),
//                                 child: Stack(
//                                   children: <Widget>[
//                                     Container(
//                                         height:
//                                             MediaQuery.of(context).size.height /
//                                                 1.5,
//                                         child: Image.file(i,
//                                             fit: BoxFit.cover, width: 1000.0)),
//                                     Positioned(
//                                       bottom: 0.0,
//                                       left: 0.0,
//                                       right: 0.0,
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           gradient: LinearGradient(
//                                             colors: [
//                                               Color.fromARGB(200, 0, 0, 0),
//                                               Color.fromARGB(0, 0, 0, 0)
//                                             ],
//                                             begin: Alignment.bottomCenter,
//                                             end: Alignment.topCenter,
//                                           ),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 10.0, horizontal: 20.0),
//                                       ),
//                                     ),
//                                   ],
//                                 )),
//                           ),
//                         );
//                       },
//                     );
//                   }).toList(),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: data.map((url) {
//                   int index = data.indexOf(url);
//                   return Container(
//                     width: 8.0,
//                     height: 8.0,
//                     margin:
//                         EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color:
//                           _current == index ? Colors.red[800] : Colors.red[100],
//                     ),
//                   );
//                 }).toList(),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 8),
//                                   child: TextFormField(
//                                     controller: sendMessage,
//                                     decoration: InputDecoration(
//                                       border: InputBorder.none,
//                                       hintText: 'ພີມຂໍ້ຄວາມ...',
//                                       hintStyle: TextStyle(
//                                           fontStyle: FontStyle.italic),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 8),
//                                 child: CircleAvatar(
//                                   backgroundColor: Colors.red[800],
//                                   child: IconButton(
//                                     icon: Icon(
//                                       Icons.send,
//                                       color: Colors.white,
//                                     ),
//                                     onPressed: () {
//                                       FocusScope.of(context).unfocus();
//                                       pr.show();
//                                       var pkID;

//                                       final bytes =
//                                           Io.File(dataSendImg[0]['data'])
//                                               .readAsBytesSync();
//                                       var img64 = base64Encode(bytes);
//                                       // createMessage("0", sendMessage.text);
//                                       // Navigator.pop(context);
//                                       service
//                                           .sendImage(
//                                               img64,
//                                               dataSendImg[0]['fileType'],
//                                               dataSendImg[0]['size'],
//                                               dataSendImg[0]['fileName'],
//                                               widget.empID,
//                                               dataSendImg[0]['fileDataType'])
//                                           .then((value) async {
//                                         services
//                                             .getImageEmp(widget.empID)
//                                             .then((val) {
//                                           createMessage(value.url,
//                                                   sendMessage.text, val.url)
//                                               .whenComplete(() {
//                                             pr.hide();
//                                             Navigator.pop(context);
//                                           });
//                                         });
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }