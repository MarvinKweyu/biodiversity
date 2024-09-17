// {  "access": "string",
//   "refresh": "string",
//   "user": {
//     "pk": 0,
//     "email": "user@example.com",
//     "first_name": "string",
//     "last_name": "string"
//   }
// }
import 'package:biocountermobile/features/auth/data/models/user_model.dart';

class AuthResultModel {
  final String access;
  final String refresh;
  final UserModel user;

  AuthResultModel({
    required this.access,
    required this.refresh,
    required this.user,
  });

  factory AuthResultModel.fromJson(Map<String, dynamic> json) {
    return AuthResultModel(
      access: json['access'],
      refresh: json['refresh'],
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access': access,
      'refresh': refresh,
      'user': user.toJson(),
    };
  }
}