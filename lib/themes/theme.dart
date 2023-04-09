// Copyright (c) 2020 Aniket Malik [aniketmalikwork@gmail.com]
// All Rights Reserved.
//
// NOTICE: All information contained herein is, and remains the
// property of Aniket Malik. The intellectual and technical concepts
// contained herein are proprietary to Aniket Malik and are protected
// by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material
// is strictly forbidden unless prior written permission is obtained from
// Aniket Malik.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'themeGuide.dart';

export 'colors.dart';
export 'gradients.dart';
export 'themeGuide.dart';

abstract class CustomTheme {
  // Error Color common to both Themes
  static const Color _cursorColor = AppColors.primary;

  // Contains the information about the light theme
  static ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.mWhite,
      background: Colors.white,
      brightness: Brightness.light,
    ),
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.primary.withAlpha(150),
    splashColor: AppColors.backgroundLight,
    highlightColor: AppColors.backgroundLight,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    toggleableActiveColor: AppColors.accent,
    dividerColor: const Color.fromARGB(255, 230, 230, 230),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: _cursorColor),
    sliderTheme: SliderThemeData(
      thumbColor: AppColors.accent,
      activeTrackColor: AppColors.accent.withAlpha(180),
      activeTickMarkColor: AppColors.primary,
      inactiveTrackColor: AppColors.accent.withAlpha(100),
      inactiveTickMarkColor: AppColors.primary,
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      color: AppColors.backgroundLight,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    iconTheme: const IconThemeData(color: Colors.black87),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: ThemeGuide.borderRadius,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.accent,
        backgroundColor: AppColors.accent.withAlpha(20),
        side: const BorderSide(width: 0, color: Colors.transparent),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFEEEEEE),
      contentPadding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: AppColors.accent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: AppColors.accent),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: Colors.red),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: Colors.transparent),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: Colors.transparent),
      ),
      errorMaxLines: 3,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w600,
      ),
      errorStyle: TextStyle(
        fontWeight: FontWeight.w600,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.mWhite,
      highlightColor: AppColors.buttonHighlightColor,
      splashColor: AppColors.buttonSplashColor,
      disabledColor: AppColors.mDisabledColor,
      padding: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: ThemeGuide.borderRadius,
        side: BorderSide(
          width: 2,
          color: AppColors.accent,
        ),
      ),
    ),
    textTheme: ThemeData.light().textTheme.copyWith(
          button: const TextStyle(color: AppColors.accent),
        ),
  );

  // Contains the information about the dark theme
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.accentDark,
      background: AppColors.backgroundDark,
      brightness: Brightness.dark,
    ),
    primaryColor: AppColors.primaryDark,
    primaryColorLight: AppColors.primaryDark.withAlpha(150),
    splashColor: AppColors.backgroundDark,
    highlightColor: AppColors.backgroundDark,
    scaffoldBackgroundColor: const Color(0xFF303030),
    backgroundColor: AppColors.backgroundDark,
    toggleableActiveColor: AppColors.accentDark,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: _cursorColor),
    sliderTheme: SliderThemeData(
      thumbColor: AppColors.accentDark,
      activeTrackColor: AppColors.accentDark.withAlpha(180),
      activeTickMarkColor: AppColors.primaryDark,
      inactiveTrackColor: AppColors.accentDark.withAlpha(100),
      inactiveTickMarkColor: AppColors.primaryDark,
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      color: Color(0xFF303030),
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    indicatorColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accentDark,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: ThemeGuide.borderRadius,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.accentDark,
        backgroundColor: AppColors.accentDark.withAlpha(20),
        side: const BorderSide(width: 0, color: Colors.transparent),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      contentPadding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: AppColors.accentDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: AppColors.accentDark),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: Colors.red),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: Colors.transparent),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: Colors.transparent),
      ),
      errorMaxLines: 3,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w600,
      ),
      errorStyle: TextStyle(
        fontWeight: FontWeight.w600,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      highlightColor: AppColors.buttonHighlightColorDark,
      splashColor: AppColors.buttonSplashColorDark,
      disabledColor: AppColors.mDisabledColor,
      padding: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: ThemeGuide.borderRadius,
        side: BorderSide(
          width: 2,
          color: AppColors.accentDark,
        ),
      ),
    ),
    textTheme: ThemeData.dark().textTheme.copyWith(
          button: const TextStyle(color: AppColors.accentDark),
        ),
  );
}

abstract class LightTheme {
  static const Color mRed = Color(0xFFF58474);
  static const Color mPurple = Color(0xFF2B2E51);
  static const Color mLightPurple = Color(0xFF5F5186);
  static const Color mYellow = Color(0xFFF1AC71);
  static const Color mBlue = Color(0xFF93B4DF);
  static const Color mDisabledColor = Color(0xFFD2D2D2);
  static const IconThemeData mIconThemeData =
      IconThemeData(color: Colors.black);
  static const InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Color.fromRGBO(240, 240, 240, 1),
    border: InputBorder.none,
    hintStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
    prefixStyle: TextStyle(
      color: Colors.black54,
    ),
  );
}

abstract class DarkTheme {
  static const Color scaffoldBackgroundColor = Color(0xFF104056);
  static const Color headingTextColor = Colors.white;
  static const Color inActiveTextColor = Colors.white24;
  static const Color yellow = Color(0xFFFFB020);
  static const Color yellowShadow = Color(0xFFD7941D);
  static const Color blue = Color(0xFF4F67EC);
  static const Color blueShadow = Color(0xFF4053BD);
  static const Color greenishBlue = Color(0xFF42D3D4);
  static const Color lightRed = Color(0xFFF09A8A);
}
