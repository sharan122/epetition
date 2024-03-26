import 'dart:convert';

CloseCase closeCaseFromJson(String str) => CloseCase.fromJson(json.decode(str));

String closeCaseToJson(CloseCase data) => json.encode(data.toJson());

class CloseCase {
  int? statusCode;

  CloseCase({
    this.statusCode,
  });

  factory CloseCase.fromJson(Map<String, dynamic> json) => CloseCase(
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
      };
}
