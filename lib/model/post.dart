// To parse this JSON data, do
//
// final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    this.id,
    this.title,
    this.description,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.liked,
    this.likesCount,
    this.user,
  });

  int? id = 0;
  String? title = "";
  String? description = "";
  int? userId = 0;
  DateTime? createdAt = DateTime.now();
  DateTime? updatedAt = DateTime.now();
  bool? liked = false;
  int? likesCount = 0;
  User? user = User();

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    liked: json["liked"],
    likesCount: json["likes_count"],
    user: User.fromJson(json["user"]),
  );

Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "user_id": userId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "liked": liked,
    "likes_count": likesCount,
    "user": user!.toJson(),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id = 0;
  String? name = "";
  String? username = "";
  String? email = "";
  DateTime? emailVerifiedAt = DateTime.now();
  DateTime? createdAt = DateTime.now();
  DateTime? updatedAt = DateTime.now();

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
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
