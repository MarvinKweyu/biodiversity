import 'dart:convert';

import 'package:biocountermobile/core/secure_storage.dart';
import 'package:biocountermobile/features/auth/data/models/auth_result_model.dart';
import 'package:http/http.dart' as http;

abstract class BaseAuthService {
  Future<AuthResultModel> signIn(String email, String password);
  Future<void> signOut();
  Future<AuthResultModel> signUp(String name, String email, String password);
}

class AuthService implements BaseAuthService {
  @override
  Future<AuthResultModel> signIn(String email, String password) async {
    // loginUrl = `${environment.baseUrl}account-auth/login/`
    final resp = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/account-auth/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    if (resp.statusCode == 200) {
      final decodedRes = jsonDecode(resp.body);
      await saveToken(decodedRes['access'], decodedRes['refresh']);
      await saveUser(decodedRes['user']);
      return decodedRes;
    } else {
      throw Exception('Failed to sign in');
    }
  }

  @override
  Future<void> signOut() async {}

  @override
  Future<AuthResultModel> signUp(
      String name, String email, String password) async {
    final resp = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/account-auth/registration/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    if (resp.statusCode == 200) {
      return jsonDecode(resp.body);
    } else {
      throw Exception('Failed to sign up');
    }
  }
}
