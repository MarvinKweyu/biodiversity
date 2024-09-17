import 'package:biocountermobile/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

defaultPadding(BuildContext context) {
  return MediaQuery.of(context).size.width /
      100 *
      (Responsive.isTablet(context) ? 3 : (Responsive.isTall(context) ? 4 : 3));
}

double defaultRadius = 10;

const defaultDuration = Duration(seconds: 1);
screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}


const String signUpScreen = 'signup';
const String loginScreen = 'login';
const String homeScreen = 'home';
