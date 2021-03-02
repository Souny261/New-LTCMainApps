class NotiModel {
  int nid;
  String title;
  String type;
  String url;
  String image;
  String createDate;
  NotiModel(
      {this.nid, this.title, this.type, this.url, this.image, this.createDate});
  NotiModel.fromJson(Map<String, dynamic> json) {
    nid = json['nid'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
    image = json['image'];
    createDate = json['createDate'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nid'] = this.nid;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    data['image'] = this.image;
    data['createDate'] = this.createDate;
    return data;
  }
}

class ContentModel {
  String header;
  String body;
  String footer;
  String createDate;
  String createBy;
  String bgImage;

  ContentModel(
      {this.header,
      this.body,
      this.footer,
      this.createDate,
      this.createBy,
      this.bgImage});

  ContentModel.fromJson(Map<String, dynamic> json) {
    header = json['header'];
    body = json['body'];
    footer = json['footer'];
    createDate = json['createDate'];
    createBy = json['createBy'];
    bgImage = json['bgImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['header'] = this.header;
    data['body'] = this.body;
    data['footer'] = this.footer;
    data['createDate'] = this.createDate;
    data['createBy'] = this.createBy;
    data['bgImage'] = this.bgImage;
    return data;
  }
}
