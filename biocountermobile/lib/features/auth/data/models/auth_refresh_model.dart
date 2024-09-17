import 'dart:convert';

AuthRefresh authRefreshFromJson(String str) =>
    AuthRefresh.fromJson(json.decode(str));

String authRefreshToJson(AuthRefresh data) => json.encode(data.toJson());

class AuthRefresh {
  String? access;
  String? refresh;

  AuthRefresh({
    this.access,
    this.refresh,
  });

  factory AuthRefresh.fromJson(Map<String, dynamic> json) => AuthRefresh(
        access: json["access"],
        refresh: json["refresh"],
      );

  Map<String, dynamic> toJson() => {
        "access": access,
        "refresh": refresh,
      };
}
