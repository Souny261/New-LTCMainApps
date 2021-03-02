class NewToken {
  bool status;
  String response;

  NewToken({this.status, this.response});

  NewToken.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    return data;
  }
}

class ApiToken {
  bool status;
  String response;
  ApiToken({this.status, this.response});
  ApiToken.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    return data;
  }
}

class showMessage {
  String title;
  String body;

  showMessage({this.title, this.body});

  showMessage.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}

class LocationModel {
  String lat;
  String long;
  LocationModel({
    this.lat,
    this.long,
  });
}
