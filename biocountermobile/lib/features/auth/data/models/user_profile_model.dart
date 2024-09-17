// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

import 'package:biocountermobile/features/auth/data/models/auth_user_model.dart';


UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
    int? id;
    User? user;
    String? profileImage;
    String? bio;
    String? gender;
    String? dateOfBirth;
    String? address;

    UserProfile({
         this.id,
         this.user,
         this.profileImage,
         this.bio,
         this.gender,
         this.dateOfBirth,
         this.address,
    });

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        user: User.fromJson(json["user"]),
        profileImage: json["profile_image"],
        bio: json["bio"],
        gender: json["gender"],
        dateOfBirth: json["date_of_birth"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user!.toJson(),
        "profile_image": profileImage,
        "bio": bio,
        "gender": gender,
        "date_of_birth": dateOfBirth,
        "address": address,
    };
}


