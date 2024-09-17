import 'package:biocountermobile/core/app_config.dart';

class Urls {
  static var baseURL = AppConfig.appUrl;
  static String login = "${baseURL}account-auth/login/";
  static String register = "${baseURL}account-auth/registration/";
  static String logout = "${baseURL}logout/";
  static String authRefresh = "${baseURL}auth-refresh/";
}
