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

part of 'product.dart';

class PSVendorSectionData extends PSSectionData {
  final PSVendorSectionLayoutType sectionLayout;
  final double aspectRatio;

  const PSVendorSectionData({
    required int id,
    this.sectionLayout = PSVendorSectionLayoutType.originalWithBanner,
    this.aspectRatio = 2,
    StyledData? styledData = defaultStyledData,
  }) : super(
          id: id,
          styledData: styledData ?? PSSectionData.defaultStyledData,
          sectionType: PSSectionType.vendor,
        );

  static const defaultStyledData = StyledData(
    marginData: PSSectionData.defaultMarginData,
    borderRadius: 10,
    dimensionsData: DimensionsData(height: 500),
    textStyleData: TextStyleData(fontSize: 16, fontWeight: 6),
  );

  @override
  PSVendorSectionData copyWith({
    PSVendorSectionLayoutType? sectionLayout,
    double? aspectRatio,
    StyledData? styledData,
  }) {
    return PSVendorSectionData(
      id: id,
      sectionLayout: sectionLayout ?? this.sectionLayout,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      styledData: styledData ?? this.styledData,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'sectionLayout': sectionLayout.name,
      'aspectRatio': aspectRatio,
    };
  }

  factory PSVendorSectionData.fromMap(Map<String, dynamic> map) {
    return PSVendorSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      sectionLayout: getVendorLayout(map['sectionLayout']),
      aspectRatio: ModelUtils.createDoubleProperty(map['aspectRatio']),
      styledData: StyledData.fromMap(map['styledData']),
    );
  }

  static PSVendorSectionLayoutType getVendorLayout(String? layoutName) {
    switch (layoutName) {
      case 'original':
        return PSVendorSectionLayoutType.original;
      case 'originalWithBanner':
        return PSVendorSectionLayoutType.originalWithBanner;
      case 'horizontal':
        return PSVendorSectionLayoutType.horizontal;

      case 'horizontalGradient':
        return PSVendorSectionLayoutType.horizontalGradient;
      default:
        return PSVendorSectionLayoutType.original;
    }
  }
}

enum PSVendorSectionLayoutType {
  original,
  originalWithBanner,
  horizontal,
  horizontalGradient,
}
