// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final int pk;
  final String email;
  final String firstName;
  final String lastName;

  const UserModel({
    required this.pk,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      pk: json['pk'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pk': pk,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
    };
  }

  UserModel copyWith({
    int? pk,
    String? email,
    String? firstName,
    String? lastName,
  }) {
    return UserModel(
      pk: pk ?? this.pk,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pk': pk,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      pk: map['pk'] as int,
      email: map['email'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(pk: $pk, email: $email, firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.pk == pk &&
        other.email == email &&
        other.firstName == firstName &&
        other.lastName == lastName;
  }

  @override
  int get hashCode {
    return pk.hashCode ^
        email.hashCode ^
        firstName.hashCode ^
        lastName.hashCode;
  }
}
