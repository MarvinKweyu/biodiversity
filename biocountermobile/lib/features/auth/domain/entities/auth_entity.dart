// {  "access": "string",
//   "refresh": "string",
//   "user": {
//     "pk": 0,
//     "email": "user@example.com",
//     "first_name": "string",
//     "last_name": "string"
//   }
// }

import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? name;
  final String email;
  final String password;

  const AuthEntity({
    this.name,
    required this.email,
    required this.password,
  });

  AuthEntity copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return AuthEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [name, email, password];
}
