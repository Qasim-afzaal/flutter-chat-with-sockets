import 'dart:convert';

GetAllChat getAllChatFromJson(String str) =>
    GetAllChat.fromJson(json.decode(str));

String getAllChatToJson(GetAllChat data) => json.encode(data.toJson());

class GetAllChat {
  int totalCount;
  String street;
  String folderName;
  List<SharedUser> sharedUsers;
  List<Conversation> conversation;

  GetAllChat({
    required this.totalCount,
    required this.street,
    required this.folderName,
    required this.sharedUsers,
    required this.conversation,
  });

  factory GetAllChat.fromJson(Map<String, dynamic> json) => GetAllChat(
        totalCount: json["totalCount"],
        street: json["street"],
        folderName: json["folder_name"],
        sharedUsers: List<SharedUser>.from(
            json["sharedUsers"].map((x) => SharedUser.fromJson(x))),
        conversation: List<Conversation>.from(
            json["conversation"].map((x) => Conversation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "street": street,
        "folder_name": folderName,
        "sharedUsers": List<dynamic>.from(sharedUsers.map((x) => x.toJson())),
        "conversation": List<dynamic>.from(conversation.map((x) => x.toJson())),
      };
}

class Conversation {
  String id;
  String conversationId;
  String senderId;
  String content;
  DateTime createdAt;
  UserData user;

  Conversation({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    required this.createdAt,
    required this.user,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        id: json["id"],
        conversationId: json["conversation_id"],
        senderId: json["sender_id"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        user: UserData.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "conversation_id": conversationId,
        "sender_id": senderId,
        "content": content,
        "created_at": createdAt.toIso8601String(),
        "user": user.toJson(),
      };
}

class UserData {
  String id;
  String firstname;
  String lastname;
  String profileImageUrl;

  UserData({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.profileImageUrl,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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

class SharedUser {
  String profileImageUrl;

  SharedUser({
    required this.profileImageUrl,
  });

  factory SharedUser.fromJson(Map<String, dynamic> json) => SharedUser(
        profileImageUrl: json["profile_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "profile_image_url": profileImageUrl,
      };
}
