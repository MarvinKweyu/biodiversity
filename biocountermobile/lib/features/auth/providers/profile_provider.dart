import 'dart:convert';
import 'dart:io';

import 'package:biocountermobile/core/styles.dart';
import 'package:biocountermobile/features/auth/data/models/user_profile_model.dart';
import 'package:biocountermobile/features/auth/repository/profile_repository.dart';
import 'package:biocountermobile/features/auth/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileProvider extends ChangeNotifier {
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

  bool _isCarOwnerProfileLoading = false;
  bool get isCarOwnerProfileLoading => _isCarOwnerProfileLoading;

  UserProfile _userProfile = UserProfile();
  UserProfile get userProfile => _userProfile;

  Future fetchCarOwnerProfile() async {
    try {
      _isCarOwnerProfileLoading = true;
      _userProfile = UserProfile();

      final resp = await profileRepository.carOwnerProfile();

      if (resp["success"]) {
        _userProfile = UserProfile.fromJson(resp['data']['results'][0]);
        await authService.userProfile(_userProfile);
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while fetching car owner profile $e");
      }
    } finally {
      _isCarOwnerProfileLoading = false;
      notifyListeners();
    }
  }

  bool _isUpdatingProfileLoading = false;
  bool get isUpdatingProfileLoading => _isUpdatingProfileLoading;

  Future updateCarOwnerProfilePicture({
    int? id,
    String? name,
    String? phoneNo,
    String? bio,
    File? profileImage,
  }) async {
    try {
      _isUpdatingProfileLoading = true;
      notifyListeners();

      Map<String, dynamic> userMap = {
        "name": name ?? "",
        "phone_no": phoneNo ?? "",
      };

      Map<String, dynamic> data = {
        "user": userMap,
        "bio": bio,
      };

      FormData formData = FormData.fromMap(data);

      if (profileImage != null) {
        formData.files.add(
          MapEntry(
            "profile_image",
            await MultipartFile.fromFile(
              profileImage.path,
              filename: "profile_image.jpg",
            ),
          ),
        );
      }

      final resp = await profileRepository.updateCarOwnerProfilePicture(
        data: formData,
        id: id,
      );

      if (resp["success"]) {
        _successToast("Profile picture was successfully updated.");

        return resp["success"];
      } else {
        _errorToast("Failed to update the profile image.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while updating the car owner profile image $e");
      }

      _errorToast("Error occurred while updating profile image.");
    } finally {
      _isUpdatingProfileLoading = false;
      notifyListeners();
    }
  }

  Future updateCarOwnerProfile({
    int? id,
    String? name,
    String? phoneNo,
    String? bio,
  }) async {
    try {
      _isUpdatingProfileLoading = true;
      notifyListeners();

      final resp = await profileRepository.updateCarOwnerProfile(
        data: {
          "id": id,
          "user": {
            "name": name,
            "phone_no": phoneNo,
          },
          "bio": bio,
        },
      );

      if (resp["success"]) {
        _successToast("Profile was successfully updated.");

        return resp["success"];
      } else {
        _errorToast("Failed to update the vehicle.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while updating the car owner profile $e");
      }

      _errorToast("Error occurred while updating profile.");
    } finally {
      _isUpdatingProfileLoading = false;
      notifyListeners();
    }
  }
}

ProfileProvider profileProvider = ProfileProvider();
