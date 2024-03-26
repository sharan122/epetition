import 'dart:convert';

Grhome grhomeFromJson(String str) => Grhome.fromJson(json.decode(str));

String grhomeToJson(Grhome data) => json.encode(data.toJson());

class Grhome {
  List<Post> post;
  int? statusCode;

  Grhome({
    required this.post,
    this.statusCode,
  });

  factory Grhome.fromJson(Map<String, dynamic> json) => Grhome(
        post: List<Post>.from(json["post"].map((x) => Post.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "post": List<dynamic>.from(post.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class Post {
  String? id;
  String? title;
  String? description;
  String? location;
  String? media;

  Post({
    this.id,
    this.title,
    this.description,
    this.location,
    this.media,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        location: json["location"],
        media: json["media"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "location": location,
        "media": media,
      };
}
