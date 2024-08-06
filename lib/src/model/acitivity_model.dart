import 'dart:convert';

ActivtyLogsModel activtyLogsModelFromJson(String str) =>
    ActivtyLogsModel.fromJson(json.decode(str));

String activtyLogsModelToJson(ActivtyLogsModel data) =>
    json.encode(data.toJson());

class ActivtyLogsModel {
  bool success;
  String message;
  Data? data;

  ActivtyLogsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ActivtyLogsModel.fromJson(Map<String, dynamic> json) =>
      ActivtyLogsModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  List<Notification> notifications;
  int totalCount;

  Data({
    required this.notifications,
    required this.totalCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        notifications: List<Notification>.from(
            json["notifications"].map((x) => Notification.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toJson())),
        "totalCount": totalCount,
      };
}

class Notification {
  String id;
  String body;
  String? propertyId;
  String? folderId;
  String? connectionInviteId;
  String notiType;
  bool readStatus;
  DateTime createdAt;
  Folder? folder;
  ConnectionInvite? connectionInvite;
  FromUser? fromUser;

  Notification({
    required this.id,
    required this.body,
    required this.propertyId,
    required this.folderId,
    required this.connectionInviteId,
    required this.notiType,
    required this.readStatus,
    required this.createdAt,
    required this.folder,
    required this.connectionInvite,
    required this.fromUser,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        body: json["body"],
        propertyId: json["property_id"],
        folderId: json["folder_id"],
        connectionInviteId: json["connection_invite_id"],
        notiType: json["noti_type"],
        readStatus: json["read_status"],
        createdAt: DateTime.parse(json["created_at"]),
        folder: json["folder"] == null ? null : Folder.fromJson(json["folder"]),
        connectionInvite: json["connection_invite"] == null
            ? null
            : ConnectionInvite.fromJson(json["connection_invite"]),
        fromUser: json["from_user"] == null
            ? null
            : FromUser.fromJson(json["from_user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "property_id": propertyId,
        "folder_id": folderId,
        "connection_invite_id": connectionInviteId,
        "noti_type": notiType,
        "read_status": readStatus,
        "created_at": createdAt.toIso8601String(),
        "folder": folder?.toJson(),
        "connection_invite": connectionInvite?.toJson(),
        "from_user": fromUser?.toJson(),
      };
}

class Folder {
  String name;

  Folder({
    required this.name,
  });

  factory Folder.fromJson(Map<String, dynamic> json) => Folder(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class ConnectionInvite {
  String? acceptedOn;

  ConnectionInvite({
    required this.acceptedOn,
  });

  factory ConnectionInvite.fromJson(Map<String, dynamic> json) =>
      ConnectionInvite(
        acceptedOn: json["accepted_on"],
      );

  Map<String, dynamic> toJson() => {
        "accepted_on": acceptedOn,
      };
}

class FromUser {
  String firstname;
  String lastname;
  String? profileImageUrl;

  FromUser({
    required this.firstname,
    required this.lastname,
    required this.profileImageUrl,
  });

  factory FromUser.fromJson(Map<String, dynamic> json) => FromUser(
        firstname: json["firstname"],
        lastname: json["lastname"],
        profileImageUrl: json["profile_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "profile_image_url": profileImageUrl,
      };
}
