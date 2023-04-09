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

class PSPriceSectionData extends PSSectionData {
  final PSPriceSectionLayoutType sectionLayout;

  const PSPriceSectionData({
    required int id,
    this.sectionLayout = PSPriceSectionLayoutType.layout1,
    StyledData? styledData,
  }) : super(
          id: id,
          styledData: styledData ?? PSSectionData.defaultStyledData,
          sectionType: PSSectionType.price,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'sectionLayout': sectionLayout.name,
    };
  }

  factory PSPriceSectionData.fromMap(Map<String, dynamic> map) {
    return PSPriceSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      sectionLayout: convertStringToSectionLayout(map['sectionLayout']),
      styledData: StyledData.fromMap(map['styledData']),
    );
  }

  static PSPriceSectionLayoutType convertStringToSectionLayout(String? value) {
    if (isBlank(value)) {
      return PSPriceSectionLayoutType.layout1;
    }
    switch (value) {
      case 'layout1':
        return PSPriceSectionLayoutType.layout1;
      default:
        return PSPriceSectionLayoutType.layout1;
    }
  }

  @override
  PSPriceSectionData copyWith({
    PSPriceSectionLayoutType? sectionLayout,
    StyledData? styledData,
  }) {
    return PSPriceSectionData(
      id: id,
      sectionLayout: sectionLayout ?? this.sectionLayout,
      styledData: styledData ?? this.styledData,
    );
  }
}

enum PSPriceSectionLayoutType {
  layout1,
}
