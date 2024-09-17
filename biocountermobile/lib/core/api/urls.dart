

import 'package:biocountermobile/core/app_config.dart';

class Urls {
  static var baseURL = AppConfig.appUrl;
// /api/account-auth/registration/
  static String login = "${baseURL}account-auth/login/";
  static String register = "${baseURL}account-auth/registration/";
  static String googleSignin = "${baseURL}google-sign-in/";
  static String logout = "${baseURL}logout/";
  static String authRefresh="${baseURL}auth-refresh/";
  static String carOwnerProfile = "${baseURL}car-owner-profile/";
  static String vehicle = "${baseURL}vehicle/";
  static String serviceRecord = "${baseURL}service-record/";
}
