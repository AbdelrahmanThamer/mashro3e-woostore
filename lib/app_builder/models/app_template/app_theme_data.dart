// Copyright (c) 2021 Aniket Malik [aniketmalikwork@gmail.com]
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

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils.dart';
import 'app_screen_data/shared/styled_data.dart';

@immutable
class AppThemesData {
  final AppLightThemeData lightThemeData;
  final AppDarkThemeData darkThemeData;

  const AppThemesData({
    this.lightThemeData = const AppLightThemeData(),
    this.darkThemeData = const AppDarkThemeData(),
  });

  Map<String, dynamic> toMap() {
    return {
      'lightThemeData': lightThemeData.toMap(),
      'darkThemeData': darkThemeData.toMap(),
    };
  }

  factory AppThemesData.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return const AppThemesData();
    }
    return AppThemesData(
      lightThemeData: AppLightThemeData.fromMap(map['lightThemeData']),
      darkThemeData: AppDarkThemeData.fromMap(map['darkThemeData']),
    );
  }

  AppThemesData copyWith({
    AppLightThemeData? lightThemeData,
    AppDarkThemeData? darkThemeData,
  }) {
    return AppThemesData(
      lightThemeData: lightThemeData ?? this.lightThemeData,
      darkThemeData: darkThemeData ?? this.darkThemeData,
    );
  }
}

@immutable
abstract class AppThemeData {
  const AppThemeData({
    required this.primaryColor,
    required this.onPrimaryColor,
    required this.secondaryColor,
    required this.onSecondaryColor,
    required this.errorColor,
    required this.onErrorColor,
    required this.scaffoldBackgroundColor,
    required this.backgroundColor,
    required this.appBarThemeData,
  });

  /// The Hex String values for the app colors
  final String primaryColor,
      onPrimaryColor,
      secondaryColor,
      onSecondaryColor,
      errorColor,
      onErrorColor,
      scaffoldBackgroundColor,
      backgroundColor;
  final AppBarThemeData appBarThemeData;

  Map<String, dynamic> toMap() {
    return {
      'primaryColor': primaryColor,
      'onPrimaryColor': onPrimaryColor,
      'secondaryColor': secondaryColor,
      'onSecondaryColor': onSecondaryColor,
      'errorColor': errorColor,
      'onErrorColor': onErrorColor,
      'scaffoldBackgroundColor': scaffoldBackgroundColor,
      'backgroundColor': backgroundColor,
      'appBarThemeData': appBarThemeData.toMap(),
    };
  }

  AppThemeData copyWith({
    String? primaryColor,
    String? onPrimaryColor,
    String? secondaryColor,
    String? onSecondaryColor,
    String? errorColor,
    String? onErrorColor,
    String? scaffoldBackgroundColor,
    String? backgroundColor,
    AppBarThemeData? appBarThemeData,
  });

  ThemeData createThemeData();
}

@immutable
class AppLightThemeData implements AppThemeData {
  const AppLightThemeData({
    this.primaryColor = 'FF20c4f4',
    this.onPrimaryColor = 'FFFFFFFF',
    this.secondaryColor = 'FF8191dd',
    this.onSecondaryColor = 'FFFFFFFF',
    this.errorColor = 'FFEC3B15',
    this.onErrorColor = 'FFFFFFFF',
    this.scaffoldBackgroundColor = 'FFEEEEEE',
    this.backgroundColor = 'FFFFFFFF',
    this.appBarThemeData = const AppBarThemeData(
      backgroundColor: 'FFEEEEEE',
      textStyleData: TextStyleData(
        fontWeight: 6,
        fontSize: 20,
      ),
    ),
  });

  /// The Hex String values for the app colors
  @override
  final String primaryColor,
      onPrimaryColor,
      secondaryColor,
      onSecondaryColor,
      errorColor,
      onErrorColor,
      scaffoldBackgroundColor,
      backgroundColor;

  @override
  final AppBarThemeData appBarThemeData;

  @override
  Map<String, dynamic> toMap() {
    return {
      'primaryColor': primaryColor,
      'onPrimaryColor': onPrimaryColor,
      'secondaryColor': secondaryColor,
      'onSecondaryColor': onSecondaryColor,
      'errorColor': errorColor,
      'onErrorColor': onErrorColor,
      'scaffoldBackgroundColor': scaffoldBackgroundColor,
      'backgroundColor': backgroundColor,
      'appBarThemeData': appBarThemeData.toMap(),
    };
  }

  factory AppLightThemeData.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return const AppLightThemeData();
    }

    return AppLightThemeData(
      primaryColor: ModelUtils.createStringProperty(map['primaryColor']),
      onPrimaryColor: ModelUtils.createStringProperty(map['onPrimaryColor']),
      secondaryColor: ModelUtils.createStringProperty(map['secondaryColor']),
      onSecondaryColor:
          ModelUtils.createStringProperty(map['onSecondaryColor']),
      errorColor: ModelUtils.createStringProperty(map['errorColor']),
      onErrorColor: ModelUtils.createStringProperty(map['onErrorColor']),
      scaffoldBackgroundColor:
          ModelUtils.createStringProperty(map['scaffoldBackgroundColor']),
      backgroundColor: ModelUtils.createStringProperty(map['backgroundColor']),
      appBarThemeData: AppBarThemeData.fromMap(map['appBarThemeData']),
    );
  }

  @override
  AppLightThemeData copyWith({
    String? primaryColor,
    String? onPrimaryColor,
    String? secondaryColor,
    String? onSecondaryColor,
    String? errorColor,
    String? onErrorColor,
    String? scaffoldBackgroundColor,
    String? backgroundColor,
    AppBarThemeData? appBarThemeData,
  }) {
    return AppLightThemeData(
      primaryColor: primaryColor ?? this.primaryColor,
      onPrimaryColor: onPrimaryColor ?? this.onPrimaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      onSecondaryColor: onSecondaryColor ?? this.onSecondaryColor,
      errorColor: errorColor ?? this.errorColor,
      onErrorColor: onErrorColor ?? this.onErrorColor,
      scaffoldBackgroundColor:
          scaffoldBackgroundColor ?? this.scaffoldBackgroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      appBarThemeData: appBarThemeData ?? this.appBarThemeData,
    );
  }

  @override
  ThemeData createThemeData() {
    return ThemeData.light().copyWith(
      colorScheme: const ColorScheme.light().copyWith(
        primary: HexColor.fromHex(primaryColor, null),
        onPrimary: HexColor.fromHex(onPrimaryColor, null),
        secondary: HexColor.fromHex(secondaryColor, null),
        onSecondary: HexColor.fromHex(onSecondaryColor, null),
        error: HexColor.fromHex(errorColor, null),
        onError: HexColor.fromHex(onErrorColor, null),
        background: HexColor.fromHex(backgroundColor, null),
        brightness: Brightness.light,
      ),
      backgroundColor: HexColor.fromHex(backgroundColor, null),
      scaffoldBackgroundColor: HexColor.fromHex(scaffoldBackgroundColor, null),
      appBarTheme: appBarThemeData.createThemeData(ThemeMode.light),
      cupertinoOverrideTheme: const CupertinoThemeData().copyWith(
        barBackgroundColor: HexColor.fromHex(scaffoldBackgroundColor, null),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: HexColor.fromHex(backgroundColor),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: ThemeGuide.borderRadius,
          borderSide: BorderSide(
            width: 2,
            color: HexColor.fromHex(errorColor, Colors.red)!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: ThemeGuide.borderRadius,
          borderSide: BorderSide(
            width: 2,
            color: HexColor.fromHex(primaryColor, Colors.transparent)!,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: ThemeGuide.borderRadius,
          borderSide: BorderSide(
            width: 2,
            color: HexColor.fromHex(errorColor, Colors.red)!,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: ThemeGuide.borderRadius,
          borderSide: BorderSide(width: 2, color: Colors.transparent),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: ThemeGuide.borderRadius,
          borderSide: BorderSide(width: 2, color: Colors.transparent),
        ),
        errorMaxLines: 3,
      ),
    );
  }
}

@immutable
class AppDarkThemeData implements AppThemeData {
  const AppDarkThemeData({
    this.primaryColor = 'FF20c4f4',
    this.onPrimaryColor = 'FFFFFFFF',
    this.secondaryColor = 'FF8191dd',
    this.onSecondaryColor = 'FFFFFFFF',
    this.errorColor = 'FFEC3B15',
    this.onErrorColor = 'FFFFFFFF',
    this.scaffoldBackgroundColor = 'FF161616',
    this.backgroundColor = 'FF0A0A0A',
    this.appBarThemeData = const AppBarThemeData(
      backgroundColor: 'FF161616',
      textStyleData: TextStyleData(
        fontWeight: 6,
        fontSize: 20,
      ),
    ),
  });

  const AppDarkThemeData.empty({
    this.primaryColor = '',
    this.onPrimaryColor = '',
    this.secondaryColor = '',
    this.onSecondaryColor = '',
    this.errorColor = '',
    this.onErrorColor = '',
    this.scaffoldBackgroundColor = '',
    this.backgroundColor = '',
    this.appBarThemeData = const AppBarThemeData(),
  });

  /// The Hex String values for the app colors
  @override
  final String primaryColor,
      onPrimaryColor,
      secondaryColor,
      onSecondaryColor,
      errorColor,
      onErrorColor,
      scaffoldBackgroundColor,
      backgroundColor;

  @override
  final AppBarThemeData appBarThemeData;

  @override
  Map<String, dynamic> toMap() {
    return {
      'primaryColor': primaryColor,
      'onPrimaryColor': onPrimaryColor,
      'secondaryColor': secondaryColor,
      'onSecondaryColor': onSecondaryColor,
      'errorColor': errorColor,
      'onErrorColor': onErrorColor,
      'scaffoldBackgroundColor': scaffoldBackgroundColor,
      'backgroundColor': backgroundColor,
      'appBarThemeData': appBarThemeData.toMap(),
    };
  }

  factory AppDarkThemeData.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return const AppDarkThemeData.empty();
    }

    return AppDarkThemeData(
      primaryColor: ModelUtils.createStringProperty(map['primaryColor']),
      onPrimaryColor: ModelUtils.createStringProperty(map['onPrimaryColor']),
      secondaryColor: ModelUtils.createStringProperty(map['secondaryColor']),
      onSecondaryColor:
          ModelUtils.createStringProperty(map['onSecondaryColor']),
      errorColor: ModelUtils.createStringProperty(map['errorColor']),
      onErrorColor: ModelUtils.createStringProperty(map['onErrorColor']),
      scaffoldBackgroundColor:
          ModelUtils.createStringProperty(map['scaffoldBackgroundColor']),
      backgroundColor: ModelUtils.createStringProperty(map['backgroundColor']),
      appBarThemeData: AppBarThemeData.fromMap(map['appBarThemeData']),
    );
  }

  @override
  AppDarkThemeData copyWith({
    String? primaryColor,
    String? onPrimaryColor,
    String? secondaryColor,
    String? onSecondaryColor,
    String? errorColor,
    String? onErrorColor,
    String? scaffoldBackgroundColor,
    String? backgroundColor,
    AppBarThemeData? appBarThemeData,
  }) {
    return AppDarkThemeData(
      primaryColor: primaryColor ?? this.primaryColor,
      onPrimaryColor: onPrimaryColor ?? this.onPrimaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      onSecondaryColor: onSecondaryColor ?? this.onSecondaryColor,
      errorColor: errorColor ?? this.errorColor,
      onErrorColor: onErrorColor ?? this.onErrorColor,
      scaffoldBackgroundColor:
          scaffoldBackgroundColor ?? this.scaffoldBackgroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      appBarThemeData: appBarThemeData ?? this.appBarThemeData,
    );
  }

  @override
  ThemeData createThemeData() {
    return ThemeData.dark().copyWith(
      colorScheme: const ColorScheme.dark().copyWith(
        primary: HexColor.fromHex(primaryColor, null),
        onPrimary: HexColor.fromHex(onPrimaryColor, null),
        secondary: HexColor.fromHex(secondaryColor, null),
        onSecondary: HexColor.fromHex(onSecondaryColor, null),
        error: HexColor.fromHex(errorColor, null),
        onError: HexColor.fromHex(onErrorColor, null),
        background: HexColor.fromHex(backgroundColor, null),
        brightness: Brightness.dark,
      ),
      backgroundColor: HexColor.fromHex(backgroundColor, null),
      scaffoldBackgroundColor: HexColor.fromHex(scaffoldBackgroundColor, null),
      appBarTheme: appBarThemeData.createThemeData(ThemeMode.dark),
      cupertinoOverrideTheme: const CupertinoThemeData().copyWith(
        barBackgroundColor: HexColor.fromHex(
          scaffoldBackgroundColor,
          Colors.transparent,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: HexColor.fromHex(backgroundColor),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: ThemeGuide.borderRadius,
          borderSide: BorderSide(
            width: 2,
            color: HexColor.fromHex(errorColor, Colors.red)!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: ThemeGuide.borderRadius,
          borderSide: BorderSide(
            width: 2,
            color: HexColor.fromHex(primaryColor, Colors.transparent)!,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: ThemeGuide.borderRadius,
          borderSide: BorderSide(
            width: 2,
            color: HexColor.fromHex(errorColor, Colors.red)!,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: ThemeGuide.borderRadius,
          borderSide: BorderSide(width: 2, color: Colors.transparent),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: ThemeGuide.borderRadius,
          borderSide: BorderSide(width: 2, color: Colors.transparent),
        ),
        errorMaxLines: 3,
      ),
    );
  }
}

class AppBarThemeData {
  final String? backgroundColor;
  final double elevation;
  final TextStyleData textStyleData;
  final IconStyleData iconStyleData;

  const AppBarThemeData({
    this.backgroundColor,
    this.elevation = 0,
    this.textStyleData = const TextStyleData(
      fontSize: 20,
      fontWeight: 6,
    ),
    this.iconStyleData = const IconStyleData(),
  });

  Map<String, dynamic> toMap() {
    return {
      'backgroundColor': backgroundColor,
      'elevation': elevation,
      'textStyleData': textStyleData.toMap(),
      'iconStyleData': iconStyleData.toMap(),
    };
  }

  factory AppBarThemeData.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return const AppBarThemeData();
    }
    return AppBarThemeData(
      backgroundColor: ModelUtils.createStringProperty(map['backgroundColor']),
      elevation: ModelUtils.createDoubleProperty(map['elevation'], 0),
      textStyleData: TextStyleData.fromMap(map['textStyleData']),
      iconStyleData: IconStyleData.fromMap(map['iconStyleData']),
    );
  }

  AppBarThemeData copyWith({
    double? elevation,
    TextStyleData? textStyleData,
    IconStyleData? iconStyleData,
  }) {
    return AppBarThemeData(
      backgroundColor: backgroundColor,
      elevation: elevation ?? this.elevation,
      textStyleData: textStyleData ?? this.textStyleData,
      iconStyleData: iconStyleData ?? this.iconStyleData,
    );
  }

  AppBarThemeData copyWithBackgroundColor(String? backgroundColor) {
    return AppBarThemeData(
      backgroundColor: backgroundColor,
      elevation: elevation,
      textStyleData: textStyleData,
      iconStyleData: iconStyleData,
    );
  }

  AppBarTheme createThemeData(ThemeMode themeMode) {
    return const AppBarTheme().copyWith(
      backgroundColor: HexColor.fromHex(backgroundColor, Colors.transparent),
      elevation: elevation,
      titleTextStyle: textStyleData.createTextStyle(
        forcedColor: themeMode == ThemeMode.dark ? Colors.white : Colors.black,
      ),
      iconTheme: iconStyleData.createIconThemeData(),
      systemOverlayStyle: themeMode == ThemeMode.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
    );
  }
}
