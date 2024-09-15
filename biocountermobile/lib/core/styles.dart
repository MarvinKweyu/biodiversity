import 'package:biocountermobile/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class Styles {
  static const Color primaryColor = Color(0xff234055);

  static MaterialColor primarySwatch = const MaterialColor(
      0xff234055,
      <int, Color>{
        50: Color(0xff234055),
        100: Color(0xff234055),
        200: Color(0xff234055),
        300: Color(0xff234055),
        400: Color(0xff234055),
        500: Color(0xff234055),
        600: Color(0xff234055),
        700: Color(0xff234055),
        800: Color(0xff234055),
        900: Color(0xff234055),
      },
    );

  static TextStyle heading1(BuildContext context,
      {Color? fontColor, FontWeight? fontWeight, String? fontFamily}) {
    return TextStyle(
      color: fontColor ?? Colors.black,
      fontSize: Responsive.isTablet(context)
          ? 30
          : (Responsive.isMobileLarge(context) ? 24 : 22),
      fontWeight: fontWeight ?? FontWeight.bold,
      fontFamily: fontFamily ?? "Roboto Regular",
    );
  }

  static TextStyle heading2(BuildContext context,
      {Color? fontColor, FontWeight? fontWeight, String? fontFamily}) {
    return TextStyle(
      color: fontColor ?? Colors.black,
      fontSize: Responsive.isTablet(context)
          ? 27
          : (Responsive.isMobileLarge(context) ? 22 : 20),
      fontWeight: fontWeight ?? FontWeight.bold,
      fontFamily: fontFamily ?? "Roboto Regular",
    );
  }

  static TextStyle heading3(BuildContext context,
      {Color? fontColor, FontWeight? fontWeight, String? fontFamily}) {
    return TextStyle(
      color: fontColor ?? Colors.black,
      fontSize: Responsive.isTablet(context)
          ? 24
          : (Responsive.isMobileLarge(context) ? 20 : 14),
      fontWeight: fontWeight ?? FontWeight.normal,
      fontFamily: fontFamily ?? "Roboto Regular",
    );
  }

  static TextStyle normal(
    BuildContext context, {
    Color? fontColor,
    FontWeight? fontWeight,
    String? fontFamily,
    double? letterSpacing,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      color: fontColor ?? Colors.black,
      fontSize: Responsive.isTablet(context)
          ? 20
          : (Responsive.isMobileLarge(context) ? 18 : 16),
      fontWeight: fontWeight ?? FontWeight.normal,
      fontFamily: fontFamily ?? "Roboto Regular",
      decoration: decoration ?? TextDecoration.none,
    );
  }

  static TextStyle custom16(BuildContext context,
      {Color? fontColor,
      FontWeight? fontWeight,
      String? fontFamily,
      TextDecoration? textDecoration}) {
    return TextStyle(
      color: fontColor ?? Colors.black,
      fontSize: Responsive.isTablet(context)
          ? 18
          : (Responsive.isMobileLarge(context) ? 16 : 14),
      fontWeight: fontWeight ?? FontWeight.normal,
      fontFamily: fontFamily ?? "Roboto Regular",
      decoration: textDecoration ?? TextDecoration.none,
    );
  }

  static TextStyle small(BuildContext context,
      {Color? fontColor, FontWeight? fontWeight, String? fontFamily}) {
    return TextStyle(
      color: fontColor ?? Colors.black,
      fontSize: Responsive.isTablet(context)
          ? 16
          : (Responsive.isMobileLarge(context) ? 14 : 12),
      fontWeight: fontWeight ?? FontWeight.normal,
      fontFamily: fontFamily ?? "Roboto Regular",
    );
  }

  static TextStyle custom12(BuildContext context,
      {Color? fontColor, FontWeight? fontWeight, String? fontFamily}) {
    return TextStyle(
      color: fontColor ?? Colors.black,
      fontSize: Responsive.isTablet(context)
          ? 14
          : (Responsive.isMobileLarge(context) ? 12 : 10),
      fontWeight: fontWeight ?? FontWeight.normal,
      fontFamily: fontFamily ?? "Roboto Regular",
    );
  }

  static double iconSize44(BuildContext context) {
    return Responsive.isTablet(context)
        ? 50
        : (Responsive.isMobileLarge(context) ? 44 : 40);
  }

  static double iconSize28(BuildContext context) {
    return Responsive.isTablet(context)
        ? 34
        : (Responsive.isMobileLarge(context) ? 28 : 24);
  }

  static double iconSize26(BuildContext context) {
    return Responsive.isTablet(context)
        ? 32
        : (Responsive.isMobileLarge(context) ? 26 : 22);
  }

  static double iconSize(BuildContext context) {
    return Responsive.isTablet(context)
        ? 30
        : (Responsive.isMobileLarge(context) ? 24 : 20);
  }

  static double iconSize22(BuildContext context) {
    return Responsive.isTablet(context)
        ? 26
        : (Responsive.isMobileLarge(context) ? 22 : 18);
  }

  static double iconSize20(BuildContext context) {
    return Responsive.isTablet(context)
        ? 24
        : (Responsive.isMobileLarge(context) ? 20 : 16);
  }

  static double iconSize18(BuildContext context) {
    return Responsive.isTablet(context)
        ? 22
        : (Responsive.isMobileLarge(context) ? 18 : 14);
  }

  static double iconSize16(BuildContext context) {
    return Responsive.isTablet(context)
        ? 20
        : (Responsive.isMobileLarge(context) ? 16 : 12);
  }
}
