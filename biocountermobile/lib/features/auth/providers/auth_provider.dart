import 'package:biocountermobile/core/styles.dart';
import 'package:biocountermobile/features/auth/data/models/auth_refresh_model.dart';
import 'package:biocountermobile/features/auth/data/models/auth_user_model.dart';
import 'package:biocountermobile/features/auth/repository/auth_repository.dart';
import 'package:biocountermobile/features/auth/services/auth_service.dart';
import 'package:biocountermobile/features/auth/services/navigation_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthProvider extends ChangeNotifier {
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

  bool _isLoginLoading = false;
  bool get isLoginLoading => _isLoginLoading;

  Future login({String? email, String? password}) async {
    try {
      _isLoginLoading = true;
      notifyListeners();

      final resp = await authRepository
          .login(data: {"email": email, "password": password});

      if (resp["success"]) {
        AuthUser authUser = AuthUser.fromJson(resp["data"]);
        await authService.login(authUser);

        Navigate.instance.toRemove("/homeBase");

        _successToast("Login successful.");

        return authUser;
      } else {
        _errorToast("Invalid Username or Password.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while login $e");
      }

      _errorToast("Failed to Login.");
    } finally {
      _isLoginLoading = false;
      notifyListeners();
    }
  }

  bool _isRegistrationLoading = false;
  bool get isRegistrationLoading => _isRegistrationLoading;

  Future register({String? email, String? name, String? password}) async {
    try {
      _isRegistrationLoading = true;
      notifyListeners();

      final resp = await authRepository.registration(
        data: {
          "email": email,
          "name": name,
          "password1": password,
          "password2": password,
        },
      );
      

      if (resp["success"]) {
        print("resp:: ${resp["data"]}");
        AuthUser registeredUser = AuthUser.fromJson(resp["data"]);
        await authService.signUp(registeredUser);

        Navigate.instance.toRemove("/login");

        _successToast("Sign up successfull.");

        return registeredUser;
      } else {
        if (kDebugMode) {
          print("resp:: ${resp["error"]}");
        }

        if (resp["error"].containsKey("password") &&
            resp["error"]["password"] != null) {
          _errorToast("This password is too common.");
        }
        if (resp.containsKey("error") && resp["error"]["error"] != null) {
          if (resp["error"]["error"] is List) {
            _errorToast(resp["error"]["error"][0]);
          } else {
            _errorToast(resp["error"]["error"]);
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while login $e");
      }

      _errorToast("Failed to Sign up.");
    } finally {
      _isRegistrationLoading = false;
      notifyListeners();
    }
  }

  bool _isSignoutLoading = false;
  bool get isSignoutLoading => _isSignoutLoading;

  Future logout() async {
    try {
      _isSignoutLoading = true;
      notifyListeners();

      final resp = await authRepository.logout(data: {});

      if (resp["success"]) {
        _successToast("Logout successful.");

        return resp["data"];
      } else {
        _errorToast("Failed to Logout.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while signing out $e");
      }

      _errorToast("Can't logout at this moment.");
    } finally {
      _isSignoutLoading = false;
      notifyListeners();
    }
  }

  bool _isAuthRefreshLoading = false;
  bool get isAuthRefreshLoading => _isAuthRefreshLoading;

  Future<void> authRefresh() async {
    try {
      _isAuthRefreshLoading = true;

      final resp = await authRepository.authRefresh();

      if (resp["success"]) {
        AuthRefresh authRefresh = AuthRefresh.fromJson(resp["data"]);

        await authService.updateTokens(authRefresh);

        // return resp["data"];
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while refreshing token $e");
      }
    } finally {
      _isAuthRefreshLoading = false;
      notifyListeners();
    }
  }
}

AuthProvider authProvider = AuthProvider();
