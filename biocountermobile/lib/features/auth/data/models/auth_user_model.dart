// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

AuthUser authUserFromJson(String str) => AuthUser.fromJson(json.decode(str));

String authUserToJson(AuthUser data) => json.encode(data.toJson());

class AuthUser {
  String? refresh;
  String? access;
  User? user;

  AuthUser({
    this.refresh,
    this.access,
    this.user,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
        refresh: json["refresh"],
        access: json["access"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
        "user": user!.toJson(),
      };
}

class User {
  int? pk;
  String? email;
  String? first_name;
  String? last_name;

  User({
    this.pk,
    this.first_name,
    this.last_name,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        pk: json["pk"],
        first_name: json["last_name"],
        last_name: json["last_name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "first_name": first_name,
        "last_name": last_name,
        "email": email,
      };
}
