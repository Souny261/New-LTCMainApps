import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltcmainapp/Home/Models/homeModel.dart';

class LeaveDetailPage extends StatefulWidget {
  String title;
  List<LeaveDetail> leaveDetail;
  LeaveDetailPage(this.title, this.leaveDetail);
  @override
  _LeaveDetailPageState createState() => _LeaveDetailPageState();
}
class _LeaveDetailPageState extends State<LeaveDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.red[800],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red[800],
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'NotoSansLaoUI-Regular',
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: widget.leaveDetail.length,
            itemBuilder: (context, index) {
              var data = widget.leaveDetail;
              return ListTile(
                onTap: () {},
                title: Text(
                  data[index].leaveTypeName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansLaoUI-Regular',
                  ),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ວັນທີ:" +
                          DateFormat("dd/MM/yyyy")
                              .format(DateTime.parse(data[index].startDate)) +
                          ' | ເວລາ:' +
                          DateFormat("hh:mm")
                              .format(DateTime.parse(data[index].startDate)) +
                          ' ຫາ ' +
                          DateFormat("hh:mm")
                              .format(DateTime.parse(data[index].endDate)),
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontFamily: 'NotoSansLaoUI-Regular',
                      ),
                    ),
                    Text(
                      "ລາຍລະອຽດ: " + data[index].detail,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontFamily: 'NotoSansLaoUI-Regular',
                      ),
                    ),
                  ],
                ),
                leading: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.transparent,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://icons-for-free.com/iconfiles/png/512/leave-131964752935242149.png',
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}