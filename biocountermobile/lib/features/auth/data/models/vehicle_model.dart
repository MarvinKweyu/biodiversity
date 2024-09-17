import 'dart:convert';

import 'package:biocountermobile/features/auth/data/models/auth_user_model.dart';

Vehicle vehicleFromJson(String str) => Vehicle.fromJson(json.decode(str));

String vehicleToJson(Vehicle data) => json.encode(data.toJson());

class Vehicle {
  int? id;
  User? user;
  String? createdAt;
  String? updatedAt;
  String? updatedFlag;
  String? deletedFlag;
  String? deletedAt;
  String? make;
  String? model;
  int? year;
  String? plate;
  String? color;
  String? image;
  int? addedBy;
  int? updatedBy;
  int? deletedBy;

  Vehicle({
    this.id,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.updatedFlag,
    this.deletedFlag,
    this.deletedAt,
    this.make,
    this.model,
    this.year,
    this.plate,
    this.color,
    this.image,
    this.addedBy,
    this.updatedBy,
    this.deletedBy,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        user: User.fromJson(json["user"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        updatedFlag: json["updated_flag"],
        deletedFlag: json["deleted_flag"],
        deletedAt: json["deleted_at"],
        make: json["make"],
        model: json["model"],
        year: json["year"],
        // year: json["year"] is int ? json["year"] : int.parse(json["year"]),
        plate: json["plate"],
        color: json["color"],
        image: json["image"],
        addedBy: json["added_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user!.toJson(),
        "created_at": createdAt,
        "updated_at": updatedAt,
        "updated_flag": updatedFlag,
        "deleted_flag": deletedFlag,
        "deleted_at": deletedAt,
        "make": make,
        "model": model,
        "year": year,
        "plate": plate,
        "color": color,
        "image": image,
        "added_by": addedBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
      };
}
