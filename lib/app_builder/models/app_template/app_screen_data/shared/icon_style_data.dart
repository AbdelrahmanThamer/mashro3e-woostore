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
class IconStyleData {
  final double fontSize;
  final String? color;

  const IconStyleData({
    this.fontSize = 24,
    this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'fontSize': fontSize,
      'color': color,
    };
  }

  factory IconStyleData.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return const IconStyleData();
    }

    return IconStyleData(
      fontSize: ModelUtils.createDoubleProperty(map['fontSize'], 24),
      color: ModelUtils.createStringProperty(map['color']),
    );
  }

  IconStyleData copyWith({
    double? fontSize,
  }) {
    return IconStyleData(
      fontSize: fontSize ?? this.fontSize,
      color: color,
    );
  }

  IconStyleData updateColor(String? color) {
    return IconStyleData(
      fontSize: fontSize,
      color: color,
    );
  }

  IconThemeData createIconThemeData() {
    return const IconThemeData().copyWith(
      size: fontSize,
      color: HexColor.fromHex(color, null),
    );
  }
}
