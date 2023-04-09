// Copyright (c) 2022 Aniket Malik [aniketmalikwork@gmail.com]
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
import 'package:quiver/strings.dart';

import '../constants/colors.dart';
import '../developer/dev.log.dart';

class HexColor extends Color {
  HexColor(final String hexString) : super(_getColorFromHex(hexString));

  HexColor.fromDynamicString(String hexString)
      : super(_getValueFromDynamicString(hexString));

  static int _getColorFromHex(String value) {
    String colorValue;
    if (colorNameToHex.containsKey(value)) {
      colorValue = colorNameToHex[value]!;
    } else {
      Dev.warn(
          'Color Value for $value could not be found. Please check that hex value for $value is present in colors.dart');
      return int.parse('FF000000', radix: 16);
    }
    try {
      colorValue = colorValue.toUpperCase().replaceAll('#', '');
      if (colorValue.length == 6) {
        colorValue = 'FF' + colorValue;
      }
      return int.parse(colorValue, radix: 16);
    } catch (e, s) {
      Dev.error('Error _getColorFromHex', error: e, stackTrace: s);
      return int.parse('FF000000', radix: 16);
    }
  }

  static int _getValueFromDynamicString(String? value) {
    if (value == null) {
      Dev.warn('Dynamic Color Value is null');
      return int.parse('FF000000', radix: 16);
    }
    try {
      String colorValue = value.toUpperCase().replaceAll('#', '');
      if (colorValue.length == 6) {
        colorValue = 'FF' + colorValue;
      }
      return int.parse(colorValue, radix: 16);
    } catch (e, s) {
      Dev.error('Error _getValueFromDynamicString', error: e, stackTrace: s);
      return int.parse('FF000000', radix: 16);
    }
  }

  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color? fromHex(String? hexString,
      [Color? defaultValue = Colors.transparent]) {
    if (hexString == null || isBlank(hexString)) {
      return defaultValue;
    }
    try {
      if (hexString.length == 8) {
        return Color(int.parse(hexString, radix: 16));
      }
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) {
        buffer.write('ff');
      }
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return defaultValue;
    }
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
