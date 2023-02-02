class LoginModel {
  bool? status;
  String? message;
  UserData? data;
  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;
  UserData({
    this.name,
    this.id,
    this.email,
    this.image,
    this.token,
    this.credit,
    this.phone,
    this.points,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    token = json['token'];
    phone = json['phone'];
    credit = json['credit'];
    points = json['points'];
  }
}
