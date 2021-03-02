import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:ltcmainapp/Notification/Controllers/service.dart';
import 'package:ltcmainapp/Notification/Models/notiModels.dart';
import 'package:ltcmainapp/Notification/Screens/notiDetal.dart';
import 'package:ltcmainapp/Rountes/router.dart';

class NotiListView extends StatefulWidget {
  @override
  _NotiListViewState createState() => _NotiListViewState();
}

class _NotiListViewState extends State<NotiListView> {
  RouterApp _router = new RouterApp();
  ServiceNoti service = new ServiceNoti();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: service.getNoti(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return Center(child: Text("ບໍ່ພົບຂໍ້ມູນ"));
          }
          return ListView.separated(
              shrinkWrap: true,
              //physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(3.0),
              itemBuilder: (context, index) {
                NotiModel notiModel = snapshot.data[index];
                return itemsNoti(
                    notiModel.title,
                    notiModel.createDate,
                    notiModel.image,
                    notiModel.type,
                    notiModel.nid,
                    notiModel.url);
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black12,
                );
              },
              itemCount: snapshot.data.length);
        } else if (snapshot.hasError) {
          return Center(
            child: Image.asset(
              "assets/r.gif",
              height: 100.0,
              width: 100.0,
            ),
          );
        } else {
          return Center(
            child: Image.asset(
              "assets/r.gif",
              height: 100.0,
              width: 100.0,
            ),
          );
        }
      },
    );
  }

  Widget itemsNoti(title, date, url, type, nid, link) {
    return ListTile(
      onTap: () {
        if (type == "W") {
          Navigator.of(context).push(_router.webViewRouter(link));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => NotiDetail(nid, title)));
        }
      },
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'NotoSansLaoUI-Regular',
        ),
      ),
      subtitle: Text(
        date,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontFamily: 'NotoSansLaoUI-Regular',
        ),
      ),
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.transparent,
        child: CachedNetworkImage(
          imageUrl: url,
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
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.chevron_right,
          size: 40,
          color: Colors.red[800],
        ),
      ),
    );
  }
}
