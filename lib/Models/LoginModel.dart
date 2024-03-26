import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  String? fkRoleId;
  String? userName;
  String? password;
  String? userLoginId;
  String? firstName;

  Login(
      {this.fkRoleId,
      this.userName,
      this.password,
      this.userLoginId,
      this.firstName});

  factory Login.fromJson(Map<String, dynamic> json) => Login(
      fkRoleId: "6581eabb9e3ba253cc4946cc".toString(),
      userName: json["userName"],
      password: json["password"],
      firstName: json["firstName"]);

  Map<String, dynamic> toJson() => {
        "fkRoleId": fkRoleId,
        "userName": userName,
        "password": password,
        "firstName": firstName
      };
}
