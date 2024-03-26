// ignore_for_file: file_names, non_constant_identifier_names, avoid_print
import 'dart:convert';

Signup signUpFromJson(String str) => Signup.fromJson(json.decode(str));
String signUpToJson(Signup data) => json.encode(data.toJson());

class Signup {
  String? email;
  String? password;
  String? fkRoleId;
  String? address;
  String? district;
  String? firstName;
  String? fklocalbodyId;
  String? localbodyName;
  String? fklocalbodyTypeId;
  String? pincode;
  String? lastName;

  Signup({
    this.email,
    this.password,
    this.fkRoleId,
    this.address,
    this.district,
    this.firstName,
    this.fklocalbodyId,
    this.localbodyName,
    this.fklocalbodyTypeId,
    this.pincode,
    this.lastName,
  });

  factory Signup.fromJson(Map<String, dynamic> json) {
    print(json);
    return Signup(
      email: json["email"],
      password: json["password"],
      fkRoleId: "6581eabb9e3ba253cc4946cc".toString(),
      address: json["address"],
      district: json["district"],
      firstName: json["firstName"],
      fklocalbodyId: json["fklocalbodyId"],
      localbodyName: json["localbodyName"],
      fklocalbodyTypeId: json["fklocalbodyTypeId"],
      pincode: json["pincode"],
      lastName: json["lastName"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['fkRoleId'] = fkRoleId;
    data['address'] = address;
    data['district'] = district;
    data['firstName'] = firstName;
    data['fklocalbodyId'] = fklocalbodyId;
    data['localbodyName'] = localbodyName;
    data['fklocalbodyTypeId'] = fklocalbodyTypeId;
    data['pincode'] = pincode;
    data['lastname'] = lastName;
    return data;
  }
}
