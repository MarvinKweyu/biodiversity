import 'dart:convert';

import 'package:biocountermobile/core/utils/shared_preference.dart';
import 'package:biocountermobile/features/auth/data/models/auth_refresh_model.dart';
import 'package:biocountermobile/features/auth/data/models/auth_user_model.dart';
import 'package:biocountermobile/features/auth/data/models/user_profile_model.dart';
import 'package:biocountermobile/features/auth/providers/auth_provider.dart';
import 'package:biocountermobile/features/auth/services/navigation_service.dart';

class AuthService {
  Future login(AuthUser authUser) async {
    await sharedPreferences.removePreference("authUser");
    await sharedPreferences.setPreference(
      "authUser",
      jsonEncode(authUser),
    );

    return;
  }

  Future signUp(AuthUser authUser) async {
    await sharedPreferences.removePreference("registeredUser");
    await sharedPreferences.setPreference(
      "registeredUser",
      jsonEncode(authUser),
    );

    return;
  }

  Future loadSignUp() async {
    String? signedUpUserString =
        await sharedPreferences.getPreference("registeredUser");

    if (signedUpUserString != null) {
      AuthUser authUser = AuthUser.fromJson(jsonDecode(signedUpUserString));
      return authUser;
    }

    return;
  }

  Future load() async {
    String? authUserString = await sharedPreferences.getPreference("authUser");

    if (authUserString != null) {
      AuthUser authUser = AuthUser.fromJson(jsonDecode(authUserString));
      return authUser;
    }

    return;
  }

  Future updateTokens(AuthRefresh authRefresh) async {
    AuthUser? authUser = await load();
    if (authUser != null) {
      authUser.access = authRefresh.access;
      authUser.refresh = authRefresh.refresh;
      await sharedPreferences.setPreference(
        "authUser",
        jsonEncode(authUser),
      );
    }
  }

  Future logout() async {
    await authProvider.logout();
    await sharedPreferences.removePreference("authUser");
    await sharedPreferences.removePreference("registeredUser");

    Navigate.instance.toRemove("/login");
  }

  Future userProfile(UserProfile userProfile) async {
    await sharedPreferences.removePreference("userProfile");
    await sharedPreferences.setPreference(
      "userProfile",
      jsonEncode(userProfile),
    );
  }

  Future loadUserProfile() async {
    String? userProfileString =
        await sharedPreferences.getPreference("userProfile");

    if (userProfileString != null) {
      UserProfile userProfile =
          UserProfile.fromJson(jsonDecode(userProfileString));
      return userProfile;
    }

    return;
  }
}

AuthService authService = AuthService();
