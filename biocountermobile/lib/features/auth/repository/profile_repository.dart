import 'dart:convert';

import 'package:biocountermobile/core/api/api_handler.dart';
import 'package:biocountermobile/core/api/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_printer/flutter_printer.dart';

class ProfileRepository {
  Future<Map<String, dynamic>> carOwnerProfile() async {
    try {
      final response = await ApiHandler.doGet(url: Urls.carOwnerProfile);

      final payload = jsonDecode(jsonEncode(response.data));

      if (kDebugMode) {
        Printer.printMapJsonLog(
          payload,
          stackTrace: StackTrace.current,
          prefix: "Google Sign In Response",
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

  Future<Map<String, dynamic>> updateCarOwnerProfile(
      {Map<String, dynamic>? data}) async {
    try {
      if (kDebugMode) {
        print("Car owner Profile Update data:::--> $data");
      }
      int? id = data!.remove("id");

      final response = await ApiHandler.doPut(
        url: "${Urls.carOwnerProfile}$id/",
        data: data,
      );

      final payload = jsonDecode(jsonEncode(response.data));

      if (kDebugMode) {
        Printer.printMapJsonLog(
          payload,
          stackTrace: StackTrace.current,
          prefix: "Profile Update Response",
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

  Future<Map<String, dynamic>> updateCarOwnerProfilePicture(
      {required FormData data, int? id}) async {
    try {
      if (kDebugMode) {
        print("Car owner Profile Picture Update data:::--> $data");
      }

      final response = await ApiHandler.doPut(
        url: "${Urls.carOwnerProfile}$id/",
        data: data,
      );

      final payload = jsonDecode(jsonEncode(response.data));

      if (kDebugMode) {
        Printer.printMapJsonLog(
          payload,
          stackTrace: StackTrace.current,
          prefix: "Profile Picture Update Response",
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

ProfileRepository profileRepository = ProfileRepository();
