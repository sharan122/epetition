// ignore_for_file: file_names

import 'dart:convert';

Localbody localbodyFromJson(String str) => Localbody.fromJson(json.decode(str));

String localbodyToJson(Localbody data) => json.encode(data.toJson());

class Localbody {
  int statusCode;
  List<LocalbodyElement> localbody;

  Localbody({
    required this.statusCode,
    required this.localbody,
  });

  factory Localbody.fromJson(Map<String, dynamic> json) => Localbody(
        statusCode: json["statusCode"],
        localbody: List<LocalbodyElement>.from(
            json["localbody"].map((x) => LocalbodyElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "localbody": List<dynamic>.from(localbody.map((x) => x.toJson())),
      };
}

class LocalbodyElement {
  String? id;
  String? localbodyName;

  LocalbodyElement({
    this.id,
    this.localbodyName,
  });

  factory LocalbodyElement.fromJson(Map<String, dynamic> json) =>
      LocalbodyElement(
        id: json["_id"],
        localbodyName: json["localbodyName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "localbodyName": localbodyName,
      };
}
