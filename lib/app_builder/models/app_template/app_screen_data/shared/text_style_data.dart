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

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/material.dart';

import '../../../../utils.dart';

@immutable
class TextStyleData {
  final double fontSize;

  /// Values from 1-9
  final double fontWeight;
  final String? color;

  final TextAlign? alignment;

  const TextStyleData({
    this.fontSize = 14,
    this.fontWeight = 5,
    this.color,
    this.alignment,
  });

  Map<String, dynamic> toMap() {
    return {
      'fontSize': fontSize,
      'fontWeight': fontWeight,
      'color': color,
      'alignment': alignment?.name,
    };
  }

  factory TextStyleData.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return const TextStyleData();
    }

    return TextStyleData(
      fontSize: ModelUtils.createDoubleProperty(map['fontSize']),
      fontWeight: ModelUtils.createDoubleProperty(map['fontWeight']),
      color: ModelUtils.createStringProperty(map['color']),
      alignment: convertToTextAlign(map['alignment']),
    );
  }

  TextStyleData copyWith({
    double? fontSize,
    double? fontWeight,
  }) {
    return TextStyleData(
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      color: color,
      alignment: alignment,
    );
  }

  TextStyleData updateColor({
    String? color,
  }) {
    return TextStyleData(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      alignment: alignment,
    );
  }

  TextStyleData updateAlignment({
    TextAlign? alignment,
  }) {
    return TextStyleData(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      alignment: alignment,
    );
  }

  static FontWeight convertToFontWeight(double? val) {
    if (val == null) {
      return FontWeight.w500;
    }

    if (val == 1.0) {
      return FontWeight.w100;
    }
    if (val == 2.0) {
      return FontWeight.w200;
    }
    if (val == 3.0) {
      return FontWeight.w300;
    }
    if (val == 4.0) {
      return FontWeight.w400;
    }
    if (val == 5.0) {
      return FontWeight.w500;
    }
    if (val == 6.0) {
      return FontWeight.w600;
    }
    if (val == 7.0) {
      return FontWeight.w700;
    }
    if (val == 8.0) {
      return FontWeight.w800;
    }
    if (val == 9.0) {
      return FontWeight.w900;
    }

    // Else
    return FontWeight.w500;
  }

  static TextAlign? convertToTextAlign(String? val) {
    if (val == null) {
      return null;
    }

    if (val == 'left') {
      return TextAlign.left;
    }

    if (val == 'center') {
      return TextAlign.center;
    }

    if (val == 'end') {
      return TextAlign.end;
    }

    if (val == 'start') {
      return TextAlign.start;
    }

    if (val == 'justify') {
      return TextAlign.justify;
    }
    if (val == 'right') {
      return TextAlign.right;
    }

    // Else
    return null;
  }

  TextStyle createTextStyle({Color? forcedColor}) {
    return const TextStyle().copyWith(
      fontSize: fontSize,
      fontWeight: convertToFontWeight(fontWeight),
      color: HexColor.fromHex(color, forcedColor),
    );
  }

  FontWeight getFontWeight() => convertToFontWeight(fontWeight);
}
