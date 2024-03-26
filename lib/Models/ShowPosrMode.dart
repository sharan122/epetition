import 'dart:convert';

Postcard postcardFromJson(String str) => Postcard.fromJson(json.decode(str));

String postcardToJson(Postcard data) => json.encode(data.toJson());

class Postcard {
  List<Post> post;
  int? statusCode;

  Postcard({
    required this.post,
    this.statusCode,
  });

  factory Postcard.fromJson(Map<String, dynamic> json) => Postcard(
        post: List<Post>.from(json["post"].map((x) => Post.fromJson(x))),
        statusCode: json["statusCode"] as int?,
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
  String media;
  int? voteCount;

  Post(
      {this.id,
      this.title,
      this.description,
      this.location,
      required this.media,
      this.voteCount});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      id: json["_id"],
      title: json["title"],
      description: json["description"],
      location: json["location"],
      media: json["media"],
      voteCount: json["voteCount"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "location": location,
        "media": media,
        "voteCount": voteCount
      };
}
