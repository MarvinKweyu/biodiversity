import 'dart:async';
import 'dart:io';

import 'package:biocountermobile/features/auth/data/models/auth_user_model.dart';
import 'package:biocountermobile/features/auth/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


class ApiHandler {
  static Dio dio = Dio();

  static Future<Response> doPost({
    required String url,
    required dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    AuthUser? authUser = await authService.load();
    if (kDebugMode) {
      print("Api Handler accessToken:-> ${authUser?.access}");
    }

    final response = await dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          "Content-Type": "apdplication/json",
          "Accept": "application/json",
          "Authorization": authUser == null ? '' : 'Token ${authUser.access}',
          ...?headers,
        },
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        receiveTimeout: const Duration(seconds: 3000),
        sendTimeout: const Duration(seconds: 3000),
      ),
    );

    if (response.statusCode == 401) {
      // authService.logout();
    }

    return response;
  }

  static Future<Response> doGet({
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    AuthUser? authUser = await authService.load();
    if (kDebugMode) {
      print("Api Handler accessToken:-> ${authUser?.access}");
    }

    Response response = await dio.get(
      url,
      queryParameters: queryParameters,
      options: Options(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        followRedirects: false,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": authUser == null ? '' : 'Token ${authUser.access}',
          ...?headers,
        },
        validateStatus: (status) {
          return status! < 500;
        },
        receiveTimeout: const Duration(seconds: 3000),
        sendTimeout: const Duration(seconds: 3000),
      ),
    );

    print("Response Data::: ${response.data}");
    print("Response StatusCode:::: ${response.statusCode}");

    if (response.statusCode == 401) {
      // await authProvider.authRefresh();
    }

    return response;
  }

  static Future<Response> doPut({
    required String url,
    required dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    AuthUser? authUser = await authService.load();
    if (kDebugMode) {
      print("Api Handler accessToken:-> ${authUser?.access}");
    }
    Response response = await dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": authUser == null ? '' : 'Token ${authUser.access}',
          ...?headers,
        },
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        receiveTimeout: const Duration(seconds: 3000),
        sendTimeout: const Duration(seconds: 3000),
      ),
    );

    if (response.statusCode == 401) {
      // authService.logout();
    }

    return response;
  }

  static Future<Response> doDelete({
    required String url,
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    AuthUser? authUser = await authService.load();
    if (kDebugMode) {
      print("Api Handler accessToken:-> ${authUser?.access}");
    }

    Response response = await dio.delete(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": authUser == null ? '' : 'Token ${authUser.access}',
          ...?headers,
        },
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        receiveTimeout: const Duration(seconds: 3000),
        sendTimeout: const Duration(seconds: 3000),
      ),
    );

    if (response.statusCode == 401) {
      // authService.logout();
    }

    return response;
  }
}
