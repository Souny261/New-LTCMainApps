import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ltcmainapp/Leave/Controllers/leaveService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageProfile1 extends StatefulWidget {
  String empID;
  String apiToken;
  double hieght = 100.0;
  double width = 90.0;
  int radiusImg;

  ImageProfile1(
      {this.empID, this.apiToken, this.hieght, this.width, this.radiusImg});

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ImageProfile1>
    with SingleTickerProviderStateMixin {
  LeaveService services = new LeaveService();

  String ImageEmp = "";

  setData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var empID = pref.getString("empID");
    services.getImageEmp(empID).then((value) {
      print("Image:" + value.url);
      setState(() {
        ImageEmp = value.url;
      });
    });
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ImageEmp.isEmpty
        ? CircularProgressIndicator()
        : CircleAvatar(
            radius: 45,
            backgroundColor: Colors.transparent,
            child: CachedNetworkImage(
              imageUrl: ImageEmp,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          );
  }
}
