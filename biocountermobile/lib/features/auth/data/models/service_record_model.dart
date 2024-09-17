import 'dart:convert';

import 'package:biocountermobile/features/auth/data/models/vehicle_model.dart';



ServiceRecord serviceRecordFromJson(String str) =>
    ServiceRecord.fromJson(json.decode(str));

String serviceRecordToJson(ServiceRecord data) => json.encode(data.toJson());

class ServiceRecord {
  int? id;
  List<Spareparts>? spareParts;
  List<ServiceProcedure>? serviceProcedures;
  Appointment? appointment;
  String? location;
  String? createdAt;
  String? updatedAt;
  String? updatedFlag;
  String? deletedFlag;
  String? deletedAt;
  String? cost;
  int? addedBy;
  int? updatedBy;
  int? deletedBy;

  ServiceRecord({
    this.id,
    this.spareParts,
    this.serviceProcedures,
    this.appointment,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.updatedFlag,
    this.deletedFlag,
    this.deletedAt,
    this.cost,
    this.addedBy,
    this.updatedBy,
    this.deletedBy,
  });

  factory ServiceRecord.fromJson(Map<String, dynamic> json) => ServiceRecord(
        id: json["id"],
        spareParts: List<Spareparts>.from(
            json["spare_parts"].map((x) => Spareparts.fromJson(x))),
        serviceProcedures: List<ServiceProcedure>.from(
            json["service_procedures"]
                .map((x) => ServiceProcedure.fromJson(x))),
        appointment: Appointment.fromJson(json["appointment"]),
        location: json["location"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        updatedFlag: json["updated_flag"],
        deletedFlag: json["deleted_flag"],
        deletedAt: json["deleted_at"],
        cost: json["cost"],
        addedBy: json["added_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "spare_parts": List<dynamic>.from(spareParts!.map((x) => x.toJson())),
        "service_procedures":
            List<dynamic>.from(serviceProcedures!.map((x) => x.toJson())),
        "appointment": appointment,
        "location": location,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "updated_flag": updatedFlag,
        "deleted_flag": deletedFlag,
        "deleted_at": deletedAt,
        "cost": cost,
        "added_by": addedBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
      };
}

class Appointment {
  int? id;
  Vehicle? vehicle;
  String? serviceType;
  String? location;
  List<ServiceProcedure>? mechanics;
  String? createdAt;
  String? updatedAt;
  String? updatedFlag;
  String? deletedFlag;
  String? deletedAt;
  String? appointmentId;
  String? appointmentDate;
  String? notes;
  int? addedBy;
  int? updatedBy;
  int? deletedBy;

  Appointment({
    this.id,
    this.vehicle,
    this.serviceType,
    this.location,
    this.mechanics,
    this.createdAt,
    this.updatedAt,
    this.updatedFlag,
    this.deletedFlag,
    this.deletedAt,
    this.appointmentId,
    this.appointmentDate,
    this.notes,
    this.addedBy,
    this.updatedBy,
    this.deletedBy,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json["id"],
        vehicle: Vehicle.fromJson(json["vehicle"]),
        serviceType: json["service_type"],
        location: json["location"],
        mechanics: List<ServiceProcedure>.from(
            json["mechanics"].map((x) => ServiceProcedure.fromJson(x))),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        updatedFlag: json["updated_flag"],
        deletedFlag: json["deleted_flag"],
        deletedAt: json["deleted_at"],
        appointmentId: json["appointment_id"],
        appointmentDate: json["appointment_date"],
        notes: json["notes"],
        addedBy: json["added_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicle": vehicle!.toJson(),
        "service_type": serviceType,
        "location": location,
        "mechanics": List<dynamic>.from(mechanics!.map((x) => x.toJson())),
        "created_at": createdAt,
        "updated_at": updatedAt,
        "updated_flag": updatedFlag,
        "deleted_flag": deletedFlag,
        "deleted_at": deletedAt,
        "appointment_date": appointmentDate,
        "appointment_id": appointmentId,
        "notes": notes,
        "added_by": addedBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
      };
}

class Spareparts {
  int? id;
  String? name;
  String? phoneNo;
  String? createdAt;
  String? updatedAt;
  String? updatedFlag;
  String? deletedFlag;
  String? deletedAt;
  int? addedBy;
  int? updatedBy;
  int? deletedBy;
  String? price;
  int? quantity;

  Spareparts({
    this.id,
    this.name,
    this.phoneNo,
    this.createdAt,
    this.updatedAt,
    this.updatedFlag,
    this.deletedFlag,
    this.deletedAt,
    this.addedBy,
    this.updatedBy,
    this.deletedBy,
    this.price,
    this.quantity,
  });

  factory Spareparts.fromJson(Map<String, dynamic> json) => Spareparts(
        id: json["id"],
        name: json["name"],
        phoneNo: json["phone_no"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        updatedFlag: json["updated_flag"],
        deletedFlag: json["deleted_flag"],
        deletedAt: json["deleted_at"],
        addedBy: json["added_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
        price: json["price"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_no": phoneNo,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "updated_flag": updatedFlag,
        "deleted_flag": deletedFlag,
        "deleted_at": deletedAt,
        "added_by": addedBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
        "price": price,
        "quantity": quantity,
      };
}

class ServiceProcedure {
  int? id;
  String? name;
  String? phoneNo;
  String? createdAt;
  String? updatedAt;
  String? updatedFlag;
  String? deletedFlag;
  String? deletedAt;
  int? addedBy;
  int? updatedBy;
  int? deletedBy;
  String? price;

  ServiceProcedure({
    this.id,
    this.name,
    this.phoneNo,
    this.createdAt,
    this.updatedAt,
    this.updatedFlag,
    this.deletedFlag,
    this.deletedAt,
    this.addedBy,
    this.updatedBy,
    this.deletedBy,
    this.price,
  });

  factory ServiceProcedure.fromJson(Map<String, dynamic> json) =>
      ServiceProcedure(
        id: json["id"],
        name: json["name"],
        phoneNo: json["phone_no"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        updatedFlag: json["updated_flag"],
        deletedFlag: json["deleted_flag"],
        deletedAt: json["deleted_at"],
        addedBy: json["added_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_no": phoneNo,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "updated_flag": updatedFlag,
        "deleted_flag": deletedFlag,
        "deleted_at": deletedAt,
        "added_by": addedBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
        "price": price,
      };
}
