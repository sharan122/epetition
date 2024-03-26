import 'dart:convert';

Postmodel postFromJson(String str) => Postmodel.fromJson(json.decode(str));

String postToJson(Postmodel data) => json.encode(data.toJson());

class Postmodel {
  String? title;
  String? description;
  String? location;
  String? media;
  String? fkUserLoginId;
  String? fkRoleId;
  double? maplat;
  double? maolong;

  Postmodel(
      {this.title,
      this.description,
      this.location,
      this.media,
      this.fkUserLoginId,
      this.fkRoleId,
      this.maplat,
      this.maolong});

  factory Postmodel.fromJson(Map<String, dynamic> json) => Postmodel(
      title: json["title"],
      description: json["description"],
      location: json["location"],
      media: json["media"],
      fkUserLoginId: json["fkUserLoginId"],
      fkRoleId: "6581eabb9e3ba253cc4946cc",
      maolong: json["maplong"],
      maplat: json["maplat"]);

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "location": location,
        "media": media,
        "fkUserLoginId": fkUserLoginId,
        "fkRoleId": fkRoleId,
        "maplong": maolong,
        "maplat": maplat
      };
}
