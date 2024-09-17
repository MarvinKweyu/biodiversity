import 'dart:convert';

import 'package:biocountermobile/core/api/api_handler.dart';
import 'package:biocountermobile/core/api/urls.dart';
import 'package:biocountermobile/features/auth/data/models/auth_user_model.dart';
import 'package:biocountermobile/features/auth/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_printer/flutter_printer.dart';

class AuthRepository {
  Future<Map<String, dynamic>> login(
      {required Map<String, dynamic> data}) async {
    try {
      if (kDebugMode) {
        print("Login Data:: $data");
      }

      final response = await ApiHandler.doPost(
        url: Urls.login,
        data: data,
      );

      final payload = jsonDecode(jsonEncode(response.data));

      if (kDebugMode) {
        Printer.printMapJsonLog(
          payload,
          stackTrace: StackTrace.current,
          prefix: "Login Response",
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

  Future<Map<String, dynamic>> registration(
      {required Map<String, dynamic> data}) async {
    try {
      if (kDebugMode) {
        print("Registration Data:: $data");
      }

      final response = await ApiHandler.doPost(
        url: Urls.register,
        data: data,
      );

      final payload = jsonDecode(jsonEncode(response.data));

      if (kDebugMode) {
        Printer.printMapJsonLog(
          payload,
          stackTrace: StackTrace.current,
          prefix: "Sign up Response",
        );
      }

      if (response.statusCode == 201) {
        return {"success": true, "data": payload};
      } else {
        print("payload--> ${payload}");
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

  Future<Map<String, dynamic>> logout(
      {required Map<String, dynamic> data}) async {
    try {
      AuthUser? authUser = await authService.load();
      data["refresh_token"] = authUser?.refresh;

      if (kDebugMode) {
        print("Logout Data::-> $data");
      }

      final response = await ApiHandler.doPost(
        url: Urls.logout,
        data: data,
      );
      final payload = jsonDecode(jsonEncode(response.data));

      if (kDebugMode) {
        Printer.printMapJsonLog(
          payload,
          stackTrace: StackTrace.current,
          prefix: "Logout Response",
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

//
  Future<Map<String, dynamic>> authRefresh({Map<String, dynamic>? data}) async {
    try {
      AuthUser? authUser = await authService.load();
      data!["refresh"] = authUser?.refresh;

      if (kDebugMode) {
        print("Auth Refresh Token Data::-> $data");
      }

      final response = await ApiHandler.doPost(
        url: Urls.authRefresh,
        data: data,
      );

      final payload = jsonDecode(jsonEncode(response.data));

      if (kDebugMode) {
        Printer.printMapJsonLog(
          payload,
          stackTrace: StackTrace.current,
          prefix: "Auth Refresh Response",
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

AuthRepository authRepository = AuthRepository();
