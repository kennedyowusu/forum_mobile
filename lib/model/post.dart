// To parse this JSON data, do
//
//     final feed = feedFromJson(jsonString);

import 'dart:convert';

FeedResponse feedFromJson(String str) => FeedResponse.fromJson(json.decode(str));

String feedToJson(FeedResponse data) => json.encode(data.toJson());

class FeedResponse {
  FeedResponse({
    required this.feeds,
  });

  List<Feed> feeds;

  factory FeedResponse.fromJson(Map<String, dynamic> json) => FeedResponse(
        feeds: List<Feed>.from(
            json["feeds"].map((x) => Feed.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "feeds": List<dynamic>.from(feeds.map((x) => x.toJson())),
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

  int id;
  String title;
  String description;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  bool liked;
  int likesCount;
  int commentsCount;
  User user;

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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "liked": liked,
        "likes_count": likesCount,
        "comments_count": commentsCount,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String username;
  String email;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
