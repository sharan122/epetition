import 'dart:convert';

SentChat sentChatFromJson(String str) => SentChat.fromJson(json.decode(str));

String sentChatToJson(SentChat data) => json.encode(data.toJson());

class SentChat {
  int? statusCode;

  SentChat({
    this.statusCode,
  });

  factory SentChat.fromJson(Map<String, dynamic> json) => SentChat(
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
      };
}
