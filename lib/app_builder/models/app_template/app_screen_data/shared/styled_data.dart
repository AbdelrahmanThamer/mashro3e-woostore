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

import '../../../utils.dart';
import 'dimensions_data/dimensions_data.dart';
import 'edge_insets.dart';
import 'text_style_data.dart';

export 'edge_insets.dart';
export 'icon_style_data.dart';
export 'text_style_data.dart';

@immutable
class StyledData {
  final PaddingData paddingData;
  final MarginData marginData;
  final TextStyleData textStyleData;
  final double borderRadius;
  final DimensionsData dimensionsData;

  /// Hex value for the color
  final String? backgroundColor;

  final double borderWidth;
  final String? borderColor;

  final BoxFit imageBoxFit;

  //<editor-fold desc="Data Methods">

  const StyledData({
    this.paddingData = const PaddingData(),
    this.marginData = const MarginData(),
    this.textStyleData = const TextStyleData(),
    this.backgroundColor,
    this.borderRadius = 0,
    this.borderWidth = 0,
    this.borderColor,
    this.dimensionsData = const DimensionsData(),
    this.imageBoxFit = BoxFit.cover,
  });

  StyledData copyWith({
    PaddingData? paddingData,
    MarginData? marginData,
    TextStyleData? textStyleData,
    double? borderRadius,
    double? borderWidth,
    DimensionsData? dimensionsData,
    BoxFit? imageBoxFit,
  }) {
    return StyledData(
      paddingData: paddingData ?? this.paddingData,
      marginData: marginData ?? this.marginData,
      textStyleData: textStyleData ?? this.textStyleData,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      dimensionsData: dimensionsData ?? this.dimensionsData,
      borderColor: borderColor,
      imageBoxFit: imageBoxFit ?? this.imageBoxFit,
    );
  }

  StyledData updateBackgroundColor({
    String? backgroundColor,
  }) {
    return StyledData(
      paddingData: paddingData,
      marginData: marginData,
      textStyleData: textStyleData,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      borderColor: borderColor,
      dimensionsData: dimensionsData,
      imageBoxFit: imageBoxFit,
    );
  }

  StyledData updateBorderColor(String? color) {
    return StyledData(
      paddingData: paddingData,
      marginData: marginData,
      textStyleData: textStyleData,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      borderColor: color,
      borderWidth: borderWidth,
      imageBoxFit: imageBoxFit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'paddingData': paddingData.toMap(),
      'marginData': marginData.toMap(),
      'textStyleData': textStyleData.toMap(),
      'backgroundColor': backgroundColor,
      'borderRadius': borderRadius,
      'dimensionsData': dimensionsData.toMap(),
      'imageBoxFit': imageBoxFit.name,
    };
  }

  factory StyledData.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return const StyledData();
    }
    return StyledData(
      paddingData: PaddingData.fromMap(map['paddingData']),
      marginData: MarginData.fromMap(map['marginData']),
      textStyleData: TextStyleData.fromMap(map['textStyleData']),
      backgroundColor: ModelUtils.createStringProperty(map['backgroundColor']),
      borderRadius: ModelUtils.createDoubleProperty(map['borderRadius'], 0),
      dimensionsData: DimensionsData.fromMap(map['dimensionsData']),
      imageBoxFit: EnumUtils.convertStringToBoxFit(map['imageBoxFit']),
    );
  }

//</editor-fold>
}
