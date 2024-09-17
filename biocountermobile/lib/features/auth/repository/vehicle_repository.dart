import 'dart:convert';

import 'package:biocountermobile/core/api/api_handler.dart';
import 'package:biocountermobile/core/api/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_printer/flutter_printer.dart';


class VehicleRepository {
  Future<Map<String, dynamic>> addNewVehicle({required FormData data}) async {
    try {
      if (kDebugMode) {
        print("Add Vehicle Data::-> $data");
      }

      final response = await ApiHandler.doPost(url: Urls.vehicle, data: data);

      final payload = jsonDecode(jsonEncode(response.data));

      if (kDebugMode) {
        Printer.printMapJsonLog(
          payload,
          stackTrace: StackTrace.current,
          prefix: "New Vehicle Response",
        );
      }

      if (response.statusCode == 201) {
        return {"success": true, "data": payload};
      } else {
        return {"success": false, "error": payload};
      }
    } catch (e) {
      if (e is DioException) {
        if (kDebugMode) {
          print(e.response);
          print(e.type);
        }
      }

      if (kDebugMode) {
        print(e.toString());
      }

      return {"success": false, "error": e.toString()};
    }
  }

  Future<Map<String, dynamic>> fetchVehicle(
      {Map<String, dynamic>? data}) async {
    try {
      if (kDebugMode) {
        print("Fetch Vehicles Data::::---> $data");
      }

      final nextPage = data?["nextPage"];

      final response = await ApiHandler.doGet(
        url: nextPage ?? Urls.vehicle,
      );

      final payload = jsonDecode(jsonEncode(response.data));

      if (kDebugMode) {
        Printer.printMapJsonLog(
          payload,
          stackTrace: StackTrace.current,
          prefix: "Fetch Vehicle Response",
        );
      }

      if (response.statusCode == 200) {
        return {"success": true, "data": payload};
      } else {
        return {"success": false, "error": payload["message"]};
      }
    } catch (e) {
      if (e is DioException) {
        if (kDebugMode) {
          print(e.response);
          print(e.type);
        }
      }

      if (kDebugMode) {
        print(e.toString());
      }

      return {"success": false, "error": e.toString()};
    }
  }

  Future<Map<String, dynamic>> deleteVehicle(
      {Map<String, dynamic>? data}) async {
    try {
      if (kDebugMode) {
        print("Delete vehicle Data::-> $data");
      }

      var vehicleId = data!["id"];

      final response = await ApiHandler.doDelete(
        url: "${Urls.vehicle}$vehicleId/",
      );

      final payload = jsonDecode(jsonEncode(response.data));

      if (kDebugMode) {
        Printer.printMapJsonLog(
          payload,
          stackTrace: StackTrace.current,
          prefix: "Delete Vehicle Response",
        );
      }

      if (response.statusCode == 204) {
        return {"success": true, "data": payload};
      } else {
        return {"success": false, "error": payload["message"]};
      }
    } catch (e) {
      if (e is DioException) {
        if (kDebugMode) {
          print(e.response);
          print(e.type);
        }
      }

      if (kDebugMode) {
        print(e.toString());
      }

      return {"success": false, "error": e.toString()};
    }
  }

  Future<Map<String, dynamic>> updateVehicle(
      {required FormData data, int? id}) async {
    try {
      if (kDebugMode) {
        print("Delete vehicle Data::-> $data");
      }

      final response = await ApiHandler.doPut(
        url: "${Urls.vehicle}$id/",
        data: data,
      );

      final payload = jsonDecode(jsonEncode(response.data));

      if (kDebugMode) {
        Printer.printMapJsonLog(
          payload,
          stackTrace: StackTrace.current,
          prefix: "Vehicle Update Response",
        );
      }

      if (response.statusCode == 200) {
        return {"success": true, "data": payload};
      } else {
        return {"success": false, "error": payload};
      }
    } catch (e) {
      if (e is DioException) {
        if (kDebugMode) {
          print(e.response);
          print(e.type);
        }
      }

      if (kDebugMode) {
        print(e.toString());
      }

      return {"success": false, "error": e.toString()};
    }
  }

  Future<Map<String, dynamic>> addNewServiceRecord({
    required Map<String, dynamic>? data,
  }) async {
    try {
      if (kDebugMode) {
        print("Add Service Record::--> $data");
      }

      final response = await ApiHandler.doPost(
        url: Urls.serviceRecord,
        data: data,
      );

      final payload = jsonDecode(jsonEncode(response.data));

      if (kDebugMode) {
        Printer.printMapJsonLog(
          payload,
          stackTrace: StackTrace.current,
          prefix: "New Service Record",
        );
      }
      if (response.statusCode == 201) {
        return {"success": true, "data": payload};
      } else {
        return {"success": false, "error": payload["message"]};
      }
    } catch (e) {
      if (e is DioException) {
        if (kDebugMode) {
          print(e.response);
          print(e.type);
        }
      }

      if (kDebugMode) {
        print(e.toString());
      }

      return {"success": false, "error": e.toString()};
    }
  }

  Future<Map<String, dynamic>> fetchServiceRecords(
      {Map<String, dynamic>? data}) async {
    try {
      if (kDebugMode) {
        print("Fetch Service Records Data::::---> $data");
      }

      final nextPage = data?["nextPage"];

      final response = await ApiHandler.doGet(
        url: nextPage ?? Urls.serviceRecord,
      );
      final payload = jsonDecode(jsonEncode(response.data));

      if (kDebugMode) {
        Printer.printMapJsonLog(
          payload,
          stackTrace: StackTrace.current,
          prefix: "Service Record Response",
        );
      }

      if (response.statusCode == 200) {
        return {"success": true, "data": payload};
      } else {
        return {"success": false, "error": payload["message"]};
      }
    } catch (e) {
      if (e is DioException) {
        if (kDebugMode) {
          print(e.response);
          print(e.type);
        }
      }

      if (kDebugMode) {
        print(e.toString());
      }

      return {"success": false, "error": e.toString()};
    }
  }

  Future<Map<String, dynamic>> deleteServiceRecord({
    Map<String, dynamic>? data,
  }) async {
    try {
      if (kDebugMode) {
        print("Delete service record data::-> $data");
      }

      var serviceRecordId = data!["id"];

      final response = await ApiHandler.doDelete(
        url: "${Urls.serviceRecord}$serviceRecordId/",
      );

      final payload = jsonDecode(jsonEncode(response.data));

      if (kDebugMode) {
        Printer.printMapJsonLog(
          payload,
          stackTrace: StackTrace.current,
          prefix: "Delete Service Record Response",
        );
      }

      if (response.statusCode == 204) {
        return {"success": true, "data": payload};
      } else {
        return {"success": false, "error": payload["message"]};
      }
    } catch (e) {
      if (e is DioException) {
        if (kDebugMode) {
          print(e.response);
          print(e.type);
        }
      }

      if (kDebugMode) {
        print(e.toString());
      }

      return {"success": false, "error": e.toString()};
    }
  }

  Future<Map<String, dynamic>> fetchServiceRecordsByVehicleId(
      {Map<String, dynamic>? data}) async {
    try {
      if (kDebugMode) {
        print("Fetch Service Records by Vehicle Id Data:::::---> $data");
      }

      final nextPage = data?["nextPage"];
      final vehicleId = data!.remove("vehicleId");

      final response = await ApiHandler.doGet(
        url: nextPage ?? "${Urls.serviceRecord}get_by_vehicle_id/$vehicleId/",
      );

      final payload = jsonDecode(jsonEncode(response.data));

      if (kDebugMode) {
        Printer.printMapJsonLog(
          payload,
          stackTrace: StackTrace.current,
          prefix: "Fetch Service Record By Vehicle Id Response",
        );
      }

      if (response.statusCode == 200) {
        return {"success": true, "data": payload};
      } else {
        return {"success": false, "error": payload["message"]};
      }
    } catch (e) {
      if (e is DioException) {
        if (kDebugMode) {
          print(e.response);
          print(e.type);
        }
      }

      if (kDebugMode) {
        print(e.toString());
      }

      return {"success": false, "error": e.toString()};
    }
  }

  Future<Map<String, dynamic>> updateServiceRecord({
    required Map<String, dynamic>? data,
  }) async {
    try {
      if (kDebugMode) {
        print("Service Record update data::::----> $data");
      }

      var serviceRecordId = data!["id"];

      final response = await ApiHandler.doPut(
        url: "${Urls.serviceRecord}$serviceRecordId/",
        data: data,
      );

      final payload = jsonDecode(jsonEncode(response.data));

      if (kDebugMode) {
        Printer.printMapJsonLog(
          payload,
          stackTrace: StackTrace.current,
          prefix: "Service Record Update Response",
        );
      }

      if (response.statusCode == 200) {
        return {"success": true, "data": payload};
      } else {
        return {"success": false, "error": payload["message"]};
      }
    } catch (e) {
      if (e is DioException) {
        if (kDebugMode) {
          print(e.response);
          print(e.type);
        }
      }

      if (kDebugMode) {
        print(e.toString());
      }

      return {"success": false, "error": e.toString()};
    }
  }
}

VehicleRepository vehicleRepository = VehicleRepository();
