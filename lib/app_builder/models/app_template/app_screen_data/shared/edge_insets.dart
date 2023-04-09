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

@immutable
class PaddingData {
  final double left;
  final double top;
  final double right;
  final double bottom;

  const PaddingData({
    this.left = 0,
    this.top = 0,
    this.right = 0,
    this.bottom = 0,
  });

  const PaddingData.all(double val)
      : left = val,
        top = val,
        right = val,
        bottom = val;

  Map<String, dynamic> toMap() {
    return {
      'left': left,
      'top': top,
      'right': right,
      'bottom': bottom,
    };
  }

  factory PaddingData.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return const PaddingData();
    }
    return PaddingData(
      left: ModelUtils.createDoubleProperty(map['left']),
      top: ModelUtils.createDoubleProperty(map['top']),
      right: ModelUtils.createDoubleProperty(map['right']),
      bottom: ModelUtils.createDoubleProperty(map['bottom']),
    );
  }

  PaddingData copyWith({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return PaddingData(
      left: left ?? this.left,
      top: top ?? this.top,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
    );
  }

  EdgeInsets createEdgeInsets() {
    return EdgeInsets.fromLTRB(left, top, right, bottom);
  }
}

@immutable
class MarginData {
  final double left;
  final double top;
  final double right;
  final double bottom;

  const MarginData({
    this.left = 0,
    this.top = 0,
    this.right = 0,
    this.bottom = 0,
  });

  const MarginData.all(double val)
      : left = val,
        top = val,
        right = val,
        bottom = val;

  Map<String, dynamic> toMap() {
    return {
      'left': left,
      'top': top,
      'right': right,
      'bottom': bottom,
    };
  }

  factory MarginData.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return const MarginData();
    }
    return MarginData(
      left: ModelUtils.createDoubleProperty(map['left']),
      top: ModelUtils.createDoubleProperty(map['top']),
      right: ModelUtils.createDoubleProperty(map['right']),
      bottom: ModelUtils.createDoubleProperty(map['bottom']),
    );
  }

  MarginData copyWith({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return MarginData(
      left: left ?? this.left,
      top: top ?? this.top,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
    );
  }

  EdgeInsets createEdgeInsets() {
    return EdgeInsets.fromLTRB(left, top, right, bottom);
  }
}
