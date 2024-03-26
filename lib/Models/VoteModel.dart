import 'dart:convert';

Vote voteFromJson(String str) => Vote.fromJson(json.decode(str));

String voteToJson(Vote data) => json.encode(data.toJson());

class Vote {
  int? statusCode;
  String? message;

  Vote({
    this.statusCode,
    this.message,
  });

  factory Vote.fromJson(Map<String, dynamic> json) => Vote(
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
      };
}
