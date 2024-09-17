import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static const String introKey = "intro";

  Future<void> removePref(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.remove(key);
  }

  Future<bool> setIntro(bool intro) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.setBool(introKey, intro);
  }

  Future<bool?> getIntro() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getBool(introKey);
  }

  Future setPreference(String key, String value) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString(key, value);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future getPreference(String key) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String response = pref.getString(key)!;
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<bool> removePreference(String key) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      bool done = await pref.remove(key);

      return done;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }
}

AppSharedPreferences sharedPreferences = AppSharedPreferences();
