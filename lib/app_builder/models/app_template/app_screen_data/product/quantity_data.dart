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

class PSQuantitySectionData extends PSSectionData {
  final PSQuantitySectionLayoutType sectionLayout;

  const PSQuantitySectionData({
    required int id,
    this.sectionLayout = PSQuantitySectionLayoutType.layout1,
    StyledData? styledData,
  }) : super(
          id: id,
          styledData: styledData ?? PSSectionData.defaultStyledData,
          sectionType: PSSectionType.quantity,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'sectionLayout': sectionLayout.name,
    };
  }

  factory PSQuantitySectionData.fromMap(Map<String, dynamic> map) {
    return PSQuantitySectionData(
      id: ModelUtils.createIntProperty(map['id']),
      sectionLayout: convertStringToSectionLayout(map['sectionLayout']),
      styledData: StyledData.fromMap(map['styledData']),
    );
  }

  static PSQuantitySectionLayoutType convertStringToSectionLayout(
      String? value) {
    if (isBlank(value)) {
      return PSQuantitySectionLayoutType.layout1;
    }
    switch (value) {
      case 'layout1':
        return PSQuantitySectionLayoutType.layout1;
      default:
        return PSQuantitySectionLayoutType.layout1;
    }
  }

  @override
  PSQuantitySectionData copyWith({
    PSQuantitySectionLayoutType? sectionLayout,
    StyledData? styledData,
  }) {
    return PSQuantitySectionData(
      id: id,
      sectionLayout: sectionLayout ?? this.sectionLayout,
      styledData: styledData ?? this.styledData,
    );
  }
}

enum PSQuantitySectionLayoutType {
  layout1,
}
