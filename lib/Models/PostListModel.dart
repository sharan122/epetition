// ignore_for_file: file_names

import 'dart:convert';

PostList postListFromJson(String str) => PostList.fromJson(json.decode(str));

String postListToJson(PostList data) => json.encode(data.toJson());

class PostList {
  List<Post> post;
  int? statusCode;

  PostList({
    required this.post,
    this.statusCode,
  });

  factory PostList.fromJson(Map<String, dynamic> json) => PostList(
        post: List<Post>.from(json['post'].map((x) => Post.fromJson(x))),
        statusCode: json['statusCode'] as int?,
      );

  Map<String, dynamic> toJson() => {
        "posts": List<dynamic>.from(post.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class Post {
  String? id;
  String? title;
  String? description;
  // String? location;
  // String? fkUserLoginId;

  Post({
    this.id,
    this.title,
    this.description,
    // this.location,
    // this.fkUserLoginId,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        // location: json["location"],
        // fkUserLoginId: json["fkUserLoginId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        // "location": location,
        // "fkUserLoginId": fkUserLoginId
      };
}
