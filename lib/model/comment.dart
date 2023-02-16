// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  Comment({
    required this.id,
    required this.userId,
    required this.feedId,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.feed,
  });

  int? id;
  int? userId;
  int? feedId;
  String? body;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  Feed? feed;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        userId: json["user_id"],
        feedId: json["feed_id"],
        body: json["body"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
        feed: Feed.fromJson(json["feed"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "feed_id": feedId,
        "body": body,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "user": user!.toJson(),
        "feed": feed!.toJson(),
      };
}

class Feed {
  Feed({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.liked,
    required this.likesCount,
    required this.commentsCount,
    required this.user,
  });

  int? id;
  String? title;
  String? description;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? liked;
  int? likesCount;
  int? commentsCount;
  User? user;

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        liked: json["liked"],
        likesCount: json["likes_count"],
        commentsCount: json["comments_count"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "user_id": userId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "liked": liked,
        "likes_count": likesCount,
        "comments_count": commentsCount,
        "user": user!.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  String? name;
  String? username;
  String? email;
  DateTime? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "email_verified_at": emailVerifiedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
