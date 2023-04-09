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

import '../../../../models.dart';

class VendorCardLayoutData {
  final StyledData styledData;

  // final DimensionsData dimensionsData;
  final VendorCardLayoutType layoutType;
  final bool showRating;

  const VendorCardLayoutData({
    this.styledData = const StyledData(
      borderRadius: 10,
      dimensionsData: DimensionsData(
        height: 250,
        width: 200,
      ),
    ),
    // this.dimensionsData = const DimensionsData(),
    this.layoutType = VendorCardLayoutType.originalWithBanner,
    this.showRating = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'styledData': styledData.toMap(),
      // 'dimensionsData': dimensionsData.toMap(),
      'layoutType': layoutType.name,
      'showRating': showRating,
    };
  }

  factory VendorCardLayoutData.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return const VendorCardLayoutData();
    }

    return VendorCardLayoutData(
      styledData: StyledData.fromMap(map['styledData']),
      // dimensionsData: DimensionsData.fromMap(map['dimensionsData']),
      layoutType: _getLayoutType(map['layoutType']),
      showRating: ModelUtils.createBoolProperty(map['showRating']),
    );
  }

  VendorCardLayoutData copyWith({
    StyledData? styledData,
    // DimensionsData? dimensionsData,
    VendorCardLayoutType? layoutType,
    bool? showRating,
  }) {
    return VendorCardLayoutData(
      styledData: styledData ?? this.styledData,
      // dimensionsData: dimensionsData ?? this.dimensionsData,
      layoutType: layoutType ?? this.layoutType,
      showRating: showRating ?? this.showRating,
    );
  }

  //**********************************************************
  // Helper
  //**********************************************************

  static VendorCardLayoutType _getLayoutType(String? val) {
    switch (val) {
      case 'original':
        return VendorCardLayoutType.original;
      case 'originalWithBanner':
        return VendorCardLayoutType.originalWithBanner;
      case 'horizontal':
        return VendorCardLayoutType.horizontal;
      case 'horizontalGradient':
        return VendorCardLayoutType.horizontalGradient;
      default:
        return VendorCardLayoutType.original;
    }
  }
}

enum VendorCardLayoutType {
  original,
  originalWithBanner,
  horizontal,
  horizontalGradient,
}
