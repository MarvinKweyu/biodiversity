import 'dart:io';

import 'package:biocountermobile/core/styles.dart';
import 'package:biocountermobile/features/auth/data/models/service_record_model.dart';
import 'package:biocountermobile/features/auth/data/models/vehicle_model.dart';
import 'package:biocountermobile/features/auth/repository/vehicle_repository.dart';
import 'package:biocountermobile/features/auth/services/navigation_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VehicleProvider extends ChangeNotifier {
  void _successToast(String? msg) {
    Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void _errorToast(msg) {
    Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  bool _isAddingVehicleLoading = false;
  bool get isAddingVehicleLoading => _isAddingVehicleLoading;

  Future addNewVehicle(
      {String? make,
      String? model,
      int? year,
      String? numberPlate,
      String? color,
      File? image}) async {
    try {
      _isAddingVehicleLoading = true;
      notifyListeners();

      FormData formData = FormData.fromMap({
        "make": make,
        "model": model,
        "year": year,
        "plate": numberPlate,
        "color": color,
      });

      if (image != null) {
        formData.files.add(
          MapEntry(
            "image",
            await MultipartFile.fromFile(
              image.path,
              filename: "vehicle_image.jpg",
            ),
          ),
        );
      }

      final resp = await vehicleRepository.addNewVehicle(data: formData);

      if (resp["success"]) {
        _successToast("Vehicle was successfully added.");

        Navigate.instance.toRemove("/myCars");

        return resp["success"];
      } else {
        if (kDebugMode) {
          print("resp:: ${resp["error"]}");
        }
        if (resp.containsKey("error") && resp["error"]["error"] != null) {
          _errorToast(resp["error"]["error"]);
        } else {
          _errorToast("Failed to add the vehicle.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while adding the vehicle $e");
      }

      _errorToast("Failed to add the vehicle.");
    } finally {
      _isAddingVehicleLoading = false;
      notifyListeners();
    }
  }

  bool _isFetchingVehicleLoading = false;
  bool get fetchingVehicleLoading => _isFetchingVehicleLoading;

  final List<Vehicle> _vehicleLst = [];
  List<Vehicle> get vehicleLst => _vehicleLst;

  int _numberOfVehicles = 0;
  int get numberOfVehicles => _numberOfVehicles;

  String? _nextPageUrl;

  Future fetchVehicle() async {
    try {
      _isFetchingVehicleLoading = true;
      _numberOfVehicles = 0;
      _vehicleLst.clear();

      final resp = await vehicleRepository.fetchVehicle();

      if (resp["success"]) {
        _vehicleLst.addAll(
          (resp["data"]["results"] as List<dynamic>)
              .map((vehicle) => Vehicle.fromJson(vehicle))
              .toList(),
        );
        _numberOfVehicles = resp["data"]["count"];
        notifyListeners();

        if (resp["data"]["next"] != null) {
          _nextPageUrl = resp["data"]["next"];
        } else {
          _nextPageUrl = null;
        }

        if (kDebugMode) {
          print("Number of Vehicles-----> ${_vehicleLst.length}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while fetching the vehicles $e");
      }
    } finally {
      _isFetchingVehicleLoading = false;
      notifyListeners();
    }
  }

  Future fetchMoreVehicles() async {
    try {
      if (kDebugMode) {
        print("Fetching more Vehicles....");
      }
      if (_nextPageUrl == null) {
        return;
      }
      if (kDebugMode) {
        print("Fetching more Vehicles....");
      }

      _isFetchingVehicleLoading = true;

      final resp = await vehicleRepository.fetchVehicle(
        data: {
          "nextPage": _nextPageUrl,
        },
      );

      if (resp["success"]) {
        _vehicleLst.addAll(
          (resp["data"]["results"] as List<dynamic>)
              .map((vehicle) => Vehicle.fromJson(vehicle))
              .toList(),
        );

        if (resp["data"]["next"] != null) {
          _nextPageUrl = resp["data"]["next"];
        } else {
          _nextPageUrl = null; // No more pages
        }

        if (kDebugMode) {
          print("Number of vehicles-----> ${_vehicleLst.length}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while fetching more vehicles $e");
      }
    } finally {
      _isFetchingVehicleLoading = false;
      notifyListeners();
    }
  }

  bool _isDeletingVehicleLoading = false;
  bool get isDeletingVehicleLoading => _isDeletingVehicleLoading;

  Future deleteVehicle({int? id}) async {
    try {
      _isDeletingVehicleLoading = true;

      final resp = await vehicleRepository.deleteVehicle(
        data: {
          "id": id,
        },
      );

      if (resp["success"]) {
        _successToast("Vehicle was successfully deleted.");

        Navigate.instance.toRemove("/myCars");

        return resp["success"];
      } else {
        _errorToast("Failed to delete the vehicle.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while deleting the vehicle $e");
      }

      _errorToast("Error occurred while deleting the vehicle.");
    } finally {
      _isDeletingVehicleLoading = false;
      notifyListeners();
    }
  }

  bool _isUpdatingVehicleLoading = false;
  bool get isUpdatingVehicleLoading => _isUpdatingVehicleLoading;

  Future updateVehicle({
    int? id,
    String? make,
    String? model,
    int? year,
    String? numberPlate,
    String? color,
    File? image,
  }) async {
    try {
      _isUpdatingVehicleLoading = true;
      notifyListeners();

      FormData formData = FormData.fromMap({
        "make": make,
        "model": model,
        "year": year,
        "plate": numberPlate,
        "color": color,
      });

      if (image != null) {
        formData.files.add(
          MapEntry(
            "image",
            await MultipartFile.fromFile(
              image.path,
              filename: "vehicle_image.jpg",
            ),
          ),
        );
      }

      final resp = await vehicleRepository.updateVehicle(
        data: formData,
        id: id,
      );

      if (resp["success"]) {
        _successToast("Vehicle was successfully updated.");

        return resp["success"];
      } else {
        if (kDebugMode) {
          print("resp:: ${resp["error"]}");
        }
        if (resp.containsKey("error") && resp["error"]["error"] != null) {
          _errorToast(resp["error"]["error"]);
        } else {
          _errorToast("Failed to add the vehicle.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while updating the vehicle $e");
      }

      _errorToast("Failed to update the vehicle.");
    } finally {
      _isUpdatingVehicleLoading = false;
      notifyListeners();
    }
  }

  bool _isAddingNewServiceLoading = false;
  bool get isAddingNewServiceLoading => _isAddingNewServiceLoading;

  Future addNewServiceRecord({
    int? vehicleId,
    List<Map<String, dynamic>>? spareParts,
    List<Map<String, dynamic>>? serviceProcedures,
    String? serviceType,
    String? location,
    List<Map<String, dynamic>>? mechanics,
    String? appointmentDate,
    String? notes,
    String? cost,
  }) async {
    try {
      _isAddingNewServiceLoading = true;
      notifyListeners();

      final resp = await vehicleRepository.addNewServiceRecord(
        data: {
          "vehicle_id": vehicleId,
          "spare_parts": spareParts,
          "service_procedures": serviceProcedures,
          "appointment": {
            "service_type": serviceType,
            "location": location,
            "mechanics": mechanics,
            "appointment_date": appointmentDate,
            "notes": notes,
          },
          "location": location,
          "cost": cost,
        },
      );

      if (resp["success"]) {
        _successToast("Service appointment was successfully added.");

        // Navigate.instance.toRemove("/homeBase");

        return resp["success"];
      } else {
        _errorToast("Failed to add service appointment.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while adding new service record $e");
      }
      _errorToast("Error occurred whiled adding service appointment.");
    } finally {
      _isAddingNewServiceLoading = false;
      notifyListeners();
    }
  }

  bool _isFetchingServiceRecordLoading = false;
  bool get isFetchingServiceRecordLoading => _isFetchingServiceRecordLoading;

  final List<ServiceRecord> _serviceRecordLst = [];
  List<ServiceRecord> get serviceRecordLst => _serviceRecordLst;

  String? _nextServiceRecPageUrl;

  int _numberOfServiceRecords = 0;
  int get numberOfServiceRecords => _numberOfServiceRecords;

  Future fetchServiceRecords() async {
    try {
      _isFetchingServiceRecordLoading = true;
      _numberOfServiceRecords = 0;
      _serviceRecordLst.clear();

      final resp = await vehicleRepository.fetchServiceRecords();

      if (resp["success"]) {
        _serviceRecordLst.addAll(
          (resp["data"]["results"] as List<dynamic>)
              .map((serviceRecord) => ServiceRecord.fromJson(serviceRecord))
              .toList(),
        );
        _numberOfServiceRecords = resp["data"]["count"];
        notifyListeners();

        if (resp["data"]["next"] != null) {
          _nextServiceRecPageUrl = resp["data"]["next"];
        } else {
          _nextServiceRecPageUrl = null;
        }

        if (kDebugMode) {
          print("Number of service records----> ${serviceRecordLst.length}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while fetching the vehicle $e");
      }
    } finally {
      _isFetchingServiceRecordLoading = false;
      notifyListeners();
    }
  }

  Future fetchMoreServiceRecords() async {
    try {
      if (kDebugMode) {
        print("Fetching more Service Records.....");
      }

      if (_nextServiceRecPageUrl == null) {
        return;
      }

      if (kDebugMode) {
        print("Fetching more Service Records.....");
      }

      _isFetchingServiceRecordLoading = true;

      final resp = await vehicleRepository.fetchServiceRecords(
        data: {
          "nextPage": _nextServiceRecPageUrl,
        },
      );

      if (resp["success"]) {
        _serviceRecordLst.addAll(
          (resp["data"]["results"] as List<dynamic>)
              .map((serviceRecord) => ServiceRecord.fromJson(serviceRecord))
              .toList(),
        );

        if (resp["data"]["next"] != null) {
          _nextPageUrl = resp["data"]["next"];
        } else {
          _nextPageUrl = null;
        }

        if (kDebugMode) {
          print("Number of Service Records----> ${_serviceRecordLst.length}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while fetching more service records $e");
      }
    } finally {
      _isFetchingServiceRecordLoading = false;
      notifyListeners();
    }
  }

  bool _isDeletingServiceRecordLoading = false;
  bool get isDeletingServiceRecordLoading => _isDeletingServiceRecordLoading;

  Future deleteServiceRecord({int? id}) async {
    try {
      _isDeletingServiceRecordLoading = true;

      final resp = await vehicleRepository.deleteServiceRecord(
        data: {
          "id": id,
        },
      );

      if (resp["success"]) {
        _successToast("Service Record was successfully deleted.");

        return resp["success"];
      } else {
        _errorToast("Failed to delete service record.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while deleting service record $e");
      }

      _errorToast("Error occurred while deleting service record.");
    } finally {
      _isDeletingServiceRecordLoading = false;
      notifyListeners();
    }
  }

  bool _isFetchingVehicleServiceRecordsLoading = false;
  bool get isFetchingVehicleServiceRecordsLoading =>
      _isFetchingVehicleServiceRecordsLoading;

  final List<ServiceRecord> _vehicleServiceRecordsLst = [];
  List<ServiceRecord> get vehicleServiceRecordsLst => _vehicleServiceRecordsLst;

  String? _nextVehicleServiceRecordUrl;

  Future fetchVehicleServiceRecords({int? vehicleId}) async {
    try {
      _isFetchingVehicleServiceRecordsLoading = true;
      _vehicleServiceRecordsLst.clear();

      final resp = await vehicleRepository.fetchServiceRecordsByVehicleId(
        data: {
          "vehicleId": vehicleId,
        },
      );

      if (resp["success"]) {
        _vehicleServiceRecordsLst.addAll(
          (resp["data"]["results"] as List<dynamic>)
              .map((serviceRecord) => ServiceRecord.fromJson(serviceRecord))
              .toList(),
        );

        if (resp["data"]["next"] != null) {
          _nextPageUrl = resp["data"]["next"];
        } else {
          _nextVehicleServiceRecordUrl = null;
        }

        if (kDebugMode) {
          print(
              "Number of Vehicle service records-----> ${_vehicleServiceRecordsLst.length}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while fetching the vehicle service record $e");
      }
    } finally {
      _isFetchingVehicleServiceRecordsLoading = false;
      notifyListeners();
    }
  }

  Future fetchMoreVehicleServiceRecords() async {
    try {
      if (kDebugMode) {
        print("Fetching more vehicle service records....");
      }

      if (_nextVehicleServiceRecordUrl == null) {
        return;
      }

      if (kDebugMode) {
        print("Fetching more vehicle service records....");
      }
      _isFetchingVehicleServiceRecordsLoading = true;
      final resp = await vehicleRepository.fetchServiceRecordsByVehicleId(
        data: {
          "nextPage": _nextVehicleServiceRecordUrl,
        },
      );

      if (resp["success"]) {
        _vehicleServiceRecordsLst.addAll(
          (resp["data"]["results"] as List<dynamic>)
              .map((serviceRecord) => ServiceRecord.fromJson(serviceRecord))
              .toList(),
        );

        if (resp["data"]["next"] != null) {
          _nextPageUrl = resp["data"]["next"];
        } else {
          _nextPageUrl = null;
        }

        if (kDebugMode) {
          print(
              "Number of Vehicle service record-----> ${_vehicleServiceRecordsLst.length}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while fetching more vehicle service record $e");
      }
    } finally {
      _isFetchingVehicleServiceRecordsLoading = false;
      notifyListeners();
    }
  }

  bool _isUpdatingServiceRecordLoading = false;
  bool get isUpdatingServiceRecordLoading => _isUpdatingServiceRecordLoading;

  Future updateServiceRecord({
    int? id,
    int? vehicleId,
    List<Map<String, dynamic>>? spareParts,
    List<Map<String, dynamic>>? serviceProcedures,
    String? serviceType,
    String? location,
    List<Map<String, dynamic>>? mechanics,
    String? appointmentDate,
    String? notes,
    String? cost,
  }) async {
    try {
      _isUpdatingServiceRecordLoading = true;
      notifyListeners();

      final resp = await vehicleRepository.updateServiceRecord(
        data: {
          "id": id,
          "vehicle_id": vehicleId,
          "spare_parts": spareParts,
          "service_procedures": serviceProcedures,
          "appointment": {
            "service_type": serviceType,
            "location": location,
            "mechanics": mechanics,
            "appointment_date": appointmentDate,
            // "2023-10-23T09:21:52.284Z",
            "notes": notes,
          },
          "location": location,
          "cost": cost,
        },
      );

      if (resp["success"]) {
        _successToast("Service Record was successfully updated");

        return resp["success"];
      } else {
        _errorToast("Failed to update service record");
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while updating service record $e");
      }

      _errorToast("Error occurred while updating the service record");
    } finally {
      _isUpdatingServiceRecordLoading = false;
      notifyListeners();
    }
  }
}

VehicleProvider vehicleProvider = VehicleProvider();
