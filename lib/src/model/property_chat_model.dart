import 'dart:convert';

PropertyChatModel propertyChatModelFromJson(String str) => PropertyChatModel.fromJson(json.decode(str));

String propertyChatModelToJson(PropertyChatModel data) => json.encode(data.toJson());

class PropertyChatModel {
    bool success;
    String message;
    List<NotificationData> data;

    PropertyChatModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory PropertyChatModel.fromJson(Map<String, dynamic> json) => PropertyChatModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] != null ? List<NotificationData>.from(json["data"].map((x) => NotificationData.fromJson(x))) : [],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class NotificationData {
    String id;
    String conversationId;
    String content;
    DateTime createdAt;
    User user;

    NotificationData({
        required this.id,
        required this.conversationId,
        required this.content,
        required this.createdAt,
        required this.user,
    });

    factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
        id: json["id"],
        conversationId: json["conversation_id"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "conversation_id": conversationId,
        "content": content,
        "created_at": createdAt.toIso8601String(),
        "user": user.toJson(),
    };
}

class User {
    String id;
    String firstname;
    String lastname;
    String profileImageUrl;

    User({
        required this.id,
        required this.firstname,
        required this.lastname,
        required this.profileImageUrl,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        profileImageUrl: json["profile_image_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "profile_image_url": profileImageUrl,
    };
}
