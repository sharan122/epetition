import 'dart:convert';

Grlogin grloginFromJson(String str) => Grlogin.fromJson(json.decode(str));

String grloginToJson(Grlogin data) => json.encode(data.toJson());

class Grlogin {
  int? statusCode;
  String? message;
  String? userName;
  String? password;
  String? fkRoleId;

  Grlogin({
    this.statusCode,
    this.fkRoleId,
    this.userName,
    this.password,
  });

  factory Grlogin.fromJson(Map<String, dynamic> json) => Grlogin(
        fkRoleId: "6581eabb9e3ba253cc4946cb".toString(),
        userName: json["userName"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "fkRoleId": fkRoleId,
        "userName": userName,
        "password": password,
      };
}
