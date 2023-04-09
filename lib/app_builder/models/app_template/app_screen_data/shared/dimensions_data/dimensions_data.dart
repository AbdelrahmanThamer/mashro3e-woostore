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

class DimensionsData {
  final double height;
  final double width;
  final double aspectRatio;

  const DimensionsData({
    this.height = 150,
    this.width = 150,
    this.aspectRatio = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'height': height,
      'width': width,
      'aspectRatio': aspectRatio,
    };
  }

  factory DimensionsData.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return const DimensionsData();
    }
    return DimensionsData(
      height: ModelUtils.createDoubleProperty(map['height'], 150),
      width: ModelUtils.createDoubleProperty(map['width'], 150),
      aspectRatio: ModelUtils.createDoubleProperty(map['aspectRatio'], 1),
    );
  }

  DimensionsData copyWith({
    double? height,
    double? width,
    double? aspectRatio,
  }) {
    return DimensionsData(
      height: height ?? this.height,
      width: width ?? this.width,
      aspectRatio: aspectRatio ?? this.aspectRatio,
    );
  }
}
