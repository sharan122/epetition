import 'dart:convert';

Postdetails postdetailsFromJson(String str) =>
    Postdetails.fromJson(json.decode(str));

String postdetailsToJson(Postdetails data) => json.encode(data.toJson());

class Postdetails {
  Post post;
  int? statusCode;

  Postdetails({
    required this.post,
    this.statusCode,
  });

  factory Postdetails.fromJson(Map<String, dynamic> json) => Postdetails(
        post: Post.fromJson(json["post"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "post": post.toJson(),
        "statusCode": statusCode,
      };
}

class Post {
  String? id;
  String? title;
  String? description;
  String? location;
  String? media;
  int? voteCount;

  Post({
    this.id,
    this.title,
    this.description,
    this.location,
    this.media,
    this.voteCount,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        location: json["location"],
        media: json["media"],
        voteCount: json["voteCount"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "location": location,
        "media": media,
        "voteCount": voteCount,
      };
}
