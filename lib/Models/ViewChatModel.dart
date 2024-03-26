// view_chat.dart

class ViewChat {
  int? statusCode;
  Chat chat;

  ViewChat({
    this.statusCode,
    required this.chat,
  });

  factory ViewChat.fromJson(Map<String, dynamic> json) => ViewChat(
        statusCode: json["statusCode"],
        chat: Chat.fromJson(json["chat"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "chat": chat.toJson(),
      };
}

class Chat {
  String? id;
  String? fkPostId;
  List<String> chattingUsersId;
  List<ChatMessage> message;

  Chat({
    this.id,
    this.fkPostId,
    required this.chattingUsersId,
    required this.message,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"],
        fkPostId: json["fkPostId"],
        chattingUsersId:
            List<String>.from(json["chattingUsersId"].map((x) => x)),
        message: List<ChatMessage>.from(
            json["message"].map((x) => ChatMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fkPostId": fkPostId,
        "chattingUsersId": List<dynamic>.from(chattingUsersId.map((x) => x)),
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class ChatMessage {
  String? fkUserLoginId;
  String? message;
  String? time;
  String? email;
  @override
  String toString() {
    return 'ChatMessage { fkUserLoginId: $fkUserLoginId, message: $message}';
  }

  ChatMessage({
    this.fkUserLoginId,
    this.message,
    this.time,
    this.email,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        fkUserLoginId: json["fkUserLoginId"],
        message: json["message"],
        time: json["Time"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "fkUserLoginId": fkUserLoginId,
        "message": message,
        "Time": time,
        "email": email,
      };
}
