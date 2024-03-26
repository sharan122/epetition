// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

Media mediaFromJson(String str) => Media.fromJson(json.decode(str));

String mediaToJson(Media data) => json.encode(data.toJson());

class Media {
  String? file_path;
  String? myfile;

  Media({this.file_path, this.myfile});

  factory Media.fromJson(Map<String, dynamic> json) =>
      Media(file_path: json["file_path"], myfile: json["myfile"]);

  Map<String, dynamic> toJson() => {"file_path": file_path, "myfile": myfile};
}
